module CP0(
input clk,
input rst,
input mfc0,//��cp0�Ĵ���
input mtc0,//дcp0�Ĵ���
input [31:0]pc,
input [4:0]Rd,//дcp0�Ĵ�����ַ
input [31:0]wdata,//дcp0�Ĵ���ֵ
input exception,
input eret,//eret�쳣����
input [4:0]cause,//�ж���ţ�5'b01000(syscall)  5'b01001(break)  5'b01101(teq)
input intr,//�ⲿ�жϣ�û��
output [31:0]rdata,//������cp0�Ĵ���ֵ
output [31:0]status,
output reg timer_int,//��ʱ�����ⲿ�жϣ�û��
output reg [31:0]exc_addr
    );
    
    reg [31:0] reg_cp0[0:31];
    /*status��12�żĴ�����cause��13�żĴ�����epc��14�żĴ���*/
    /*cause[6:2]Ϊ�쳣���ͺţ�5'b01000(syscall)  5'b01001(break)  5'b01101(teq)*/
    
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
    exc_addr=32'h00400004;//�쳣��ַ���Ϊ0x4
    end
    else if(exception==1'b1)
    begin
       if(eret==1'b1) 
        begin
        reg_cp0[12]=reg_cp0[12]>>5;//�ر��쳣������5λ�����ж�
        exc_addr=reg_cp0[14];
        end
        else if(cause==5'b01000)//syscall
        begin
            if(reg_cp0[12][1]==1'b1)
            begin
            exc_addr=32'h00400004;//�쳣��ַ���Ϊ0x4
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
            exc_addr=32'h00400004;//�쳣��ַ���Ϊ0x4
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
            exc_addr=32'h00400004;//�쳣��ַ���Ϊ0x4
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
        //����ָ�δʵ��


        end
   
        
    end
    else 
    begin

    end
    
    
    end
    
    
    
endmodule
