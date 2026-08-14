// ============================================================================
// ACT-Ω 45-Second Hardware Stress Engine with Instant Win32 Failsafe Stop
// Multi-Threaded FPU Stress + Immediate Interruption Control (Zero Crates)
// ============================================================================

#![allow(dead_code)]
#![allow(non_snake_case)]

use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
use std::sync::Arc;
use std::thread;
use std::time::{Duration, Instant};

static RUNNING_SIGNAL: AtomicBool = AtomicBool::new(true);

extern "system" {
    fn SetConsoleCtrlHandler(
        HandlerRoutine: Option<unsafe extern "system" fn(u32) -> i32>,
        Add: i32,
    ) -> i32;
}

unsafe extern "system" fn ctrl_handler(ctrl_type: u32) -> i32 {
    if ctrl_type == 0 || ctrl_type == 1 || ctrl_type == 2 {
        println!("\n\n[FAILSAFE TRIGGERED] Emergency Stop Signal Received! Terminating threads...");
        RUNNING_SIGNAL.store(false, Ordering::SeqCst);
        return 1;
    }
    0
}

fn cpu_vector_kernel(op_counter: Arc<AtomicU64>) {
    let mut vec_a = [1.61803398875f64; 16];
    let mut vec_b = [0.37600000000f64; 16];
    let mut local_ops: u64 = 0;

    while RUNNING_SIGNAL.load(Ordering::Relaxed) {
        for i in 0..16 {
            vec_a[i] = (vec_a[i] * vec_b[i] + 0.17259029f64).sin().abs();
            vec_b[i] = (vec_b[i] * vec_a[i] + 0.61803398f64).cos().abs();
        }
        local_ops += 32;

        if local_ops % 102400 == 0 {
            op_counter.fetch_add(102400, Ordering::Relaxed);
            local_ops = 0;
        }
    }
    op_counter.fetch_add(local_ops, Ordering::Relaxed);
}

fn ram_bandwidth_benchmark() -> f64 {
    let buffer_size = 256 * 1024 * 1024; // 256 MB Buffer
    let mut buffer: Vec<u8> = vec![0u8; buffer_size];
    
    let start = Instant::now();
    let duration = Duration::from_secs(10);
    let mut bytes_processed: u64 = 0;
    let mut step: usize = 0;

    while start.elapsed() < duration && RUNNING_SIGNAL.load(Ordering::Relaxed) {
        let val = (step & 0xFF) as u8;
        for i in (0..buffer_size).step_by(64) {
            buffer[i] = val;
        }
        bytes_processed += buffer_size as u64;
        step += 1;
    }

    let elapsed = start.elapsed().as_secs_f64();
    if elapsed > 0.001 {
        (bytes_processed as f64 / (1024.0 * 1024.0 * 1024.0)) / elapsed
    } else {
        0.0
    }
}

fn main() {
    println!("============================================================");
    println!(" [ACT-Ω v25.0] 45-Second Failsafe Stress & Benchmark Engine");
    println!(" [Failsafe Active] Press 'Ctrl + C' at any time to ABORT  ");
    println!("============================================================");

    unsafe {
        SetConsoleCtrlHandler(Some(ctrl_handler), 1);
    }

    let num_cpus = thread::available_parallelism().map(|n| n.get()).unwrap_or(8);
    println!("[+] Target Hardware Concurrency: {} Threads", num_cpus);

    let op_counter = Arc::new(AtomicU64::new(0));

    // ------------------------------------------------------------------------
    // PHASE 1: 35-SECOND CPU MULTI-THREADED VECTOR STRESS
    // ------------------------------------------------------------------------
    println!("\n[Phase 1/2] Initiating 35-Second CPU Multi-Threaded FPU Stress Test...");
    let mut handles = Vec::new();
    for _ in 0..num_cpus {
        let c_clone = Arc::clone(&op_counter);
        handles.push(thread::spawn(move || {
            cpu_vector_kernel(c_clone);
        }));
    }

    let stress_start = Instant::now();
    let mut aborted = false;

    for sec in 1..=35 {
        if !RUNNING_SIGNAL.load(Ordering::Relaxed) {
            aborted = true;
            break;
        }
        thread::sleep(Duration::from_secs(1));
        let total_ops = op_counter.load(Ordering::Relaxed);
        let gflops = (total_ops as f64 / 1_000_000_000.0) / sec as f64;
        print!("\r [+] Stress Test Running... {:02}/35s | Throughput: {:.2} GFLOPS", sec, gflops);
    }
    println!();

    if aborted {
        RUNNING_SIGNAL.store(false, Ordering::Relaxed);
        for handle in handles {
            handle.join().unwrap();
        }
        println!("\n[!] Execution Aborted safely by Failsafe Signal. Hardware threads stopped.");
        return;
    }

    RUNNING_SIGNAL.store(false, Ordering::Relaxed);
    for handle in handles {
        handle.join().unwrap();
    }

    let total_cpu_ops = op_counter.load(Ordering::Relaxed);
    let cpu_elapsed = stress_start.elapsed().as_secs_f64();
    let final_gflops = (total_cpu_ops as f64 / 1_000_000_000.0) / cpu_elapsed;

    // ------------------------------------------------------------------------
    // PHASE 2: 10-SECOND RAM BANDWIDTH BENCHMARK
    // ------------------------------------------------------------------------
    println!("\n[Phase 2/2] Initiating 10-Second Memory Bandwidth Benchmark...");
    RUNNING_SIGNAL.store(true, Ordering::Relaxed);
    let ram_gbps = ram_bandwidth_benchmark();

    // ------------------------------------------------------------------------
    // BENCHMARK REPORT SUMMARY
    // ------------------------------------------------------------------------
    let act_score = (final_gflops * 100.0) + (ram_gbps * 50.0);

    println!("\n============================================================");
    println!("          45-SECOND TOPOLOGICAL BENCHMARK REPORT            ");
    println!("============================================================");
    println!(" Total Floating-Point Operations : {} ops", total_cpu_ops);
    println!(" Sustained CPU Throughput       : {:.2} GFLOPS", final_gflops);
    println!(" Sustained RAM Bandwidth         : {:.2} GB/s", ram_gbps);
    println!("------------------------------------------------------------");
    println!(" ACT-Ω TOPOLOGICAL PERFORMANCE SCORE : {:.0} PTS", act_score);
    println!("============================================================");
}
