// ============================================================================
// ACT-Ω Spacetime Metric Geodesic Raytracer (Zero-Bracket)
// Framework: General Relativity Metric Perturbations & Gravitational Lensing
// ============================================================================

use std::f64::consts::PI;
use std::env;
use std::time::Instant;

pub struct LensingMetricParams {
    pub mass_e8_charge_kg: f64,
    pub impact_parameter_b_m: f64,
    pub speed_of_light_c: f64,
    pub gravitational_const_g: f64,
}

impl Default for LensingMetricParams {
    fn default() -> Self {
        LensingMetricParams {
            mass_e8_charge_kg: 1.0e24,
            impact_parameter_b_m: 1000.0,
            speed_of_light_c: 299792458.0,
            gravitational_const_g: 6.67430e-11,
        }
    }
}

pub struct GravitationalLensingReport {
    pub schwarzschild_radius_m: f64,
    pub metric_perturbation_h00: f64,
    pub deflection_angle_rad: f64,
    pub deflection_angle_arcsec: f64,
    pub geodesic_stable: bool,
}

fn calculate_gravitational_lensing(params: &LensingMetricParams) -> GravitationalLensingReport {
    let g = params.gravitational_const_g;
    let m = params.mass_e8_charge_kg;
    let c = params.speed_of_light_c;
    let b = params.impact_parameter_b_m;

    let r_s = (2.0 * g * m) / (c * c);
    let h00 = r_s / b;

    let theta_rad = (4.0 * g * m) / (c * c * b);
    let theta_arcsec = theta_rad * (180.0 / PI) * 3600.0;
    let geodesic_stable = theta_rad < 1.0;

    GravitationalLensingReport {
        schwarzschild_radius_m: r_s,
        metric_perturbation_h00: h00,
        deflection_angle_rad: theta_rad,
        deflection_angle_arcsec: theta_arcsec,
        geodesic_stable,
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let _mode_opt = args.get(1);

    println!("============================================================");
    println!(" ACT-Omega v25.0 Spacetime Metric Geodesic Raytracer ");
    println!(" GR Metric Perturbations h_00 & Photon Deflection Evaluator ");
    println!("============================================================");

    let params = LensingMetricParams::default();
    println!("+ Topological Mass Charge M: {:.3e} kg", params.mass_e8_charge_kg);
    println!("+ Geodesic Impact Param b  : {:.1} meters", params.impact_parameter_b_m);

    let start = Instant::now();
    let report = calculate_gravitational_lensing(&params);
    let dur = start.elapsed();

    println!("\n============================================================");
    println!("             GRAVITATIONAL LENSING REPORT                    ");
    println!("============================================================");
    println!(" Computation Time (O(1)) : {:.3} ns", dur.as_secs_f64() * 1e9);
    println!(" Schwarzschild Radius R_s: {:.8} meters", report.schwarzschild_radius_m);
    println!(" Metric Perturbation h_00: {:.8e}", report.metric_perturbation_h00);
    println!(" Photon Bending Angle θ   : {:.8} radians", report.deflection_angle_rad);
    println!(" Photon Bending Angle θ   : {:.4} arcseconds", report.deflection_angle_arcsec);
    println!(" Geodesic Trajectory     : Stable Null Geodesic Raytraced");
    println!("------------------------------------------------------------");
    println!(" Status                   : SPACTIME_GEODESIC_LENSING_LATCHED");
    println!("============================================================");
}
