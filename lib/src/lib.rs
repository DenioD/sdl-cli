// Copyright The Hush Developers  2019-2022
// Released under the GPLv3
#[macro_use]
extern crate rust_embed;

pub mod lightclient;
pub mod grpcconnector;
pub mod lightwallet;
pub mod commands;

#[cfg(feature = "embed_params")]
#[derive(RustEmbed)]
#[folder = "zcash-params/"]
pub struct SaplingParams;

#[derive(RustEmbed)]
#[folder = "res/"]
pub struct PubCertificate;


pub const ANCHOR_OFFSET: u32 = 0;

pub mod grpc_client {
    tonic::include_proto!("cash.z.wallet.sdk.rpc");
}
