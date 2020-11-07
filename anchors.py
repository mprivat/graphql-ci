import sys
import re

def lower_repl(match):
     return '](#' + match.group(1).lower()

content = sys.stdin.read()

result = re.sub(r'\[(.*)\]\(xml\)', r'[\1](../../static/\1)', content, flags=re.M)
result = re.sub(r'\]\((?!#|http|\.)', r'](#', result, flags=re.M)
result = re.sub(r'\]\(#(.*)\)', lower_repl, result, flags=re.M)
print(result)
