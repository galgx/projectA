#!/usr/bin/env python3
import math
import itertools
import ctypes
#from matplotlib import pyplot as plt

width = 8
z_width = width
i = 0;

print("module sigmoid_LUT(z, h);")
print("    input [{}:0] z;".format(z_width - 1))
print("    output reg [{}:0] h;".format(z_width - 1))
print()
print("    always @(z) begin")
print("        case (z)")
#fmt = "{{2}}'b{{1:0{0}b}}: h <= {{2}}'b{{1:0{1}b}};".format(z_width)

x = []

for z in range(2 ** z_width):
    i = i+ 1/(2**6)
    h = 1 / (1 + math.exp(-i))
    f1 = bin(int(h*256)).replace('0b','')
    
    #f1 = bin(ctypes.c_uint.from_buffer(ctypes.c_float(h)).value)[2:]
    x.append(h)
    #print("    %s'd{%s} <= %s'b%s;  // %.4f" % (z_width, z, z_width, f1, h));
    
    print(f1)
    #print("%s'b")
    #exit(0)
    #print(fmt.format(z,f1,z_width))


print("            default: h <= 0;")
print("        endcase")
print("    end")
print("endmodule")

#plt.plot(x)
#plt.show()