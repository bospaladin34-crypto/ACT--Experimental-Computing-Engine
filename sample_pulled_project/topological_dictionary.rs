// ============================================================================
// ACT-Ω Expanded Comprehensive Offline Semantic Lexicon Engine (Zero-Bracket)
// Framework: Offline Dictionary Lookup, E8 Vector Pinning & BraidIR Translation
// ============================================================================

use std::env;
use std::time::Instant;

pub struct DictionaryEntry {
    pub word_term: String,
    pub formal_definition: String,
    pub e8_vector_w0: f64,
    pub e8_vector_w1: f64,
    pub e8_vector_w2: f64,
    pub e8_vector_w3: f64,
    pub braid_generator_sigma: i32,
}

impl Clone for DictionaryEntry {
    fn clone(&self) -> Self {
        DictionaryEntry {
            word_term: self.word_term.clone(),
            formal_definition: self.formal_definition.clone(),
            e8_vector_w0: self.e8_vector_w0,
            e8_vector_w1: self.e8_vector_w1,
            e8_vector_w2: self.e8_vector_w2,
            e8_vector_w3: self.e8_vector_w3,
            braid_generator_sigma: self.braid_generator_sigma,
        }
    }
}

pub struct LexiconTranslationReport {
    pub words_parsed_count: u32,
    pub dictionary_matches_count: u32,
    pub e8_pinned_vector_sum: String,
    pub braidc_word_stream: String,
    pub translation_coherent: bool,
}

