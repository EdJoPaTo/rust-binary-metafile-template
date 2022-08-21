use clap::{Parser, ValueHint};

#[derive(Debug, Parser)]
#[clap(about, author, version)]
pub struct Cli {
    /// Who to greet
    #[clap(
        long,
        env = "USER",
        value_hint = ValueHint::Username,
        default_value = "world",
    )]
    pub name: String,

    /// Kind of greeting you want to get
    #[clap(
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
