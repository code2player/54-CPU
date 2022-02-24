module pc(
input PC_CLK,
input reset,
input pc_in_control,
input [31:0] pc_in,
output reg [31:0] pc_out
    );
    
    always @(negedge PC_CLK or posedge reset)//ÉÏÉıÑØ or ÏÂ½µÑØ£¿
    begin
        if(reset==1'b1)
            pc_out<=32'h00400000;
        else
        begin
            if(pc_in_control==1'b0)
            pc_out<=pc_in;
            else
            begin
            
            end
        end   
    end

endmodule

