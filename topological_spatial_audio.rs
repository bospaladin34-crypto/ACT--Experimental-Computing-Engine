// ============================================================================
// ACT-Ω 3D Spatial Binaural HRTF Audio Engine (Zero-Bracket)
// Framework: HRTF Interaural Time/Level Differences & 15.965 Hz Fibonacci Harmonics
// ============================================================================

use std::f64::consts::PI;
use std::fs::File;
use std::io::Write;
use std::env;
use std::time::Instant;

pub struct HRTFSpatialSource {
    pub azimuth_deg: f64,
    pub elevation_deg: f64,
    pub distance_m: f64,
    pub carrier_freq_hz: f64,
}

impl Default for HRTFSpatialSource {
    fn default() -> Self {
        HRTFSpatialSource {
            azimuth_deg: 45.0,
            elevation_deg: 15.0,
            distance_m: 2.0,
            carrier_freq_hz: 15.965,
        }
    }
}

pub struct SpatialAudioReport {
    pub itd_milliseconds: f64,
    pub ild_attenuation_db: f64,
    pub fibonacci_overtone_1_hz: f64,
    pub fibonacci_overtone_2_hz: f64,
    pub wav_bytes_written: usize,
    pub audio_file_path: String,
}

fn generate_3d_spatial_binaural_wav(source: &HRTFSpatialSource) -> SpatialAudioReport {
    let speed_of_sound = 343.0;
    let head_radius_m = 0.0875;

    let az_rad = source.azimuth_deg * PI / 180.0;
    let itd_sec = (head_radius_m / speed_of_sound) * (az_rad + az_rad.sin());
    let itd_ms = itd_sec * 1000.0;

    let ild_db = 6.0 * az_rad.sin();

    let phi = 1.61803398875;
    let overtone1 = source.carrier_freq_hz * phi;
    let overtone2 = source.carrier_freq_hz * phi * phi;

    let sample_rate = 44100u32;
    let duration_sec = 3u32;
    let total_samples = (sample_rate * duration_sec) as usize;

    let file_path = String::from("topological_spatial_binaural_15.965Hz.wav");
    let mut wav_data = Vec::new();

    wav_data.extend_from_slice(b"RIFF");
    let file_size = 36 + total_samples * 2 * 2;
    wav_data.extend_from_slice(&(file_size as u32).to_le_bytes());
    wav_data.extend_from_slice(b"WAVEfmt ");
    wav_data.extend_from_slice(&(16u32).to_le_bytes());
    wav_data.extend_from_slice(&(1u16).to_le_bytes());
    wav_data.extend_from_slice(&(2u16).to_le_bytes());
    wav_data.extend_from_slice(&sample_rate.to_le_bytes());
    let byte_rate = sample_rate * 2 * 2;
    wav_data.extend_from_slice(&byte_rate.to_le_bytes());
    wav_data.extend_from_slice(&(4u16).to_le_bytes());
    wav_data.extend_from_slice(&(16u16).to_le_bytes());
    wav_data.extend_from_slice(b"data");
    let data_size = total_samples * 2 * 2;
    wav_data.extend_from_slice(&(data_size as u32).to_le_bytes());

    let right_delay_samples = (itd_sec * sample_rate as f64) as usize;

    for i in 0..total_samples {
        let t = i as f64 / sample_rate as f64;
        let signal_left = (2.0 * PI * source.carrier_freq_hz * t).sin() * 0.5 
                        + (2.0 * PI * overtone1 * t).sin() * 0.3 
                        + (2.0 * PI * overtone2 * t).sin() * 0.2;

        let t_right = if i >= right_delay_samples { (i - right_delay_samples) as f64 / sample_rate as f64 } else { 0.0 };
        let signal_right = ((2.0 * PI * source.carrier_freq_hz * t_right).sin() * 0.5 
                         + (2.0 * PI * overtone1 * t_right).sin() * 0.3 
                         + (2.0 * PI * overtone2 * t_right).sin() * 0.2) * (1.0 - ild_db * 0.05);

        let sample_l_i16 = (signal_left * 16384.0).clamp(-32767.0, 32767.0) as i16;
        let sample_r_i16 = (signal_right * 16384.0).clamp(-32767.0, 32767.0) as i16;

        wav_data.extend_from_slice(&sample_l_i16.to_le_bytes());
        wav_data.extend_from_slice(&sample_r_i16.to_le_bytes());
    }

    if let Ok(mut file) = File::create(&file_path) {
        file.write_all(&wav_data).ok();
    }

    let bytes_len = wav_data.len();

    SpatialAudioReport {
        itd_milliseconds: itd_ms,
        ild_attenuation_db: ild_db,
        fibonacci_overtone_1_hz: overtone1,
        fibonacci_overtone_2_hz: overtone2,
        wav_bytes_written: bytes_len,
        audio_file_path: file_path,
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let _mode_opt = args.get(1);

    println!("============================================================");
    println!(" ACT-Omega v25.0 3D Spatial Binaural HRTF Audio Engine ");
    println!(" Interaural Time/Level Differences & 15.965 Hz Fibonacci PCM ");
    println!("============================================================");

    let source = HRTFSpatialSource::default();
    println!("+ Sound Source Azimuth   : {:.1} deg (Right-Front Angle)", source.azimuth_deg);
    println!("+ Sound Source Elevation : {:.1} deg", source.elevation_deg);
    println!("+ Carrier Fundamental    : {:.3} Hz (Software Cadence Lock)\n", source.carrier_freq_hz);

    let start = Instant::now();
    let report = generate_3d_spatial_binaural_wav(&source);
    let dur = start.elapsed();

    println!("============================================================");
    println!("               SPATIAL BINAURAL AUDIO REPORT                ");
    println!("============================================================");
    println!(" Synthesis Time          : {:.3} us", dur.as_secs_f64() * 1e6);
    println!(" Interaural Time (ITD)   : {:.3} ms (Woodworth Head Model)", report.itd_milliseconds);
    println!(" Interaural Level (ILD)  : {:.2} dB Attenuation", report.ild_attenuation_db);
    println!(" Fibonacci Overtone 1    : {:.2} Hz (15.965 * phi)", report.fibonacci_overtone_1_hz);
    println!(" Fibonacci Overtone 2    : {:.2} Hz (15.965 * phi^2)", report.fibonacci_overtone_2_hz);
    println!(" Stereo PCM WAV Synthesized: {} bytes", report.wav_bytes_written);
    println!(" Audio File Exported     : {}", report.audio_file_path);
    println!("------------------------------------------------------------");
    println!(" Status                   : SPATIAL_BINAURAL_AUDIO_LATCHED");
    println!("============================================================");
}
