#Assemble
import re
DATA_LOC = 128
MEMORY_VAR = "memory"
MACRO_NAME = "writeRam"

OPCODE = {
    "ADD":0,
    "SUB":1,
    "AND":2,
    "OR":3,
    "LS":4,
    "RS":5,
    "LDI":6,
    "STI":7,
    "MOV":8,
    "LD":9,
    "ST":10,
}

def removeEmptyLines(lines):
    return [line for line in lines if line.strip()!=""]

def getLabels(lines):
    labs = {"PROGRAM":1, "DATA":DATA_LOC}
    reserved = ["PROGRAM", "DATA"]
    for i,line in enumerate(lines):
        if ":" in line:
            l = line.split(":")[0].strip()
            if l not in reserved:
                labs[l] = i;
    return labs

def compileLine(line,labels):
    s = ""
    if ":" in line:
        line = line.split(":")[1].strip()
        
    ops = filter(None, re.split("[, ]+", line))
    if len(ops)==0:
        return ""
    opcode = ops[0]
    s = "{:04b}".format(OPCODE[ops[0]])
    if opcode[-1] == 'I':
        for op in ops[1:]:
            if op[0]=='R':
                s = "{:04b}".format(int(op[1:])) + s
            elif op[0]=='#':
                s = "{:b}".format(int(op[1:])) + s
            elif op[0]=='$':
                s = "{:b}".format(labels[op[1:]]) + s
    else:        
        for op in ops[1:]:
            s = "{:04b}".format(int(op[1:])) + s
            
    s = "0"*(16-len(s))+s
    s = "16'b"+s
    return s
    

def compileIntoM(text):
    lines = text.split("\n")
    lines = [l.strip().upper() for l in lines]
    lines = removeEmptyLines(lines)
    
    labels = getLabels(lines)
    
    
    i=1
    line = lines[i]
    output = "`define {} \\\n".format(MACRO_NAME)
    while line != 'DATA:':
        
        instcode = compileLine(line,labels)
        output += "{0}[{1}] = {2};".format(MEMORY_VAR,i,instcode) + " \\\n"
        
        i+=1
        line = lines[i]
        
    for j,line in enumerate(lines[i+1:]):
        output += "{0}[{1}] = {2};".format(MEMORY_VAR,j+DATA_LOC,line.strip()) + " \\\n"
        
    return output

import sys
filename = sys.argv[1]
outname = "code.v"
with open(filename) as f:
    text = f.read()
    compiledstring = compileIntoM(text)

with open(outname,"w") as f:
    f.write(compiledstring)