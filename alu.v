module alu(
input [31:0] a,
input [31:0] b,
input [3:0] aluc,
input reset,
output reg [31:0] r,
output reg zero,
output reg carry,
output reg negative,
output reg overflow
    );
    
    reg [31:0]kkk;
    
    always @(*)
    begin
    
    if(reset==1'b1)
    begin
    r=32'b0;
    zero=0;
    carry=0;
    negative=0;
    overflow=0;
    end
    else
    begin
    
    if (aluc == 4'b0000)
    begin 
    r=a+b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r<a||r<b)
    carry=1;
    else
    carry=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b0010)
    begin
    r=a+b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    if((a[31]==0&&b[31]==0&&r[31]==1)||(a[31]==1&&b[31]==1&&r[31]==0))
    overflow=1;
    else
    overflow=0;
    
    
    end
    else if (aluc == 4'b0001)
    begin
    r=a-b;
    
    if(r==0)
    zero=1;
    else
    zero=0;  
    if(r>a)
    carry=1;
    else
    carry=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    

    end
    else if (aluc == 4'b0011)
    begin
    r=a-b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
   if((a[31]==0&&b[31]==1&&r[31]==1)||(a[31]==1&&b[31]==0&&r[31]==0))
    overflow=1;
    else
    overflow=0;

    end
    else if (aluc == 4'b0100)
    begin
    r=a&b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else if (aluc == 4'b0101)
    begin
    r=a|b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b0110)
    begin
    r=a^b;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else if (aluc == 4'b0111)
    begin  
    r=~(a|b);
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b1000)//lui
    begin
    r={b[15:0],16'b0};
    
    if(r==0)
    zero=1;
    else
    zero=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    
    //clz:计算前导0个数
    else if (aluc == 4'b1001)
    begin
    
    if(a[31]==1)
        r=0;
    else if(a[30]==1)
        r=1;
    else if(a[29]==1)
        r=2;
    else if(a[28]==1)
        r=3;
    else if(a[27]==1)
        r=4;
    else if(a[26]==1)
        r=5;
    else if(a[25]==1)
        r=6;
    else if(a[24]==1)
        r=7;
    else if(a[23]==1)
        r=8;
    else if(a[22]==1)
        r=9;
    else if(a[21]==1)
        r=10;
    else if(a[20]==1)
        r=11;
    else if(a[19]==1)
        r=12;
    else if(a[18]==1)
        r=13;
    else if(a[17]==1)
        r=14;
    else if(a[16]==1)
        r=15;
    else if(a[15]==1)
        r=16;
    else if(a[14]==1)
        r=17;
    else if(a[13]==1)
        r=18;
    else if(a[12]==1)
        r=19;
    else if(a[11]==1)
        r=20;
    else if(a[10]==1)
        r=21;
    else if(a[9]==1)
        r=22;
    else if(a[8]==1)
        r=23;
    else if(a[7]==1)
        r=24;
    else if(a[6]==1)
        r=25;
    else if(a[5]==1)
        r=26;
    else if(a[4]==1)
        r=27;
    else if(a[3]==1)
        r=28;
    else if(a[2]==1)
        r=29;
    else if(a[1]==1)
        r=30;
    else if(a[0]==1)
        r=31;
    else
        r=32;
    
    
    end
    
    
    else if (aluc == 4'b1011)
    begin
   // r=(a<b)?1:0;
   
   if(a[31]==0&&b[31]==0)
   r=(a<b)?1:0;
   else if(a[31]==0&&b[31]==1)
   r=0;
   else if(a[31]==1&&b[31]==0)
   r=1;
   else
   r=(a<b)?1:0;
   
   
    
    if(a-b==0)
    zero=1;
    else
    zero=0;
    
    kkk=a-b;
    
    if(kkk[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else if (aluc == 4'b1010)
    begin
    r=(a<b)?1:0;
    
    if(a-b==0)
    zero=1;
    else
    zero=0;
    if(a<b)
    carry=1;
    else
    carry=0;
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b1100)
    begin
   // r=b>>>a;
    r=($signed(b)) >>> a;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    
    
    if(a==0)
    carry=0;
    else if(a<=32)
    carry=b[a-1];
    else
    carry=b[31];
    //carry=
    
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    

    end
    else if (aluc == 4'b1110||aluc == 4'b1111)
    begin
    r=b<<a;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    
    if(a==0)
    carry=0;
    else if(a<=32)
    carry=b[32-a];
    else
    carry=0;
    
    if(r[31]==1)
    negative=1;
    else
    negative=0;

    end
    else if (aluc == 4'b1101)
    begin
    r=b>>a;
    
    if(r==0)
    zero=1;
    else
    zero=0;
    
    
    if(a==0)
    carry=0;
    else if(a<=32)
    carry=b[a-1];
    else
    carry=0;
    //carry=
    
    if(r[31]==1)
    negative=1;
    else
    negative=0;
    
    end
    else
    begin
    
    end
    end
    end
endmodule
