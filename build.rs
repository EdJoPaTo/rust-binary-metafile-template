include!("src/cli.rs");

fn main() -> std::io::Result<()> {
    use clap::{CommandFactory, ValueEnum};
    const BIN_NAME: &str = env!("CARGO_PKG_NAME");

    println!("cargo:rerun-if-changed=build.rs");
    println!("cargo:rerun-if-changed=src/cli.rs");

    let out_dir = &std::path::Path::new("target").join("completions");
    drop(std::fs::remove_dir_all(out_dir));
    std::fs::create_dir_all(out_dir)?;

    for &shell in clap_complete::Shell::value_variants() {
        clap_complete::generate_to(shell, &mut Cli::command(), BIN_NAME, out_dir)?;
    }

    Ok(())
}
