// ============================================================================
// ACT-Ω 30-Second Hardware Stress Test & Topological Benchmark Utility
// Multi-Threaded FPU Matrix Vector Stress & RAM Bandwidth Benchmark
// ============================================================================

#![allow(dead_code)]

use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
use std::sync::Arc;
use std::thread;
use std::time::{Duration, Instant};

fn cpu_vector_kernel(running: Arc<AtomicBool>, op_counter: Arc<AtomicU64>) {
    let mut vec_a = [1.61803398875f64; 16];
    let mut vec_b = [0.37600000000f64; 16];
    let mut local_ops: u64 = 0;

    while running.load(Ordering::Relaxed) {
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
    let buffer_size = 256 * 1024 * 1024; // 256 MB
    let mut buffer: Vec<u8> = vec![0u8; buffer_size];
    
    let start = Instant::now();
    let duration = Duration::from_secs(10);
    let mut bytes_processed: u64 = 0;
    let mut step: usize = 0;

    while start.elapsed() < duration {
        let val = (step & 0xFF) as u8;
        for i in (0..buffer_size).step_by(64) {
            buffer[i] = val;
        }
        bytes_processed += buffer_size as u64;
        step += 1;
    }

    let elapsed = start.elapsed().as_secs_f64();
    (bytes_processed as f64 / (1024.0 * 1024.0 * 1024.0)) / elapsed
}

fn main() {
    println!("============================================================");
    println!(" [ACT-Ω v25.0] 30-Second Hardware Stress & Benchmark Engine ");
    println!("============================================================");

    let num_cpus = thread::available_parallelism().map(|n| n.get()).unwrap_or(8);
    println!("[+] Target Hardware Concurrency: {} Threads", num_cpus);

    // ------------------------------------------------------------------------
    // PHASE 1: 20-SECOND CPU MULTI-THREADED VECTOR STRESS
    // ------------------------------------------------------------------------
    println!("\n[Phase 1/2] Initiating 20-Second CPU Multi-Threaded FPU Stress Test...");
    let running = Arc::new(AtomicBool::new(true));
    let op_counter = Arc::new(AtomicU64::new(0));

    let mut handles = Vec::new();
    for _ in 0..num_cpus {
        let r_clone = Arc::clone(&running);
        let c_clone = Arc::clone(&op_counter);
        handles.push(thread::spawn(move || {
            cpu_vector_kernel(r_clone, c_clone);
        }));
    }

    let stress_start = Instant::now();
    for sec in 1..=20 {
        thread::sleep(Duration::from_secs(1));
        let total_ops = op_counter.load(Ordering::Relaxed);
        let gflops = (total_ops as f64 / 1_000_000_000.0) / sec as f64;
        print!("\r [+] Stress Test Running... {:02}/20s | Throughput: {:.2} GFLOPS", sec, gflops);
    }
    println!();

    running.store(false, Ordering::Relaxed);
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
    let ram_gbps = ram_bandwidth_benchmark();

    // ------------------------------------------------------------------------
    // BENCHMARK REPORT SUMMARY
    // ------------------------------------------------------------------------
    let act_score = (final_gflops * 100.0) + (ram_gbps * 50.0);

    println!("\n============================================================");
    println!("               TOPOLOGICAL BENCHMARK REPORT                 ");
    println!("============================================================");
    println!(" Total Floating-Point Operations : {} ops", total_cpu_ops);
    println!(" Sustained CPU Throughput       : {:.2} GFLOPS", final_gflops);
    println!(" Sustained RAM Bandwidth         : {:.2} GB/s", ram_gbps);
    println!("------------------------------------------------------------");
    println!(" ACT-Ω TOPOLOGICAL PERFORMANCE SCORE : {:.0} PTS", act_score);
    println!("============================================================");
}
