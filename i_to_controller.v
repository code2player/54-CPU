module i_to_controller(
input [5:0]op,
input [4:0]rs,
input [5:0]func,
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

output  RF_W,
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
    );
    
    //指令种类，组合逻辑构建
    wire i_add,i_addi,i_addu,i_addiu,i_sub,i_subu;
    wire i_and,i_andi,i_or,i_ori,i_xor,i_xori,i_nor;
    wire i_lui;
    wire i_sll,i_sllv,i_sra,i_srav,i_srl,i_srlv;
    wire i_slt,i_slti,i_sltu,i_sltiu;
    wire i_beq,i_bne;
    wire i_j,i_jal,i_jr;
    wire i_lw,i_sw;
    
    //23-extend
    wire i_clz;
    wire i_div,i_divu,i_mul,i_multu;
    wire i_bgez;
    wire i_jalr;
    wire i_lh,i_lhu,i_lb,i_lbu,i_sh,i_sb;
    wire i_mfc0,i_mtc0,i_mfhi,i_mthi,i_mflo,i_mtlo;
    wire i_syscall,i_break,i_teq,i_eret;
    
    //R-TYPE
    assign i_add=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(~func[2])&(~func[1])&(~func[0]);
    assign i_addu=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(~func[2])&(~func[1])&(func[0]);
    assign i_sub=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(~func[2])&(func[1])&(~func[0]);
    assign i_subu=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(~func[2])&(func[1])&(func[0]);
    assign i_and=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(func[2])&(~func[1])&(~func[0]);
    assign i_or=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(func[2])&(~func[1])&(func[0]);
    assign i_xor=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(func[2])&(func[1])&(~func[0]);
    assign i_nor=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(func[2])&(func[1])&(func[0]);
    assign i_slt=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(func[3])&(~func[2])&(func[1])&(~func[0]);
    assign i_sltu=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(func[3])&(~func[2])&(func[1])&(func[0]);
    
    assign i_sll=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(~func[3])&(~func[2])&(~func[1])&(~func[0]);
    assign i_srl=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(~func[3])&(~func[2])&(func[1])&(~func[0]);
    assign i_sra=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(~func[3])&(~func[2])&(func[1])&(func[0]);
    assign i_sllv=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(~func[3])&(func[2])&(~func[1])&(~func[0]);
    assign i_srlv=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(~func[3])&(func[2])&(func[1])&(~func[0]);
    assign i_srav=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(~func[3])&(func[2])&(func[1])&(func[0]);
    assign i_jr=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(func[3])&(~func[2])&(~func[1])&(~func[0]);
    
    //I-TYPE
    assign i_addi=(~op[5])&(~op[4])&(op[3])&(~op[2])&(~op[1])&(~op[0]);
    assign i_addiu=(~op[5])&(~op[4])&(op[3])&(~op[2])&(~op[1])&(op[0]);
    assign i_andi=(~op[5])&(~op[4])&(op[3])&(op[2])&(~op[1])&(~op[0]);
    assign i_ori=(~op[5])&(~op[4])&(op[3])&(op[2])&(~op[1])&(op[0]);
    assign i_xori=(~op[5])&(~op[4])&(op[3])&(op[2])&(op[1])&(~op[0]);
    assign i_lui=(~op[5])&(~op[4])&(op[3])&(op[2])&(op[1])&(op[0]);
    assign i_lw=(op[5])&(~op[4])&(~op[3])&(~op[2])&(op[1])&(op[0]);
    assign i_sw=(op[5])&(~op[4])&(op[3])&(~op[2])&(op[1])&(op[0]);
    assign i_beq=(~op[5])&(~op[4])&(~op[3])&(op[2])&(~op[1])&(~op[0]);
    assign i_bne=(~op[5])&(~op[4])&(~op[3])&(op[2])&(~op[1])&(op[0]);    
    assign i_slti=(~op[5])&(~op[4])&(op[3])&(~op[2])&(op[1])&(~op[0]);
    assign i_sltiu=(~op[5])&(~op[4])&(op[3])&(~op[2])&(op[1])&(op[0]);
    
    //J-TYPE
    assign i_j=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(op[1])&(~op[0]);
    assign i_jal=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(op[1])&(op[0]);
    
    //23条扩展指令  
    assign i_clz=(~op[5])&(op[4])&(op[3])&(op[2])&(~op[1])&(~op[0])&(func[5])&(~func[4])&(~func[3])&(~func[2])&(~func[1])&(~func[0]);
    
    assign i_div=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(func[3])&(~func[2])&(func[1])&(~func[0]);
    assign i_divu=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(func[3])&(~func[2])&(func[1])&(func[0]);
    assign i_mul=(~op[5])&(op[4])&(op[3])&(op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(~func[3])&(~func[2])&(func[1])&(~func[0]);
    //assign i_mult=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(func[3])&(~func[2])&(~func[1])&(~func[0]);
    assign i_multu=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(func[3])&(~func[2])&(~func[1])&(func[0]);

    assign i_bgez=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(op[0]);
    
    assign i_jalr=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(func[3])&(~func[2])&(~func[1])&(func[0]);

    assign i_lh=(op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(op[0]);
    assign i_lhu=(op[5])&(~op[4])&(~op[3])&(op[2])&(~op[1])&(op[0]);
    assign i_lb=(op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0]);
    assign i_lbu=(op[5])&(~op[4])&(~op[3])&(op[2])&(~op[1])&(~op[0]);
    assign i_sb=(op[5])&(~op[4])&(op[3])&(~op[2])&(~op[1])&(~op[0]);
    assign i_sh=(op[5])&(~op[4])&(op[3])&(~op[2])&(~op[1])&(op[0]);
    
    assign i_mfc0=(~op[5])&(op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~rs[4])&(~rs[3])&(~rs[2])&(~rs[1])&(~rs[0]);
    assign i_mtc0=(~op[5])&(op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~rs[4])&(~rs[3])&(rs[2])&(~rs[1])&(~rs[0]);
    assign i_mfhi=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(~func[3])&(~func[2])&(~func[1])&(~func[0]);
    assign i_mthi=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(~func[3])&(~func[2])&(~func[1])&(func[0]);
    assign i_mflo=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(~func[3])&(~func[2])&(func[1])&(~func[0]);
    assign i_mtlo=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(func[4])&(~func[3])&(~func[2])&(func[1])&(func[0]);

    assign i_syscall=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(func[3])&(func[2])&(~func[1])&(~func[0]);
    assign i_break=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(~func[5])&(~func[4])&(func[3])&(func[2])&(~func[1])&(func[0]);
    assign i_teq=(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(func[5])&(func[4])&(~func[3])&(func[2])&(~func[1])&(~func[0]);
    assign i_eret=(~op[5])&(op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0])&(rs[4])&(~rs[3])&(~rs[2])&(~rs[1])&(~rs[0])&(~func[5])&(func[4])&(func[3])&(~func[2])&(~func[1])&(~func[0]);

    
    
    
    
    //实例化，产生控制信号
    controller con(i_add, i_addu, i_addi, i_addiu, i_sub, i_subu,i_and, i_andi, i_or, i_ori, i_xor, i_xori, i_nor,
         i_lui,i_sll, i_sllv, i_sra, i_srav, i_srl, i_srlv,i_slt, i_slti, i_sltu, i_sltiu,i_beq, i_bne,
         i_j, i_jal, i_jr,i_lw, i_sw,
         i_clz,
         i_div,i_divu,i_mul,i_multu,
         i_bgez,
         i_jalr,
         i_lh,i_lhu, i_lb,i_lbu,i_sh,i_sb,
         i_mfc0,i_mtc0,i_mfhi,i_mthi, i_mflo,i_mtlo,
         i_syscall, i_break,i_teq,i_eret,
         
         Z,C,N,O,
         busy_div,busy_divu,
         over_div,over_divu,
         start_div,start_divu,pc_no_add,
         RF_W,ALUC,
         M1,M2,M3,M4,M5,M6,M7,M8,M9,
         DM_W,DMEM_in_type,conv1type,conv2type,loin,hiin,
         mfc0_c,mtc0_c,execption,eret_c,cause);
    
endmodule
