import sys
import re
result = re.sub(r'\]\((?!#|http)', r'](#', sys.stdin.read(), flags=re.M)

def upper_repl(match):
     return '](#' + match.group(1).lower()

result = re.sub(r'\]\(#(.*)\)', upper_repl, result, flags=re.M)
print(result)
