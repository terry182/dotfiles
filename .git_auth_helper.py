#!/usr/bin/env python
import argparse
from subprocess import check_output

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('operation', action="store", type=str,
            help="Git action to be performed (get|store|erase)")
    # parser all arguments
    arguments = parser.parse_args()

    if arguments.operation == "get":
        print("username={0}".format(check_output(['1pass', '-p', 'github.com', 'username']).decode('utf-8').strip()))
        print("password={0}".format(check_output(['1pass', '-p', 'github.com']).decode('utf-8').strip()))
    elif arguments.operation == "store":
        None
        # if credentials are already stored do not store again
    elif arguments.operation == "erase":
        None
    else:
        print("Invalid git operation")

if __name__ == "__main__":
    main()

