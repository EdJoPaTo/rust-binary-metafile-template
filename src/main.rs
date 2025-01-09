use clap::Parser as _;

mod cli;

fn main() {
    let matches = cli::Cli::parse();
    println!("{}, {}!", matches.greeting, matches.name);
}
