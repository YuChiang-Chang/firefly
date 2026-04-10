from sys import argv
from src.cli.commands import run_cli

fn main() raises:
    # Get command-line arguments
    var args = argv()
    
    try:
        run_cli(args)
    except e:
        print('{"error": "' + str(e) + '", "code": "UNKNOWN_ERROR"}')
