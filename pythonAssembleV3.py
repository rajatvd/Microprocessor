# Python assembler for microprocessor made in EE2016 (Jul-Nov 2017)
# Author: Rajat Vadiraj Dwaraknath EE16B033
import re

# Defining constants
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
    "CMP":11,
    "BCI":12,
    "BNEI":13,
    "BI":14,
    "HALT":15
}

# Helper function
def removeEmptyLines(lines):
    return [line for line in lines if line.strip()!=""]

# Get all labels used in the code
# TODO: check for label validity and uniqueness
def getLabels(lines):
    labs = {"PROGRAM":1, "DATA":DATA_LOC}
    reserved = ["PROGRAM", "DATA"]
    for i,line in enumerate(lines):
        if ":" in line:
            l = line.split(":")[0].strip()
            if l not in reserved:
                labs[l] = i;
    return labs


# TODO: Check validity of non immediate instruction operands. Check number of operands for each opcode.
def compileLine(line,labels):
    """ Given a line and a dictionary of labels previously defined, compile one line into a 16 bit instruction. 
        Assumes code already in upper case.
        Uses whitespace and , as delimiters. 
        
        Returns: Compiled 16 bit instruction in binary.
    """

    s = ""
    if ":" in line:
        line = line.split(":")[1].strip()
        
    ops = filter(None, re.split("[, ]+", line))
    # Get each token out of the line and remove empty tokens.
    
    if len(ops)==0:
        return ""
    
    # Add opcode to instruction
    opcode = ops[0]
    s = "{:04b}".format(OPCODE[ops[0]])
    
    if opcode[-1] == 'I':
        # Immediate instructions end in I.
        for op in ops[1:]:
            if op[0]=='R':
                # Operand is a register address
                s = "{:04b}".format(int(op[1:])) + s
            elif op[0]=='#':
                # Operand is a literal value
                s = "{:b}".format(int(op[1:])) + s
            elif op[0]=='$':
                # Operand is an address of a label
                s = "{:b}".format(labels[op[1:]]) + s
    else:
        # If the instruction is not immediate, all operands are register addresses.
        for op in ops[1:]:
            s = "{:04b}".format(int(op[1:])) + s
            
    # Zero pad
    s = "0"*(16-len(s))+s
    
    s = "16'b"+s # For verilog
    return s
    

# TODO check validity of PROGRAM and DATA labels, etc.
# TODO add comment line functionality in the assembly code.
def compileIntoM(text):
    """ Compiles an assembly language program into a macro which can be called in verilog code."""
    
    # Clean the code
    lines = text.split("\n")
    lines = [l.strip().upper() for l in lines]
    lines = removeEmptyLines(lines)
    
    # Get labels
    labels = getLabels(lines)
    
    # Create macro
    output = "`define {} \\\n".format(MACRO_NAME)
    
    # Write the program into the program memory half
    i=1
    line = lines[i]
    while line != 'DATA:':
        
        # Get 16 bit instruction
        instcode = compileLine(line,labels)

        # Update memory at index i 
        output += "{0}[{1}] = {2};".format(MEMORY_VAR,i,instcode) + " \\\n"
        
        i+=1
        line = lines[i]
    
    # Write the data memory
    for j,line in enumerate(lines[i+1:]):
        output += "{0}[{1}] = {2};".format(MEMORY_VAR,j+DATA_LOC,line.strip()) + " \\\n"
        
    return output

# File ops
import sys
filename = sys.argv[1]
outname = "code.v"
with open(filename) as f:
    text = f.read()
    compiledstring = compileIntoM(text)

with open(outname,"w") as f:
    f.write(compiledstring)