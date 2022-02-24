module CP0(
input clk,
input rst,
input mfc0,//读cp0寄存器
input mtc0,//写cp0寄存器
input [31:0]pc,
input [4:0]Rd,//写cp0寄存器地址
input [31:0]wdata,//写cp0寄存器值
input exception,
input eret,//eret异常返回
input [4:0]cause,//中断序号，5'b01000(syscall)  5'b01001(break)  5'b01101(teq)
input intr,//外部中断，没用
output [31:0]rdata,//读到的cp0寄存器值
output [31:0]status,
output reg timer_int,//定时产生外部中断，没用
output reg [31:0]exc_addr
    );
    
    reg [31:0] reg_cp0[0:31];
    /*status：12号寄存器，cause：13号寄存器，epc：14号寄存器*/
    /*cause[6:2]为异常类型号，5'b01000(syscall)  5'b01001(break)  5'b01101(teq)*/
    
    assign rdata = mfc0 ? reg_cp0[Rd] : 0;
    assign status = reg_cp0[12];
    
    
    always @(posedge clk or posedge rst)
    begin
    if(rst==1'b1)
    begin
    reg_cp0[12]=32'h0000000f;
    reg_cp0[13]=32'h00000000;
    reg_cp0[14]=32'h00000000;
    exc_addr=32'h00400000;
    end
    else if(mtc0==1'b1)
    begin
    reg_cp0[Rd]=wdata;
    exc_addr=32'h00400004;//异常地址入口为0x4
    end
    else if(exception==1'b1)
    begin
       if(eret==1'b1) 
        begin
        reg_cp0[12]=reg_cp0[12]>>5;//关闭异常，右移5位，开中断
        exc_addr=reg_cp0[14];
        end
        else if(cause==5'b01000)//syscall
        begin
            if(reg_cp0[12][1]==1'b1)
            begin
            exc_addr=32'h00400004;//异常地址入口为0x4
            reg_cp0[12]=(reg_cp0[12]<<5);
            reg_cp0[13][6:2]=5'b01000;
            reg_cp0[14]=pc;
            end
            else
            begin
            exc_addr=pc+4;
            end
        end
        else if(cause==5'b01001)//break
        begin
            if(reg_cp0[12][2]==1'b1)
            begin
            exc_addr=32'h00400004;//异常地址入口为0x4
            reg_cp0[12]=reg_cp0[12]<<5;
            reg_cp0[13][6:2]=5'b01001;
            reg_cp0[14]=pc;
            end
            else
            begin
            exc_addr=pc+4;
            end
        end
        else if(cause==5'b01101)//teq
        begin
            if(reg_cp0[12][3]==1'b1)
            begin
            exc_addr=32'h00400004;//异常地址入口为0x4
            reg_cp0[12]=reg_cp0[12]<<5;
            reg_cp0[13][6:2]=5'b01101;
            reg_cp0[14]=pc;
            end
            else
            begin
            exc_addr=pc+4;
            end
        end
        else
        begin
        //其他指令，未实现


        end
   
        
    end
    else 
    begin

    end
    
    
    end
    
    
    
endmodule
