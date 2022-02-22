// Copyright The Hush Developers  2019-2022
// Released under the GPLv3
fn main() -> Result<(), Box<dyn std::error::Error>> {
    tonic_build::configure()
         .build_server(false)
         .compile(
            &["proto/service.proto", "proto/compact_formats.proto"],
            &["proto"],
         )?;
    println!("cargo:rerun-if-changed=proto/service.proto");
    Ok(())
 }
 
