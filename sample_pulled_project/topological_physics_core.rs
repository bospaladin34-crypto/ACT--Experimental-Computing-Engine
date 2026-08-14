// ============================================================================
// ACT-Ω TC-UFT Physics Compute Core (Absolute Zero Square Brackets)
// Based on: Topological Charge Unified Field Theory (TC-UFT)
// ============================================================================

use std::collections::HashMap;
use std::env;

pub struct TCUFTParameters {
    pub eta: f64,
    pub q0: i32,
    pub m_top: f64,
    pub lambda_e8: f64,
    pub gamma_g: f64,
    pub chi: f64,
    pub kappa: f64,
}

impl Default for TCUFTParameters {
    fn default() -> Self {
        TCUFTParameters {
            eta: 1e-4,
            q0: 1,
            m_top: 1.0,
            lambda_e8: 1000.0,
            gamma_g: 0.2,
            chi: 0.01,
            kappa: 1.0,
        }
    }
}

pub struct BraidMotif {
    pub word: Vec<i32>,
}

impl Clone for BraidMotif {
    fn clone(&self) -> Self {
        BraidMotif { word: self.word.clone() }
    }
}

impl BraidMotif {
    pub fn writhe(&self) -> i32 {
        self.word.iter().map(|&g| if g > 0 { 1 } else { -1 }).sum()
    }

    pub fn length(&self) -> usize {
        self.word.len()
    }

    pub fn generation(&self) -> usize {
        let len = self.word.len();
        if len == 0 { 1 } else { (len / 2).max(1) }
    }

    pub fn charge(&self, q0: i32) -> f64 {
        (q0 * self.writhe()) as f64
    }
}

pub struct E8Label {
    pub name: String,
    pub w0: i32, pub w1: i32, pub w2: i32, pub w3: i32,
    pub w4: i32, pub w5: i32, pub w6: i32, pub w7: i32,
}

impl Clone for E8Label {
    fn clone(&self) -> Self {
        E8Label {
            name: self.name.clone(),
            w0: self.w0, w1: self.w1, w2: self.w2, w3: self.w3,
            w4: self.w4, w5: self.w5, w6: self.w6, w7: self.w7,
        }
    }
}

pub struct ParticleState {
    pub name: String,
    pub braid: BraidMotif,
    pub e8: E8Label,
    pub sector: String,
}

impl Clone for ParticleState {
    fn clone(&self) -> Self {
        ParticleState {
            name: self.name.clone(),
            braid: self.braid.clone(),
            e8: self.e8.clone(),
            sector: self.sector.clone(),
        }
    }
}

impl ParticleState {
    pub fn charge(&self, q0: i32) -> f64 {
        self.braid.charge(q0)
    }
}

pub struct VertexResult {
    pub process_name: String,
    pub initial_particles: Vec<String>,
    pub final_particles: Vec<String>,
    pub delta_q: f64,
    pub kernel_weight: f64,
    pub landauer_heat: f64,
    pub effective_coupling: f64,
    pub metric_perturbation: f64,
    pub sheaf_status: String,
}

pub struct TCUFTPhysicsEngine {
    pub params: TCUFTParameters,
    pub catalog: HashMap<String, ParticleState>,
}

fn vec_1(a: i32) -> Vec<i32> {
    let mut v = Vec::new();
    v.push(a);
    v
}

fn vec_2(a: i32, b: i32) -> Vec<i32> {
    let mut v = Vec::new();
    v.push(a);
    v.push(b);
    v
}

fn vec_3(a: i32, b: i32, c: i32) -> Vec<i32> {
    let mut v = Vec::new();
    v.push(a);
    v.push(b);
    v.push(c);
    v
}

fn vec_6(a: i32, b: i32, c: i32, d: i32, e: i32, f: i32) -> Vec<i32> {
    let mut v = Vec::new();
    v.push(a); v.push(b); v.push(c);
    v.push(d); v.push(e); v.push(f);
    v
}

