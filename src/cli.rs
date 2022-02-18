use clap::{command, Arg, Command, ValueHint};

#[allow(clippy::too_many_lines)]
#[must_use]
pub fn build() -> Command<'static> {
    command!()
        .arg(
            Arg::new("name")
                .long("name")
                .env("USER")
                .value_hint(ValueHint::Username)
                .value_name("NAME")
                .takes_value(true)
                .default_value("world")
                .help("Who to greet"),
        )
        .arg(
            Arg::new("greeting")
                .long("greeting")
                .env("GREETING")
                .value_hint(ValueHint::Other)
                .value_name("GREETING")
                .takes_value(true)
                .default_value("Hello")
                .help("Kind of greeting you want to get"),
        )
}

#[test]
fn verify() {
    build().debug_assert();
}
