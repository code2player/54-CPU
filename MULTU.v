module MULTU(
input clk,
input reset,
input [31:0]a,
input [31:0]b,
output [63:0]z
    );
    reg [63:0] temp;
    reg [63:0] stored0;
    reg [63:0] stored1;
    reg [63:0] stored2;
    reg [63:0] stored3;
    reg [63:0] stored4;
    reg [63:0] stored5;
    reg [63:0] stored6;
    reg [63:0] stored7;
    reg [63:0] stored8;
    reg [63:0] stored9;
    reg [63:0] stored10;
    reg [63:0] stored11;
    reg [63:0] stored12;
    reg [63:0] stored13;
    reg [63:0] stored14;
    reg [63:0] stored15;
    reg [63:0] stored16;
    reg [63:0] stored17;
    reg [63:0] stored18;
    reg [63:0] stored19;
    reg [63:0] stored20;
    reg [63:0] stored21;
    reg [63:0] stored22;
    reg [63:0] stored23;
    reg [63:0] stored24;
    reg [63:0] stored25;
    reg [63:0] stored26;
    reg [63:0] stored27;
    reg [63:0] stored28;
    reg [63:0] stored29;
    reg [63:0] stored30;
    reg [63:0] stored31;
    /*---------------------------*/
    reg [63:0] add01;
    reg [63:0] add23;
    reg [63:0] add45;
    reg [63:0] add67;
    reg [63:0] add89;
    reg [63:0] add1011;
    reg [63:0] add1213;
    reg [63:0] add1415;
    reg [63:0] add1617;
    reg [63:0] add1819;
    reg [63:0] add2021;
    reg [63:0] add2223;
    reg [63:0] add2425;
    reg [63:0] add2627;
    reg [63:0] add2829;
    reg [63:0] add3031;
    /*--------------------------*/
    reg [63:0] add0123;
    reg [63:0] add4567;
    reg [63:0] add891011;
    reg [63:0] add12131415;
    reg [63:0] add16171819;
    reg [63:0] add20212223;
    reg [63:0] add24252627;
    reg [63:0] add28293031;
    /*-----------------------------*/
    reg [63:0] add01234567;
    reg [63:0] add89101112131415;
    reg [63:0] add1617181920212223;
    reg [63:0] add2425262728293031;
    /*-----------------------------*/
    reg [63:0] add0_15;
    reg [63:0] add16_31;
    /*------------------------------*/
   // reg [63:0] add0_31;
    

        
    always @(*)
    begin
    if(reset)
    begin
    temp=0;
    stored0 = 0;
    stored1 = 0;
    stored2 = 0;
    stored3 = 0;
    stored4 = 0;
    stored5 = 0;
    stored6 = 0;
    stored7 = 0;
    stored8 = 0;
    stored9 = 0;
    stored10 = 0;
    stored11 = 0;
    stored12 = 0;
    stored13 = 0;
    stored14 = 0;
    stored15 = 0;
    stored16 = 0;
    stored17 = 0;
    stored18 = 0;
    stored19 = 0;
    stored20 = 0;
    stored21 = 0;
    stored22 = 0;
    stored23 = 0;
    stored24 = 0;
    stored25 = 0;
    stored26 = 0;
    stored27 = 0;
    stored28 = 0;
    stored29 = 0;
    stored30 = 0;
    stored31 = 0;
    add01 = 0;
    add23 = 0;
    add45 = 0;
    add67 = 0;
    add89 = 0;
    add1011 = 0;
    add1213 = 0;
    add1415 = 0;
    add1617 = 0;
    add1819 = 0;
    add2021 = 0;
    add2223 = 0;
    add2425 = 0;
    add2627 = 0;
    add2829 = 0;
    add3031 = 0;
    add0123 = 0;
    add4567 = 0;
    add891011 = 0;
    add12131415 = 0;
    add16171819 = 0;
    add20212223 = 0;
    add24252627 = 0;
    add28293031 = 0;
    add01234567 = 0;
    add89101112131415 = 0;
    add1617181920212223 = 0;
    add2425262728293031 = 0;
    add0_15 = 0;
    add16_31 = 0;
    

    //add0_31 = 0;
    end
    else
    begin
    

    stored0 = b[0] ? {32'b0 , a} : 64'b0;
    stored1 = b[1] ? {31'b0 , a , 1'b0} : 64'b0;
    stored2 = b[2] ? {30'b0 , a , 2'b0} : 64'b0;
    stored3 = b[3] ? {29'b0 , a , 3'b0} : 64'b0;
    stored4 = b[4] ? {28'b0 , a , 4'b0} : 64'b0;
    stored5 = b[5] ? {27'b0 , a , 5'b0} : 64'b0;
    stored6 = b[6] ? {26'b0 , a , 6'b0} : 64'b0;
    stored7 = b[7] ? {25'b0 , a , 7'b0} : 64'b0;
    stored8 = b[8] ? {24'b0 , a , 8'b0} : 64'b0;
    stored9 = b[9] ? {23'b0 , a , 9'b0} : 64'b0;
    stored10 = b[10] ? {22'b0 , a , 10'b0} : 64'b0;
    stored11 = b[11] ? {21'b0 , a , 11'b0} : 64'b0;
    stored12 = b[12] ? {20'b0 , a , 12'b0} : 64'b0;
    stored13 = b[13] ? {19'b0 , a , 13'b0} : 64'b0;
    stored14 = b[14] ? {18'b0 , a , 14'b0} : 64'b0;
    stored15 = b[15] ? {17'b0 , a , 15'b0} : 64'b0;
    stored16 = b[16] ? {16'b0 , a , 16'b0} : 64'b0;
    stored17 = b[17] ? {15'b0 , a , 17'b0} : 64'b0;
    stored18 = b[18] ? {14'b0 , a , 18'b0} : 64'b0;
    stored19 = b[19] ? {13'b0 , a , 19'b0} : 64'b0;
    stored20 = b[20] ? {12'b0 , a , 20'b0} : 64'b0;
    stored21 = b[21] ? {11'b0 , a , 21'b0} : 64'b0;
    stored22 = b[22] ? {10'b0 , a , 22'b0} : 64'b0;
    stored23 = b[23] ? {9'b0 , a , 23'b0} : 64'b0;
    stored24 = b[24] ? {8'b0 , a , 24'b0} : 64'b0;
    stored25 = b[25] ? {7'b0 , a , 25'b0} : 64'b0;
    stored26 = b[26] ? {6'b0 , a , 26'b0} : 64'b0;
    stored27 = b[27] ? {5'b0 , a , 27'b0} : 64'b0;
    stored28 = b[28] ? {4'b0 , a , 28'b0} : 64'b0;
    stored29 = b[29] ? {3'b0 , a , 29'b0} : 64'b0;
    stored30 = b[30] ? {2'b0 , a , 30'b0} : 64'b0;
    stored31 = b[31] ? {1'b0 , a , 31'b0} : 64'b0;
    
    add01 = stored0 + stored1;
    add23 = stored2 + stored3;
    add45 = stored4 + stored5;
    add67 = stored6 + stored7;
    add89 = stored8 + stored9;
    add1011 = stored10 + stored11;
    add1213 = stored12 + stored13;
    add1415 = stored14 + stored15;
    add1617 = stored16 + stored17;
    add1819 = stored18 + stored19;
    add2021 = stored20 + stored21;
    add2223 = stored22 + stored23;
    add2425 = stored24 + stored25;
    add2627 = stored26 + stored27;
    add2829 = stored28 + stored29;
    add3031 = stored30 + stored31;
    
    add0123 = add01 + add23;
    add4567 = add45 + add67;
    add891011 = add89 + add1011;
    add12131415 = add1213 + add1415;
    add16171819 = add1617 + add1819;
    add20212223 = add2021 + add2223;
    add24252627 = add2425 + add2627;
    add28293031 = add2829 + add3031;
    
    add01234567 = add0123 + add4567;
    add89101112131415 = add891011 + add12131415;
    add1617181920212223 = add16171819 + add20212223;
    add2425262728293031 = add24252627 + add28293031;
    
    add0_15 = add01234567 + add89101112131415;
    add16_31 = add1617181920212223 + add2425262728293031;
    
   // add0_31 = add0_15 + add16_31;
    temp = add0_15 + add16_31;
    end
    

    end
    assign z=temp;
    
endmodule