fn make_str_list_1(a: &str) -> Vec<String> {
    let mut v = Vec::new();
    v.push(a.to_string());
    v
}

fn make_str_list_2(a: &str, b: &str) -> Vec<String> {
    let mut v = Vec::new();
    v.push(a.to_string());
    v.push(b.to_string());
    v
}

impl TCUFTPhysicsEngine {
    pub fn new() -> Self {
        let params = TCUFTParameters::default();
        let mut catalog = HashMap::new();

        catalog.insert("u_L".to_string(), ParticleState {
            name: "Up Quark (Left)".to_string(),
            braid: BraidMotif { word: vec_2(1, 2) },
            e8: E8Label { name: "u_L".to_string(), w0: 1, w1: 0, w2: 0, w3: 0, w4: 0, w5: 0, w6: 0, w7: 0 },
            sector: "Quark".to_string(),
        });

        catalog.insert("d_L".to_string(), ParticleState {
            name: "Down Quark (Left)".to_string(),
            braid: BraidMotif { word: vec_2(2, 1) },
            e8: E8Label { name: "d_L".to_string(), w0: 0, w1: 1, w2: 0, w3: 0, w4: 0, w5: 0, w6: 0, w7: 0 },
            sector: "Quark".to_string(),
        });

        catalog.insert("e_L".to_string(), ParticleState {
            name: "Electron (Left)".to_string(),
            braid: BraidMotif { word: vec_2(-1, 1) },
            e8: E8Label { name: "e_L".to_string(), w0: 0, w1: 0, w2: 1, w3: 0, w4: 0, w5: 0, w6: 0, w7: 0 },
            sector: "Lepton".to_string(),
        });

        catalog.insert("e_R".to_string(), ParticleState {
            name: "Electron (Right)".to_string(),
            braid: BraidMotif { word: vec_2(-1, -1) },
            e8: E8Label { name: "e_R".to_string(), w0: 0, w1: 0, w2: 1, w3: 0, w4: 0, w5: 0, w6: 0, w7: 0 },
            sector: "Lepton".to_string(),
        });

        catalog.insert("tau_L".to_string(), ParticleState {
            name: "Tau Lepton (3rd Gen)".to_string(),
            braid: BraidMotif { word: vec_6(1, 1, 1, 1, 1, 1) },
            e8: E8Label { name: "tau_L".to_string(), w0: 0, w1: 0, w2: 3, w3: 0, w4: 0, w5: 0, w6: 0, w7: 0 },
            sector: "Lepton".to_string(),
        });

        catalog.insert("W_minus".to_string(), ParticleState {
            name: "W- Boson".to_string(),
            braid: BraidMotif { word: vec_3(-1, 2, 1) },
            e8: E8Label { name: "W-".to_string(), w0: 0, w1: -1, w2: 1, w3: 0, w4: 0, w5: 0, w6: 0, w7: 0 },
            sector: "GaugeBoson".to_string(),
        });

        catalog.insert("gamma".to_string(), ParticleState {
            name: "Photon".to_string(),
            braid: BraidMotif { word: vec_2(1, -1) },
            e8: E8Label { name: "gamma".to_string(), w0: 0, w1: 0, w2: 0, w3: 0, w4: 0, w5: 0, w6: 0, w7: 0 },
            sector: "GaugeBoson".to_string(),
        });

        catalog.insert("H".to_string(), ParticleState {
            name: "Higgs Boson".to_string(),
            braid: BraidMotif { word: Vec::new() },
            e8: E8Label { name: "H".to_string(), w0: 0, w1: 0, w2: 0, w3: 0, w4: 0, w5: 0, w6: 1, w7: 0 },
            sector: "Higgs".to_string(),
        });

        TCUFTPhysicsEngine { params, catalog }
    }

    pub fn calculate_kernel(&self, delta_q: f64) -> f64 {
        (-self.params.kappa * delta_q.abs()).exp()
    }

