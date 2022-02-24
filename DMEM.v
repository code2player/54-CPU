module DMEM(
input clk,
//input ena,
input [1:0]in_type,//00:32,01:16,10:8
input [1:0]addr_tail,//地址尾部
input wena,//高电平写入有效，修改：高低电平读均有效
input [10:0] addr,
input [31:0] data_in32,
input [15:0] data_in16,
input [7:0] data_in8,
output reg [31:0] data_out
    );
    
    reg [31:0] memory [0:31];//reg数组,前面为位数，后面为数组元素个数
    
   // assign data_out= memory[addr];
    
    always @(*)
    begin
    
    if(addr==0)
    data_out=memory[0];
    else if(addr==1)
    data_out=memory[1];
    else if(addr==2)
    data_out=memory[2];
    else if(addr==3)
    data_out=memory[3];
    else if(addr==4)
    data_out=memory[4];
    else if(addr==5)
    data_out=memory[5];
    else if(addr==6)
    data_out=memory[6];
    else if(addr==7)
    data_out=memory[7];
    else if(addr==8)
    data_out=memory[8];
    else if(addr==9)
    data_out=memory[9];
    else if(addr==10)
    data_out=memory[10];
    else if(addr==11)
    data_out=memory[11];
    else if(addr==12)
    data_out=memory[12];
    else if(addr==13)
    data_out=memory[13];
    else if(addr==14)
    data_out=memory[14];
    else if(addr==15)
    data_out=memory[15];
    else if(addr==16)
    data_out=memory[16];
    else if(addr==17)
    data_out=memory[17];
    else if(addr==18)
    data_out=memory[18];
    else if(addr==19)
    data_out=memory[19];
    else if(addr==20)
    data_out=memory[20];
    else if(addr==21)
    data_out=memory[21];
    else if(addr==22)
    data_out=memory[22];
    else if(addr==23)
    data_out=memory[23];
    else if(addr==24)
    data_out=memory[24];
    else if(addr==25)
    data_out=memory[25];
    else if(addr==26)
    data_out=memory[26];
    else if(addr==27)
    data_out=memory[27];
    else if(addr==28)
    data_out=memory[28];
    else if(addr==29)
    data_out=memory[29];
    else if(addr==30)
    data_out=memory[30];
    else 
    data_out=memory[31];

    
    
    end

    always @(posedge clk )
    begin

    
    if(wena==1)//写有效
    begin
    
    if(in_type==2'b00)
    begin
    if(addr==0)
    memory[0]=data_in32;
    else if(addr==1)
    memory[1]=data_in32;
    else if(addr==2)
    memory[2]=data_in32;
    else if(addr==3)
    memory[3]=data_in32;
    else if(addr==4)
    memory[4]=data_in32;
    else if(addr==5)
    memory[5]=data_in32;
    else if(addr==6)
    memory[6]=data_in32;
    else if(addr==7)
    memory[7]=data_in32;
    else if(addr==8)
    memory[8]=data_in32;
    else if(addr==9)
    memory[9]=data_in32;
    else if(addr==10)
    memory[10]=data_in32;
    else if(addr==11)
    memory[11]=data_in32;
    else if(addr==12)
    memory[12]=data_in32;
    else if(addr==13)
    memory[13]=data_in32;
    else if(addr==14)
    memory[14]=data_in32;
    else if(addr==15)
    memory[15]=data_in32;
    else if(addr==16)
    memory[16]=data_in32;
    else if(addr==17)
    memory[17]=data_in32;
    else if(addr==18)
    memory[18]=data_in32;
    else if(addr==19)
    memory[19]=data_in32;
    else if(addr==20)
    memory[20]=data_in32;
    else if(addr==21)
    memory[21]=data_in32;
    else if(addr==22)
    memory[22]=data_in32;
    else if(addr==23)
    memory[23]=data_in32;
    else if(addr==24)
    memory[24]=data_in32;
    else if(addr==25)
    memory[25]=data_in32;
    else if(addr==26)
    memory[26]=data_in32;
    else if(addr==27)
    memory[27]=data_in32;
    else if(addr==28)
    memory[28]=data_in32;
    else if(addr==29)
    memory[29]=data_in32;
    else if(addr==30)
    memory[30]=data_in32;
    else 
    memory[31]=data_in32;
    end
    
    else if(in_type==2'b01)
    begin
    if(addr_tail[1]==1'b0)
    memory[addr][15:0]=data_in16;
    else
    memory[addr][31:16]=data_in16;
    end
    
    
    else if(in_type==2'b10)
    begin
    if(addr_tail==2'b00)
    memory[addr][7:0]=data_in8;
    else if(addr_tail==2'b01)
    memory[addr][15:8]=data_in8;
    else if(addr_tail==2'b10)
    memory[addr][23:16]=data_in8;
    else
    memory[addr][31:24]=data_in8;
    end
    
    
   // memory[addr]=data_in;
    end
    else//读有效
    begin
  //  data_out=memory[addr];
    end
    
    end
    

    
    
    
endmodule

