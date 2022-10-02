use clap::{Parser, ValueHint};

#[derive(Debug, Parser)]
#[command(about, author, version)]
pub struct Cli {
    /// Who to greet
    #[arg(
        long,
        env = "USER",
        value_hint = ValueHint::Username,
        default_value = "world",
    )]
    pub name: String,

    /// Kind of greeting you want to get
    #[arg(
        long,
        env = "GREETING",
        value_hint = ValueHint::Other,
        default_value = "Hello",
    )]
    pub greeting: String,
}

#[test]
fn verify() {
    use clap::CommandFactory;
    Cli::command().debug_assert();
}
