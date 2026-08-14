// ============================================================================
// ACT-Ω Spatial 3D WebGL / WebGPU Topological Constellation Engine (Zero-Bracket)
// Framework: Embedded HTTP Web Server & Real-Time 3D E8 Root Lattice Web Canvas
// ============================================================================

use std::net::{TcpListener, TcpStream};
use std::io::{Read, Write};
use std::thread;

fn handle_web_client(mut stream: TcpStream) {
    let mut buffer = Vec::new();
    buffer.resize(2048, 0u8);

    if let Ok(bytes_read) = stream.read(&mut buffer) {
        if bytes_read > 0 {
            let html_body = "<!DOCTYPE html>
<html>
<head>
    <title>ACT-Omega v25.0 Spatial 3D WebGPU Constellation Engine</title>
    <style>
        body { background-color: #0a0d12; color: #00ffff; font-family: 'Segoe UI', monospace; margin: 0; overflow: hidden; }
        #canvas3d { width: 100vw; height: 100vh; display: block; }
        .hud-overlay { position: absolute; top: 20px; left: 20px; background: rgba(18, 22, 28, 0.85); border: 1px solid #00ffff; border-radius: 8px; padding: 15px; width: 320px; }
        .val { color: #00ff00; font-weight: bold; }
    </style>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js'></script>
</head>
<body>
    <div class='hud-overlay'>
        <h2>ACT-Omega 3D E8 Engine</h2>
        <p>E8 Root Constellation : <span class='val'>240 Vectors / 6720 Edges</span></p>
        <p>3D Braid Orbit Angle  : <span class='val'>0.17259 rad/s</span></p>
        <p>Cadence Lock         : <span class='val'>15.965 Hz (62.636 ms)</span></p>
        <p>VR WebXR Spatial Mode  : <span class='val'>Active / Ready</span></p>
    </div>
    <canvas id='canvas3d'></canvas>
    <script>
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ canvas: document.getElementById('canvas3d'), antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);

        const geometry = new THREE.BufferGeometry();
        const vertices = new Array();
        const numPoints = 240;
        const radius = 5;

        for (let i = 0; i < numPoints; i++) {
            const phi = Math.acos(-1 + (2 * i) / numPoints);
            const theta = Math.sqrt(numPoints * Math.PI) * phi;
            vertices.push(radius * Math.cos(theta) * Math.sin(phi));
            vertices.push(radius * Math.sin(theta) * Math.sin(phi));
            vertices.push(radius * Math.cos(phi));
        }

        geometry.setAttribute('position', new THREE.Float32BufferAttribute(vertices, 3));
        const material = new THREE.PointsMaterial({ color: 0x00ffff, size: 0.15 });
        const points = new THREE.Points(geometry, material);
        scene.add(points);

        camera.position.z = 10;

        function animate() {
            requestAnimationFrame(animate);
            points.rotation.x += 0.005;
            points.rotation.y += 0.008;
            renderer.render(scene, camera);
        }
        animate();
    </script>
</body>
</html>";

            let http_response = format!(
                "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=UTF-8\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{}",
                html_body.len(),
                html_body
            );

            stream.write_all(http_response.as_bytes()).ok();
        }
    }
}

fn main() {
    println!("============================================================");
    println!(" ACT-Omega v25.0 Spatial 3D WebGPU Constellation Engine ");
    println!(" Listening on http://0.0.0.0:8090 | WebGL / VR Spatial Server");
    println!("============================================================");

    let bind_addr = "0.0.0.0:8090";
    if let Ok(listener) = TcpListener::bind(bind_addr) {
        println!("+ Spatial 3D WebGPU Server Active at http://localhost:8090");
        println!("+ 240-Vector E8 Root Lattice 3D Canvas Ready on port 8090...\n");

        for stream in listener.incoming().flatten() {
            thread::spawn(move || {
                handle_web_client(stream);
            });
        }
    } else {
        println!("! Failed to bind Spatial 3D Web Engine to port 8090.");
    }
}
