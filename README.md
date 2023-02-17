# SilentDragonLite CLI

`silentdragonlite-cli` is a command line SilentDragonLite light client. To use it, download the latest binary from the releases page and run `./silentdragonlite-cli` or compile it yourself as documented below.

This will launch the interactive prompt. Type `help` to get a list of commands

## Running in non-interactive mode:
You can also run `silentdragonlite-cli` in non-interactive mode by passing the command you want to run as an argument. For example, `silentdragonlite-cli addresses` will list all wallet addresses and exit. 
Run `silentdragonlite-cli help` to see a list of all commands. 

## Privacy 
* While all the keys and transaction detection happens on the client, the server can learn what blocks contain your shielded transactions.
* The server also learns other metadata about you like your ip address etc...
* Also remember that t-addresses don't provide any privacy protection.

## Notes:
* If you want to run your own server, please see [SilentDragonLite-cli lightwalletd](https://git.hush.is/hush/lightwalletd), and then run `./silentdragonlite-cli --server http://127.0.0.1:9067`. You might also need to pass `--dangerous` if you are using a self-signed TLS certificate.

* The log file is in `~/.silentdragonlite/silentdragonlite-cli.debug.log`. Wallet is stored in `~/.silentdragonlite/silentdragonlite-cli.dat`

### Note Management
silentdragonlite does automatic note and utxo management, which means it doesn't allow you to manually select which address to send outgoing transactions from. It follows these principles:
* Defaults to sending shielded transactions, even if you're sending to a transparent address
* Sapling funds need at least 2 confirmations before they can be spent
* Can select funds from multiple shielded addresses in the same transaction
* Will automatically shield your transparent funds at the first opportunity
    * When sending an outgoing transaction to a shielded address, silentdragonlite can decide to use the transaction to additionally shield your transparent funds (i.e., send your transparent funds to your own shielded address in the same transaction)

## Compiling from source

#### Pre-requisites



* You need Rust and how you install it will depend on your version of Linux. Below are well known rust versions tested on common Linux distributions.

| Linux Version | Rust Version Tested | Command to install  |
|---------------|--------|---------------------------|
| Ubuntu 18.04  | 1.47.0 | [USE RUSTUP](https://www.rust-lang.org/tools/install) |
| Ubuntu 20.04  | 1.57.0 | sudo apt install rust-all |
| Debian 11     | 1.50.0 | [USE RUSTUP](https://www.rust-lang.org/tools/install) |
| Arch Linux    | 1.56.0 | pacman -S rustc cargo     |

* Debian 11 comes with a much older rust compiler (1.48.0) and so you want to use rustup with Debian and install at least 1.50.0.
* If you're using another Linux distro, then consult their package manager for rustc and cargo, but if it's tool old then you want to [use Rustup](https://www.rust-lang.org/tools/install) to install at least 1.50.0.
* The build will fail if you do not have `rustfmt` binary, which is included when you use `rustup` but may not be included in via operating system packages. Using `rustup` is recommended

To securely install rustup by compiling it yourself:

```
git clone https://github.com/rust-lang/rustup
cd rustup
cargo run --release
```

The above avoids piping the output of curl to bash (bad idea) and avoids using binaries. It will take a few minutes longer but is the better solution.


#### The compilation

Run the following commands to compile on your computer.

```shell script
git clone https://git.hush.is/hush/silentdragonlite-cli
cd silentdragonlite-cli
cargo build --release
./target/release/silentdragonlite-cli
```

#### Or build with make

Alternatively, you can use the new makefile to build

```shell script
make help
make build
```

## Options
Here are some CLI arguments you can pass to `silentdragonlite-cli`. Please run `silentdragonlite-cli --help` for the full list.

* `--server`: Connect to a custom SilentDragonLite lightwalletd server. 
    * Example: `./silentdragonlite-cli --server 127.0.0.1:9067`
    * Example: `./silentdragonlite-cli --server lite.hush.is`
* `--seed`: Restore a wallet from a seed phrase. **Note** that this will fail if there is an existing wallet. Delete (or move) any existing wallet to restore from the 24-word seed phrase
    * Example: `./silentdragonlite-cli --seed "twenty four words seed phrase"`
 * `--recover`: Attempt to recover the seed phrase from a corrupted wallet
* `-n, --nosync`: By default, Silentdragonlite-cli will sync the wallet at startup, so use this option to prevent the automatic sync at startup

### Support

For support or other questions, join us on [Telegram](https://hush.is/telegram), or toot at our [Mastodon](https://fosstodon.org/@myhushteam) or join our [Telegram Support](https://hush.is/telegram_support) or [file an issue](https://git.hush.is/hush/silentdragonlite-cli/issues).

## Copyright

Copyright The Hush Developers 2019-2022

## License

GPLv3 or later
