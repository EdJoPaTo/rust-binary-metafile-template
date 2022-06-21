mod cli;

fn main() {
    let matches = cli::build().get_matches();
    let greeting = matches.get_one::<String>("greeting").unwrap();
    let name = matches.get_one::<String>("name").unwrap();
    println!("{}, {}!", greeting, name);
}
