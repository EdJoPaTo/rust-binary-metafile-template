mod cli;

fn main() {
    let matches = cli::build().get_matches();
    println!("{:?}", matches);

    println!("Hello, world!");
}
