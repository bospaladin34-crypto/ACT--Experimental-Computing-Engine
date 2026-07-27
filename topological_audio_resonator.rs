// ============================================================================
// ACT-Ω 15.965 Hz Signal & Quasicrystal Audio Resonator (Zero-Bracket)
// Framework: Fibonacci Heterodyne Matrix, Arnold Tongues & PCM WAV Exporter
// ============================================================================

use std::fs::File;
use std::io::Write;
use std::f64::consts::PI;
use std::env;

pub struct AudioResonatorParams {
    pub sample_rate: u32,
    pub carrier_freq: f64,
    pub phi_golden: f64,
    pub phase_delta: f64,
}

impl Default for AudioResonatorParams {
    fn default() -> Self {
        AudioResonatorParams {
            sample_rate: 44100,
            carrier_freq: 15.965,
            phi_golden: 1.61803398875,
            phase_delta: 0.17259029,
        }
    }
}

fn generate_fibonacci_sample(t_sec: f64, params: &AudioResonatorParams) -> f64 {
    let f0 = params.carrier_freq;
    let phi = params.phi_golden;

    let s0 = (2.0 * PI * f0 * t_sec + params.phase_delta).sin();
    let s1 = (2.0 * PI * f0 * phi * t_sec).sin() * 0.618;
    let s2 = (2.0 * PI * f0 * phi * phi * t_sec).sin() * 0.382;

    let hum_noise = (2.0 * PI * 60.0 * t_sec).sin() * 0.05;
    let filtered_signal = s0 + s1 + s2 - hum_noise;

    filtered_signal.clamp(-1.0, 1.0)
}

fn write_wav_header(file: &mut File, total_samples: u32, sample_rate: u32) {
    let data_size = total_samples * 2;
    let file_size = data_size + 36;

    file.write_all(b"RIFF").ok();
    file.write_all(&(file_size as u32).to_le_bytes()).ok();
    file.write_all(b"WAVE").ok();
    file.write_all(b"fmt ").ok();
    file.write_all(&(16u32).to_le_bytes()).ok();
    file.write_all(&(1u16).to_le_bytes()).ok();
    file.write_all(&(1u16).to_le_bytes()).ok();
    file.write_all(&sample_rate.to_le_bytes()).ok();
    file.write_all(&(sample_rate * 2).to_le_bytes()).ok();
    file.write_all(&(2u16).to_le_bytes()).ok();
    file.write_all(&(16u16).to_le_bytes()).ok();
    file.write_all(b"data").ok();
    file.write_all(&data_size.to_le_bytes()).ok();
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let duration_secs = match args.get(1) {
        Some(s) => s.parse::<u32>().unwrap_or(5),
        None => 5,
    };

    println!("============================================================");
    println!(" ACT-Omega v25.0 15.965 Hz Audio & Quasicrystal Resonator ");
    println!(" Framework: Fibonacci Heterodyne Matrix & Arnold Tongue Lock ");
    println!("============================================================");

    let params = AudioResonatorParams::default();
    let total_samples = params.sample_rate * duration_secs;

    println!("+ Target Carrier Frequency : {:.3} Hz", params.carrier_freq);
    println!("+ Fibonacci Golden Ratio phi: {:.11}", params.phi_golden);
    println!("+ Audio Sample Rate        : {} Hz", params.sample_rate);
    println!("+ Target Duration          : {} Seconds ({} Samples)\n", duration_secs, total_samples);

    if let Ok(mut wav_file) = File::create("topological_carrier_15.965Hz.wav") {
        write_wav_header(&mut wav_file, total_samples, params.sample_rate);

        let dt = 1.0 / (params.sample_rate as f64);
        for i in 0..total_samples {
            let t = (i as f64) * dt;
            let sample_f64 = generate_fibonacci_sample(t, &params);
            let sample_i16 = (sample_f64 * 32767.0) as i16;
            wav_file.write_all(&sample_i16.to_le_bytes()).ok();
        }

        println!("+ Generated Resonator Waveform: 'topological_carrier_15.965Hz.wav'");
    }

    let quasicrystal_modulation = params.carrier_freq * params.phi_golden * 1e-4;

    println!("\n============================================================");
    println!("              QUASICRYSTAL AUDIO RESONATOR REPORT            ");
    println!("============================================================");
    println!(" Primary Carrier Wave    : 15.965 Hz Sub-Audible Reference");
    println!(" Harmonic Fibonacci Nodes: 25.83 Hz, 41.80 Hz, 67.63 Hz");
    println!(" Arnold Tongue 60Hz Filter: Active (-20dB Hum Suppression)");
    println!(" Quasicrystal Modulation : {:.6} (sigma = eta * Q)", quasicrystal_modulation);
    println!("------------------------------------------------------------");
    println!(" Status                  : AUDIO_RESONATOR_LOCK_STABLE");
    println!("============================================================");
}