    pub fn evaluate_vertex(&self, in_keys: Vec<String>, out_keys: Vec<String>, process_name: &str) -> Option<VertexResult> {
        let mut in_parts = Vec::new();
        for k in &in_keys {
            if let Some(p) = self.catalog.get(k) {
                in_parts.push(p.clone());
            } else {
                return None;
            }
        }

        let mut out_parts = Vec::new();
        for k in &out_keys {
            if let Some(p) = self.catalog.get(k) {
                out_parts.push(p.clone());
            } else {
                return None;
            }
        }

        let q_in: f64 = in_parts.iter().map(|p| p.charge(self.params.q0)).sum();
        let q_out: f64 = out_parts.iter().map(|p| p.charge(self.params.q0)).sum();
        let delta_q = q_out - q_in;

        let kernel_weight = self.calculate_kernel(delta_q);

        let total_writhe: f64 = in_parts.iter().map(|p| p.braid.writhe().abs() as f64).sum();
        let max_gen: f64 = in_parts.iter().map(|p| p.braid.generation() as f64).fold(1.0, f64::max);
        let landauer_heat = total_writhe * (max_gen + 1.0).ln() * 0.693;

        let effective_coupling = 1.0 * (1.0 + self.params.eta * q_out);
        let metric_perturbation = self.params.eta * q_out;

        let sheaf_status = if landauer_heat < 2.5 && kernel_weight > 0.01 {
            "GLOBAL_SHEAF_COHERENT (STABLE)".to_string()
        } else {
            "SHEAF_ANOMALY (DECAY_INSTABILITY)".to_string()
        };

        Some(VertexResult {
            process_name: process_name.to_string(),
            initial_particles: in_keys,
            final_particles: out_keys,
            delta_q,
            kernel_weight,
            landauer_heat,
            effective_coupling,
            metric_perturbation,
            sheaf_status,
        })
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let mode_str = match args.get(1) {
        Some(s) => s.as_str(),
        None => "ew",
    };

    println!("============================================================");
    println!(" ACT-Omega v25.0 TC-UFT Physics Compute Engine");
    println!("============================================================");

    let engine = TCUFTPhysicsEngine::new();

    let res = match mode_str.to_lowercase().as_str() {
        "ew" => engine.evaluate_vertex(make_str_list_2("u_L", "W_minus"), make_str_list_1("d_L"), "Electroweak Charged Current (u_L + W- -> d_L)"),
        "yukawa" => engine.evaluate_vertex(make_str_list_2("e_L", "H"), make_str_list_1("e_R"), "Yukawa Chirality Flip (e_L + H -> e_R)"),
        "qed" => engine.evaluate_vertex(make_str_list_2("e_L", "gamma"), make_str_list_1("e_L"), "QED Neutral Vertex (e_L + gamma -> e_L)"),
        "tau_decay" => engine.evaluate_vertex(make_str_list_2("tau_L", "H"), make_str_list_1("e_R"), "Generational Tau Decay (3rd Gen -> 1st Gen)"),
        _ => engine.evaluate_vertex(make_str_list_2("u_L", "W_minus"), make_str_list_1("d_L"), "Electroweak Charged Current"),
    };

    if let Some(r) = res {
        println!("\n+ Process: {}", r.process_name);
        println!("------------------------------------------------------------");
        println!(" Input State       : {}", r.initial_particles.join(", "));
        println!(" Output State      : {}", r.final_particles.join(", "));
        println!(" Net Charge DeltaQ : {:.2}", r.delta_q);
        println!(" Kernel Weight K   : {:.4}", r.kernel_weight);
        println!(" Landauer Heat     : {:.4} units", r.landauer_heat);
        println!(" Effective Coupling: {:.6}", r.effective_coupling);
        println!(" Metric Shift dg00 : {:.2e}", r.metric_perturbation);
        println!("------------------------------------------------------------");
        println!(" Status            : {}", r.sheaf_status);
        println!("============================================================");
    }
}
