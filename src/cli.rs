use clap::{command, Command};

#[must_use]
pub fn build() -> Command<'static> {
    command!()
}

#[test]
fn verify() {
    build().debug_assert();
}
