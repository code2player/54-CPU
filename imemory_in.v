module IMEM_ip(
input [10:0]addr,
output [31:0]instr
    );
    
    imem im(.a(addr),.spo(instr));
endmodule
