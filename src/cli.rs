use clap::{app_from_crate, App};

#[must_use]
pub fn build() -> App<'static> {
    app_from_crate!()
}
