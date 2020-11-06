import sys
import re
print(re.sub(r'\]\((?!#|http)', r'](#', sys.stdin.read(), flags=re.M))
