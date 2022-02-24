module controller(

//input：输入的指令种类
input i_add,input i_addu,input i_addi,input i_addiu,input i_sub,input i_subu,
    input i_and,input i_andi,input i_or,input i_ori,input i_xor,input i_xori,input i_nor,
    input i_lui,
    input i_sll,input i_sllv,input i_sra,input i_srav,input i_srl,input i_srlv,
    input i_slt,input i_slti,input i_sltu,input i_sltiu,
    input i_beq,input i_bne,
    input i_j,input i_jal,input i_jr,
    input i_lw,input i_sw,
    input i_clz,
    input i_div,input i_divu,input i_mult,input i_multu,
    input i_bgez,
    input i_jalr,
    input i_lh,input i_lhu,input i_lb,input i_lbu,input i_sh,input i_sb,
    input i_mfc0,input i_mtc0,input i_mfhi,input i_mthi,input i_mflo,input i_mtlo,
    input i_syscall,input i_break,input i_teq,input i_eret,
    
//input:ALU状态信号，决定是否写入等操作
input Z,
input C,
input N,
input O,


input busy_div,
input busy_divu,

input over_div,
input over_divu,

output start_div,
output start_divu,
output pc_no_add,

//output：控制信号
//output  PC_CLK,
//output  IM_R,
//output  [4:0]rsc,
//output  [4:0]rtc,
//output  [4:0]rdc,
output  RF_W,
//output  RF_CLK,
output  [3:0]ALUC,

output  [1:0]M1,
output  M2,
output  [1:0]M3,
output  [2:0]M4,
output  [1:0]M5,
output  M6,
output  M7,
output  [2:0]M8,
output  [2:0]M9,

//output  CS,
//output  DM_R,
output  DM_W,
output [1:0]DMEM_in_type,
output [1:0]conv1type,//sw:00,sh:01,sb:10
output [2:0]conv2type,//lw:000,lh:001,lhu:010,lb:011,lbu:100
output loin,
output hiin,
output mfc0_c,
output mtc0_c,
output execption,
output eret_c,
output [4:0]cause
//output start

    );
    
    
   // assign start_mult=i_mult&(~busy_mult)&(~over_mult);
 //   assign start_multu=i_multu&(~busy_multu)&(~over_multu);
    assign start_div=i_div&(~busy_div)&(~over_div);
    assign start_divu=i_divu&(~busy_divu)&(~over_divu);
    assign pc_no_add=busy_div|busy_divu|start_div|start_divu;

    //assign PC_CLK=1;
    //assign IM_R=1;
    
    //由此可见regfle的rd在下降沿写入，根据运算结果决定
    assign RF_W=((~O)&(i_add|i_addi|i_sub))|(i_addu)|(i_addiu)|(i_subu)|(i_and)|(i_andi)|(i_or)|(i_ori)|
    (i_xor)|(i_xori)|(i_nor)|(i_lui)|(i_sll)|(i_sllv)|(i_sra)|(i_srav)|(i_srl)|(i_srlv)|
    (i_slt)|(i_slti)|(i_sltu)|(i_sltiu)|(i_jal)|(i_lw)|i_clz|i_jalr|i_lh|i_lhu|i_lb|i_lbu|i_mfc0|i_mflo|i_mfhi|i_mult;
    
    //assign RF_CLK=
    
   // assign ALUC=2;
    assign ALUC[3]=(i_lui)|(i_sll)|(i_sllv)|(i_sra)|(i_srav)|(i_srl)|(i_srlv)|(i_slt)|(i_slti)|(i_sltu)|(i_sltiu)|i_clz;  
    assign ALUC[2]=(i_and)|(i_andi)|(i_or)|(i_ori)|(i_xor)|(i_xori)|(i_nor)|(i_sll)|(i_sllv)|(i_sra)|(i_srav)|(i_srl)|(i_srlv);    
    assign ALUC[1]=(i_add)|(i_addi)|(i_sub)|(i_xor)|(i_xori)|(i_nor)|(i_sll)|(i_sllv)|(i_slt)|(i_slti)|(i_sltu)|(i_sltiu)|(i_lw)|(i_sw)|i_lh|i_lhu|i_lb|i_lbu|i_sh|i_sb|i_bgez;  
    assign ALUC[0]=(i_sub)|(i_subu)|(i_or)|(i_ori)|(i_nor)|(i_srl)|(i_srlv)|(i_slt)|(i_slti)|(i_beq)|(i_bne)|i_clz|i_bgez|i_teq;
    
    
    
    assign M1[0]=(i_add)|(i_addu)|(i_addi)|(i_addiu)|(i_sub)|(i_subu)|(i_and)|(i_andi)|(i_or)|(i_ori)|
    (i_xor)|(i_xori)|(i_nor)|(i_lui)|(i_sll)|(i_sllv)|(i_sra)|(i_srav)|(i_srl)|(i_srlv)|
    (i_slt)|(i_slti)|(i_sltu)|(i_sltiu)|(i_beq)|(i_bne)|(i_lw)|(i_sw)|i_bgez|i_lh|i_lhu|i_lb|i_lbu|i_sh|i_sb|
    i_mult|i_multu|i_div|i_divu|i_mfc0|i_mtc0|i_mflo|i_mtlo|i_mfhi|i_mthi|i_clz|(~Z&i_teq);    
    assign M1[1]=i_syscall|i_break|(Z&i_teq)|i_eret;
    
    assign M2=(i_add)|(i_addu)|(i_addi)|(i_addiu)|(i_sub)|(i_subu)|(i_and)|(i_andi)|(i_or)|(i_ori)|
    (i_xor)|(i_xori)|(i_nor)|(i_lui)|(i_sllv)|(i_srav)|(i_srlv)|
    (i_slt)|(i_slti)|(i_sltu)|(i_sltiu)|i_clz|i_teq|(i_beq)|(i_bne)|i_bgez|i_jalr;
    
    assign M3[0]=i_andi|i_ori|i_xori|i_lui|i_bgez;
    assign M3[1]=i_addi|i_addiu|i_slti|i_sltiu|i_lw|i_lh|i_lhu|i_lb|i_lbu|i_sw|i_sh|i_sb|i_bgez;
    
    assign M4[0]=i_jal|i_jalr|i_mfc0|i_mfhi;
    assign M4[1]=i_lw|i_lh|i_lhu|i_lb|i_lbu|i_mfhi|i_mult;
    assign M4[2]=i_mfc0|i_mflo|i_mult;
    
    
    assign M5[0]=i_addi|i_addiu|i_andi|i_ori|i_xori|i_lui|i_slti|i_sltiu|i_beq|i_bne|i_bgez|i_lw|i_lh|i_lhu|i_lb|i_lbu|i_sw|i_sh|i_sb|i_mfc0;
    assign M5[1]=i_jal;
    
    //assign M6=i_beq|i_bne|i_bgez|i_mfc0|i_mtc0|i_mflo|i_mtlo|i_mfhi|i_mthi;
    assign M6=(Z&i_beq)|(~Z&i_bne)|(~N&i_bgez);
    
    assign M7=i_j|i_jal;
    
    assign M8[0]=i_multu|i_divu;
    assign M8[1]=i_div|i_divu;
    assign M8[2]=i_mthi;
    
    assign M9[0]=i_multu|i_divu;
    assign M9[1]=i_div|i_divu;
    assign M9[2]=i_mtlo;


    
    //assign CS=(i_lw)|(i_sw);
    //assign DM_R=(i_lw);
    assign DM_W=(i_sw)|i_sh|i_sb;
    
    assign DMEM_in_type[0]=i_sh;
    assign DMEM_in_type[1]=i_sb;
    
    assign conv1type[0]=i_sh;
    assign conv1type[1]=i_sb;
    
    assign conv2type[0]=i_lh|i_lb;
    assign conv2type[1]=i_lhu|i_lb;
    assign conv2type[2]=i_lbu;
    
    assign loin=i_mult|i_multu|i_div|i_divu|i_mtlo;
    assign hiin=i_mult|i_multu|i_div|i_divu|i_mthi;
    
    assign mfc0_c=i_mfc0;
    assign mtc0_c=i_mtc0;
    
    assign execption=i_syscall|i_break|(Z&i_teq)|i_eret;
    assign eret_c=i_eret;
    
    assign cause[0]=i_break|i_teq;
    assign cause[1]=0;
    assign cause[2]=i_teq;
    assign cause[3]=1;
    assign cause[4]=0;
    


endmodule
