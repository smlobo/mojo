import sys

def main():
    if len(sys.argv()) < 2:
        print("No args: {}".format(sys.argv()[0]))
        sys.exit(1)
    else:
        print("1st arg: {}".format(sys.argv()[1]))
