module DIV(
input [31:0]dividend,
input [31:0]divisor,
input start,
input clock,
input reset,
output [31:0]q,
output [31:0]r,
output reg busy,
output reg over
    );
    
    wire ready;
    reg [4:0]count;
    reg [31:0]reg_q;
    reg [31:0]reg_r;
    reg [31:0]reg_b;
    reg busy2,r_sign;
    
    wire [31:0] dividend_yuan= dividend[31]?(~(dividend-1)):dividend;
    wire [31:0] divisor_yuan= divisor[31]?(~(divisor-1)):divisor;
    wire dividend_sign= dividend[31];
    wire divisor_sign= divisor[31];
    wire [31:0] rr = r_sign ? reg_r + reg_b : reg_r;
    wire [31:0] qq = reg_q;
    
    
    assign ready = ~busy & busy2;   
    
    wire [32:0] sub_add = r_sign ? ({reg_r,qq[31]}+{1'b0,reg_b}) : ({reg_r,qq[31]}-{1'b0,reg_b}) ;
    
    assign r= dividend_sign?((~rr)+1):rr;
    assign q= (dividend_sign+divisor_sign)?((~qq)+1):qq;
    
    
    always @(posedge clock or posedge reset)
    begin
    if(reset==1)
    begin
        count<=5'b0;
        busy<=0;
        busy2<=0;
        over<=0;
    end
    else
    begin
        busy2<=busy;
        if(over==1)
        begin
        over<=0;
        end
        else if(start)
        begin
            reg_r<=32'b0;
            r_sign<=0;
            reg_q<=dividend_yuan;
            reg_b<=divisor_yuan;
            count<=5'b0;
            busy<=1'b1;
            over<=0;
        end
        else if(busy)
        begin
            reg_r<=sub_add[31:0];
            r_sign<=sub_add[32];
            reg_q<={reg_q[30:0],~sub_add[32]};
            count<=count+5'b1;
            if(count==5'b11111)
            begin
                busy<=0;
                over<=1;
            end
        end
    end
    end
endmodule    