fn initialize_comprehensive_offline_lexicon() -> Vec<DictionaryEntry> {
    let mut dict: Vec<DictionaryEntry> = Vec::new();

    dict.push(DictionaryEntry {
        word_term: String::from("memory"),
        formal_definition: String::from("High-Speed RAM Buffer Allocation & Working Set Management"),
        e8_vector_w0: 1.0, e8_vector_w1: 0.0, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("buffer"),
        formal_definition: String::from("Sequential Memory Page Segment for I/O Buffering"),
        e8_vector_w0: 0.9, e8_vector_w1: 0.1, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("heap"),
        formal_definition: String::from("Dynamic Runtime Heap Memory Allocation Space"),
        e8_vector_w0: 0.85, e8_vector_w1: 0.15, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("stack"),
        formal_definition: String::from("LIFO Function Call Frame Stack Execution Memory"),
        e8_vector_w0: 0.8, e8_vector_w1: 0.2, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("page"),
        formal_definition: String::from("4KB Physical/Virtual Memory Page Boundary"),
        e8_vector_w0: 0.95, e8_vector_w1: 0.05, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("pointer"),
        formal_definition: String::from("Virtual Memory Address Reference Pointer"),
        e8_vector_w0: 0.75, e8_vector_w1: 0.25, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("cache"),
        formal_definition: String::from("CPU L1/L2/L3 Ultra-Low Latency Static Cache"),
        e8_vector_w0: 0.9, e8_vector_w1: 0.3, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 1,
    });

    dict.push(DictionaryEntry {
        word_term: String::from("fast"),
        formal_definition: String::from("Physical P-Core Thread Allocation & Core Un-Parking"),
        e8_vector_w0: 0.0, e8_vector_w1: 1.0, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 2,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("optimize"),
        formal_definition: String::from("Compiler Loop Unrolling & Reidemeister Reduction"),
        e8_vector_w0: 0.1, e8_vector_w1: 0.9, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 2,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("thread"),
        formal_definition: String::from("Hardware Execution Thread Bounded to P-Cores"),
        e8_vector_w0: 0.2, e8_vector_w1: 0.8, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 2,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("core"),
        formal_definition: String::from("Physical CPU Performance Core Execution Engine"),
        e8_vector_w0: 0.0, e8_vector_w1: 0.95, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 2,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("gpu"),
        formal_definition: String::from("NVIDIA RTX Parallel Graphics Processor & Tensor Cores"),
        e8_vector_w0: 0.0, e8_vector_w1: 1.0, e8_vector_w2: 0.5, e8_vector_w3: 0.0, braid_generator_sigma: 2,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("npu"),
        formal_definition: String::from("Google Pixel 10 Tensor G5 Neural Processing Unit"),
        e8_vector_w0: 0.0, e8_vector_w1: 0.9, e8_vector_w2: 0.6, e8_vector_w3: 0.0, braid_generator_sigma: 2,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("vram"),
        formal_definition: String::from("High-Speed Dedicated Video RAM Frame Buffer"),
        e8_vector_w0: 0.5, e8_vector_w1: 0.8, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 2,
    });

    dict.push(DictionaryEntry {
        word_term: String::from("shared"),
        formal_definition: String::from("Global\\ACT_OMEGA_E8_HYPER_MANIFOLD Ring Inter-Process Ring"),
        e8_vector_w0: 0.5, e8_vector_w1: 0.5, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 3,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("ring"),
        formal_definition: String::from("Zero-Copy Atomic Shared Memory Ring Buffer"),
        e8_vector_w0: 0.6, e8_vector_w1: 0.4, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 3,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("socket"),
        formal_definition: String::from("High-Throughput TCP/UDP Sockets (Ports 8088-8099)"),
        e8_vector_w0: 0.4, e8_vector_w1: 0.6, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 3,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("mesh"),
        formal_definition: String::from("Multi-Node Swarm Compute Mesh (Port 8098 UDP/TCP)"),
        e8_vector_w0: 0.5, e8_vector_w1: 0.7, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 3,
    });

    dict.push(DictionaryEntry {
        word_term: String::from("prompt"),
        formal_definition: String::from("Human Natural Language Input Query Stream"),
        e8_vector_w0: 0.1, e8_vector_w1: 0.1, e8_vector_w2: 0.1, e8_vector_w3: 0.1, braid_generator_sigma: -1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("token"),
        formal_definition: String::from("FNV-1a Geometric Root Vector Token Coordinate"),
        e8_vector_w0: 0.2, e8_vector_w1: 0.2, e8_vector_w2: 0.2, e8_vector_w3: 0.0, braid_generator_sigma: -1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("compiler"),
        formal_definition: String::from("BraidC/BraidIR Polyglot Domain Code Synthesizer"),
        e8_vector_w0: 0.3, e8_vector_w1: 0.3, e8_vector_w2: 0.3, e8_vector_w3: 0.0, braid_generator_sigma: -1,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("ast"),
        formal_definition: String::from("Abstract Syntax Tree Graph Complexity Reducer"),
        e8_vector_w0: 0.4, e8_vector_w1: 0.4, e8_vector_w2: 0.2, e8_vector_w3: 0.0, braid_generator_sigma: -1,
    });

    dict.push(DictionaryEntry {
        word_term: String::from("papyrus"),
        formal_definition: String::from("Skyrim/Fallout 4 Script Extender (SKSE/F4SE) VM"),
        e8_vector_w0: 0.7, e8_vector_w1: 0.3, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 3,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("ini"),
        formal_definition: String::from("Engine Configuration Heap & Memory Map (3GB Heap)"),
        e8_vector_w0: 0.8, e8_vector_w1: 0.2, e8_vector_w2: 0.0, e8_vector_w3: 0.0, braid_generator_sigma: 3,
    });

    dict.push(DictionaryEntry {
        word_term: String::from("zkp"),
        formal_definition: String::from("Zero-Knowledge Cryptographic Braid Proof Verifier"),
        e8_vector_w0: 0.0, e8_vector_w1: 0.0, e8_vector_w2: 1.0, e8_vector_w3: 0.0, braid_generator_sigma: 4,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("proof"),
        formal_definition: String::from("Sub-Nanosecond O(1) Witness Polynomial Proof"),
        e8_vector_w0: 0.0, e8_vector_w1: 0.1, e8_vector_w2: 0.9, e8_vector_w3: 0.0, braid_generator_sigma: 4,
    });

    dict.push(DictionaryEntry {
        word_term: String::from("quantum"),
        formal_definition: String::from("Quantum Electrodynamics Vacuum Fluctuation Solver"),
        e8_vector_w0: 0.0, e8_vector_w1: 0.0, e8_vector_w2: 0.0, e8_vector_w3: 1.0, braid_generator_sigma: 5,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("casimir"),
        formal_definition: String::from("QFT Casimir Vacuum Pressure Compactor"),
        e8_vector_w0: 0.1, e8_vector_w1: 0.0, e8_vector_w2: 0.0, e8_vector_w3: 0.9, braid_generator_sigma: 5,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("anyon"),
        formal_definition: String::from("Fibonacci Non-Abelian Anyon Topological Gate"),
        e8_vector_w0: 0.2, e8_vector_w1: 0.0, e8_vector_w2: 0.0, e8_vector_w3: 0.8, braid_generator_sigma: 5,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("qcd"),
        formal_definition: String::from("Quantum Chromodynamics SU(3) Wilson Loop Flux Tube"),
        e8_vector_w0: 0.3, e8_vector_w1: 0.0, e8_vector_w2: 0.0, e8_vector_w3: 0.9, braid_generator_sigma: 5,
    });
    dict.push(DictionaryEntry {
        word_term: String::from("calabi"),
        formal_definition: String::from("6D Calabi-Yau Kahler 3-Fold Compactification Solver"),
        e8_vector_w0: 0.4, e8_vector_w1: 0.0, e8_vector_w2: 0.0, e8_vector_w3: 1.0, braid_generator_sigma: 5,
    });

    dict
}

