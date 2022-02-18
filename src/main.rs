mod cli;

fn main() {
    let matches = cli::build().get_matches();
    let greeting = matches.value_of("greeting").unwrap();
    let name = matches.value_of("name").unwrap();
    println!("{}, {}!", greeting, name);
}
