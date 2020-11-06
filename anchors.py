import sys
import re
print(re.sub(r'\]\(([^#])', r'](#\1', sys.stdin.read(), flags=re.M))
 
