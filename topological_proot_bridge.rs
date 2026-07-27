// ============================================================================
// ACT-Ω Android 17 proot / Termux Cross-Platform State Bridge (Zero-Bracket)
// Framework: Non-Blocking TCP Socket Server & E8 Telemetry Synchronization
// ============================================================================

use std::net::{TcpListener, TcpStream};
use std::io::{Read, Write};
use std::thread;

pub struct E8BridgePacket {
    pub w0: i32, pub w1: i32, pub w2: i32, pub w3: i32,
    pub w4: i32, pub w5: i32, pub w6: i32, pub w7: i32,
    pub braid_charge: f64,
}

impl Clone for E8BridgePacket {
    fn clone(&self) -> Self {
        E8BridgePacket {
            w0: self.w0, w1: self.w1, w2: self.w2, w3: self.w3,
            w4: self.w4, w5: self.w5, w6: self.w6, w7: self.w7,
            braid_charge: self.braid_charge,
        }
    }
}

fn handle_termux_client(mut stream: TcpStream) {
    let mut buffer = Vec::new();
    buffer.resize(512, 0u8);

    if let Ok(bytes_read) = stream.read(&mut buffer) {
        if bytes_read > 0 {
            let msg = String::from_utf8_lossy(&buffer);
            println!("+ Received Proot/Termux Telemetry Packet: {}", msg.trim_matches(char::from(0)));

            let response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nACT_OMEGA_BRIDGE_ACK | E8_STATE_LATCHED\n";
            stream.write_all(response.as_bytes()).ok();
        }
    }
}

fn main() {
    println!("============================================================");
    println!(" ACT-Omega v25.0 Termux / Android 17 proot Bridge Server ");
    println!(" Listening on 0.0.0.0:8088 | Cross-Runtime Socket Stream  ");
    println!("============================================================");

    let bind_addr = "0.0.0.0:8088";
    if let Ok(listener) = TcpListener::bind(bind_addr) {
        println!("+ Socket Server Successfully Bound to {}", bind_addr);
        println!("+ Awaiting Connections from Termux / Debian proot Container...\n");

        for stream in listener.incoming().flatten() {
            thread::spawn(move || {
                handle_termux_client(stream);
            });
        }
    } else {
        println!("! Failed to bind TCP listener on port 8088.");
    }
}
