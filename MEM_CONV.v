//sw:放入系列
module MEM_CONV1(
input [1:0]convtype,//类型码
input [1:0]addr_tail,//事实上只需要最后两位
input [31:0]data_in,
output [31:0]data_out32,
output [15:0]data_out16,
output [7:0]data_out8
    );
    
    assign data_out32=data_in;
    assign data_out16=data_in[15:0];
    assign data_out8=data_in[7:0];
    
    
endmodule






//lw,取出系列
module MEM_CONV2(
input [2:0]convtype,//类型码
input [1:0]addr_tail,//事实上只需要最后两位
input [31:0]data_in,
output [31:0]data_out
    );
    
   // reg [31:0]data_in1;
    reg [15:0]data_in2;
    reg [15:0]data_in3;
    reg [7:0]data_in4;
    reg [7:0]data_in5;
    
    reg [31:0]data_out1;
    wire [31:0]data_out2;
    wire [31:0]data_out3;
    wire [31:0]data_out4;
    wire [31:0]data_out5;
    
    S_EXT_16 se16(data_in2,data_out2);
    EXT_16 e16(data_in3,data_out3);
    S_EXT_8 se8(data_in4,data_out4);
    EXT_8 e8(data_in5,data_out5);
    selector81 s81(data_out1,data_out2,data_out3,data_out4,data_out5,0,0,0,convtype,data_out);
    
    
    always @(*)
    begin
    
    if(convtype==3'b000)//lw
    begin
    data_out1<=data_in;
    end
    else if(convtype==3'b001||convtype==3'b010)//lh,lhu
    begin
    
    if(addr_tail[1]==1'b0)
    begin
    data_in2<=data_in[15:0];
    data_in3<=data_in[15:0];
    end
    else
    begin
    data_in2<=data_in[31:16];
    data_in3<=data_in[31:16];
    end
    

    end
    else if(convtype==3'b011||convtype==3'b100)//lb,lbu
    begin
    
    if(addr_tail==2'b00)
    begin
    data_in4<=data_in[7:0];
    data_in5<=data_in[7:0];
    end
    else if(addr_tail==2'b01)
    begin
    data_in4<=data_in[15:8];
    data_in5<=data_in[15:8];
    end
    else if(addr_tail==2'b10)
    begin
    data_in4<=data_in[23:16];
    data_in5<=data_in[23:16];
    end
    else
    begin
    data_in4<=data_in[31:24];
    data_in5<=data_in[31:24];
    end
    end
    


    
    end
    
    
    
    
endmodule
