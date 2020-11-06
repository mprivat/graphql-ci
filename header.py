import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--id')
parser.add_argument('--title')
parser.add_argument('--slug')
args = parser.parse_args()

print("---")
if args.id:
    print("id:",args.id)
if args.title:
    print("title:", args.title)
if args.slug:
    print("slug:", args.slug)
print("---\n")

print(sys.stdin.read())
