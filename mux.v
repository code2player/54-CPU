module selector41(
input [31:0] iC0,
input [31:0] iC1,
input [31:0] iC2,
input [31:0] iC3,
input [1:0]iS,
output reg [31:0] oZ
    );
    always @(*)
    begin
    
    if(iS==0)
    oZ=iC0;
    else if(iS==1)
    oZ=iC1;
    else if(iS==2)
    oZ=iC2;
    else
    oZ=iC3;
    
    end

endmodule

module selector41_5(
input [4:0] iC0,
input [4:0] iC1,
input [4:0] iC2,
input [4:0] iC3,
input [1:0]iS,
output reg [4:0] oZ
    );
    always @(*)
    begin
    
    if(iS==0)
    oZ=iC0;
    else if(iS==1)
    oZ=iC1;
    else if(iS==2)
    oZ=iC2;
    else
    oZ=iC3;
    
    end

endmodule

module selector21(
input [31:0] iC0,
input [31:0] iC1,
input iS,
output reg [31:0] oZ
    );
    always @(*)
    begin
    
    if(iS==0)
    oZ=iC0;
    else
    oZ=iC1;
    
    end

endmodule


/*module selector21_16(
input [15:0] iC0,
input [15:0] iC1,
input iS,
output reg [15:0] oZ
    );
    always @(*)
    begin
    
    if(iS==0)
    oZ=iC0;
    else
    oZ=iC1;
    
    end

endmodule*/


module selector81(
input [31:0] iC0,
input [31:0] iC1,
input [31:0] iC2,
input [31:0] iC3,
input [31:0] iC4,
input [31:0] iC5,
input [31:0] iC6,
input [31:0] iC7,
input [2:0]iS,
output reg [31:0] oZ
    );
    always @(*)
    begin
    
    if(iS==0)
    oZ=iC0;
    else if(iS==1)
    oZ=iC1;
    else if(iS==2)
    oZ=iC2;
    else if(iS==3)
    oZ=iC3;
    else if(iS==4)
    oZ=iC4;    
    else if(iS==5)
    oZ=iC5;
    else if(iS==6)
    oZ=iC6;
    else 
    oZ=iC7;

    
    end

endmodule



/*module selector161(
input [31:0] iC0,
input [31:0] iC1,
input [31:0] iC2,
input [31:0] iC3,
input [31:0] iC4,
input [31:0] iC5,
input [31:0] iC6,
input [31:0] iC7,
input [31:0] iC8,
input [31:0] iC9,
input [31:0] iC10,
input [31:0] iC11,
input [31:0] iC12,
input [31:0] iC13,
input [31:0] iC14,
input [31:0] iC15,
input [3:0]iS,
output reg [31:0] oZ
    );
    always @(*)
    begin
    
    if(iS==0)
    oZ=iC0;
    else if(iS==1)
    oZ=iC1;
    else if(iS==2)
    oZ=iC2;
    else if(iS==3)
    oZ=iC3;
    else if(iS==4)
    oZ=iC4;    
    else if(iS==5)
    oZ=iC5;
    else if(iS==6)
    oZ=iC6;
    else if(iS==7)
    oZ=iC7;
    else if(iS==8)
    oZ=iC8;
    else if(iS==9)
    oZ=iC9;
    else if(iS==10)
    oZ=iC10;
    else if(iS==11)
    oZ=iC11;    
    else if(iS==12)
    oZ=iC12;
    else if(iS==13)
    oZ=iC13;
    else if(iS==14)
    oZ=iC14;
    else
    oZ=iC15;
    
    end

endmodule*/