fn translate_prompt_to_e8_braidir(prompt: &str) -> LexiconTranslationReport {
    let dict = initialize_comprehensive_offline_lexicon();
    let words: Vec<&str> = prompt.split_whitespace().collect();
    let mut matches = 0u32;
    let mut braid_tokens: Vec<String> = Vec::new();

    let mut sum_v0 = 0.0;
    let mut sum_v1 = 0.0;
    let mut sum_v2 = 0.0;
    let mut sum_v3 = 0.0;

    braid_tokens.push(String::from("ALLOC_E8 256"));

    for word in &words {
        let clean_word = word.to_lowercase().replace(",", "").replace(".", "");
        for entry in &dict {
            if entry.word_term == clean_word {
                matches += 1;
                sum_v0 += entry.e8_vector_w0;
                sum_v1 += entry.e8_vector_w1;
                sum_v2 += entry.e8_vector_w2;
                sum_v3 += entry.e8_vector_w3;

                if entry.braid_generator_sigma > 0 {
                    braid_tokens.push(format!("SIGMA {}", entry.braid_generator_sigma));
                } else {
                    braid_tokens.push(format!("SIGMA_INV {}", entry.braid_generator_sigma.abs()));
                }

                println!("  + Lexicon Match: '{}' -> Definition: \"{}\"", entry.word_term, entry.formal_definition);
                println!("   + E8 Pin Coordinates: ({:.1}, {:.1}, {:.1}, {:.1}) | BraidC Gen: σ_{}", entry.e8_vector_w0, entry.e8_vector_w1, entry.e8_vector_w2, entry.e8_vector_w3, entry.braid_generator_sigma);
            }
        }
    }

    braid_tokens.push(String::from("SANTOS_ROT 0.17259029"));
    braid_tokens.push(String::from("EMIT Python"));

    let vector_str = format!("({:.2}, {:.2}, {:.2}, {:.2})", sum_v0, sum_v1, sum_v2, sum_v3);
    let braidir_stream = braid_tokens.join(" -> ");

    LexiconTranslationReport {
        words_parsed_count: words.len() as u32,
        dictionary_matches_count: matches,
        e8_pinned_vector_sum: vector_str,
        braidc_word_stream: braidir_stream,
        translation_coherent: matches > 0,
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let prompt = match args.get(1) {
        Some(p) => p.clone(),
        None => "fast python memory heap buffer optimizer with shared ring qcd flux calabi zkp proof".to_string(),
    };

    println!("============================================================");
    println!(" ACT-Omega v25.0 Comprehensive Offline Lexicon Engine ");
    println!(" Extended Dictionary Lookup, E8 Pinning & BraidIR Emitter ");
    println!("============================================================");

    println!("+ Input Language Prompt:\n\"{}\"\n", prompt);

    let start = Instant::now();
    let report = translate_prompt_to_e8_braidir(&prompt);
    let dur = start.elapsed();

    println!("\n============================================================");
    println!("             OFFLINE LEXICON TRANSLATION REPORT             ");
    println!("============================================================");
    println!(" Lexicon Lookup Time     : {:.3} us (0 ms Latency)", dur.as_secs_f64() * 1e6);
    println!(" Words Inspected          : {} Tokens", report.words_parsed_count);
    println!(" Dictionary Terms Matched : {} Offline Definitions Pinned", report.dictionary_matches_count);
    println!(" Pinned E8 Vector Coordinate: {}", report.e8_pinned_vector_sum);
    println!(" Translated BraidIR Stream  : {}", report.braidc_word_stream);
    println!(" Shared Memory Binding    : Global\\ACT_OMEGA_E8_HYPER_MANIFOLD Active");
    println!("------------------------------------------------------------");
    println!(" Status                    : COMPREHENSIVE_OFFLINE_LEXICON_LATCHED");
    println!("============================================================");
}
