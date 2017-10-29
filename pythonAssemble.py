
def compileIntoM(text):
    lines = text.split("\n")
    lines = [l.strip().upper() for l in lines]
    return str(lines)



import sys
filename = sys.argv[1]
outname = "code.v"
with open(filename) as f:
    text = f.read()
    compiledstring = compileIntoM(text)

with open(outname,"w") as f:
    f.write(compiledstring)