module cpu(
input clk_in,
input reset,
output [31:0] pc_out,
input [31:0] imem_out,
input [31:0] dmem_out,
output [31:0] rt_out,
output [31:0] alu_out,

input [31:0] exc_addr_out,
input [31:0] rdata_out,

output [31:0] conv1_data_out32,
output [15:0] conv1_data_out16,
output [7:0] conv1_data_out8,
output [31:0] conv2_data_out,

    output [63:0] mult_z_out,
    output [63:0] multu_z_out,
    output [31:0] div_r_out,
    output [31:0] div_q_out,
    output [31:0] divu_r_out,
    output [31:0] divu_q_out,
    
    output [31:0] hilo_hi_out,
    output [31:0] hilo_lo_out,

output Z,
output C,
output N,
output O,

//output busy_mult,
//output busy_multu,
output busy_div,
output busy_divu,
//output over_mult,
//output over_multu,
output over_div,
output over_divu,

//input start_mult,
//input start_multu,
input start_div,
input start_divu,
input pc_no_add,
//input  PC_CLK,
//input  IM_R,
input  RF_W,
//input  RF_CLK,
input  [3:0]ALUC,

input  [1:0]M1,
input  M2,
input  [1:0]M3,
input  [2:0]M4,
input  [1:0]M5,
input  M6,
input  M7,
input  [2:0]M8,
input  [2:0]M9,

//input  DM_W,
input [1:0]conv1type,//sw:00,sh:01,sb:10
input [2:0]conv2type,//lw:000,lh:001,lhu:010,lb:011,lbu:100
input loin,
input hiin

/*input mfc0_c,
input mtc0_c,
input execption,
input eret_c,
input [4:0]cause*/


    );
    

    
    //各个部件的输出
    /*------------------------*/
    wire [31:0] mux1_out;
    wire [31:0] mux2_out;
    wire [31:0] mux3_out;
    wire [31:0] mux4_out;
    wire [4:0] mux5_out;
    wire [31:0] mux6_out;
    wire [31:0] mux7_out;
    wire [31:0] mux8_out;
    wire [31:0] mux9_out;
    
    wire [31:0] ext16_out;
    wire [31:0] s_ext16_out;
    wire [31:0] s_ext18_out;
    wire [31:0] ext5_out;
    
    wire [31:0] join_out;
   // wire [31:0] pc_out;
    wire [31:0] npc_out;
    //wire [31:0] imem_out;
   // wire [31:0] dmem_out;
   // wire [31:0] dmem_data_out;
    wire [31:0] add_out;
    wire [31:0] rs_out;
   // wire [31:0] rt_out;
    //wire [31:0] alu_out;
    
    
    

    
    /*wire [63:0] mult_z_out;
    wire [63:0] multu_z_out;
    wire [31:0] div_r_out;
    wire [31:0] div_q_out;
    wire [31:0] divu_r_out;
    wire [31:0] divu_q_out;
    
    wire [31:0] hilo_hi_out;
    wire [31:0] hilo_lo_out;*/
    

    
    /*------------------------*/
    
    
    //选择器部分
    selector41 mux1(mux7_out,mux6_out,exc_addr_out,32'b0,M1,mux1_out);
    selector21 mux2(ext5_out,rs_out,M2,mux2_out);
    selector41 mux3(rt_out,ext16_out,s_ext16_out,32'b0,M3,mux3_out);
    selector81 mux4(alu_out,npc_out,conv2_data_out,hilo_hi_out,hilo_lo_out,rdata_out,mult_z_out[31:0],32'b0,M4,mux4_out);
    selector41_5 mux5(imem_out[15:11],imem_out[20:16],5'b11111,5'b0,M5,mux5_out);
    selector21 mux6(npc_out,add_out,M6,mux6_out);
    selector21 mux7(rs_out,join_out,M7,mux7_out);
    selector81 mux8(mult_z_out[63:32],multu_z_out[63:32],div_r_out,divu_r_out,rs_out,32'b0,32'b0,32'b0,M8,mux8_out);
    selector81 mux9(mult_z_out[31:0],multu_z_out[31:0],div_q_out,divu_q_out,rs_out,32'b0,32'b0,32'b0,M9,mux9_out);
    
    //扩展器部分
    EXT_16 cpu_ext1 (imem_out[15:0],ext16_out);
    S_EXT_16 cpu_ext2 (imem_out[15:0],s_ext16_out);
    S_EXT_18 cpu_ext3 ({imem_out[15:0],2'b00},s_ext18_out);
    EXT_5 cpu_ext4 (imem_out[10:6],ext5_out);
    
    joint_pc_im jpi({imem_out[25:0],2'b00},pc_out[31:28],join_out);
    pc promc (clk_in,reset,pc_no_add,mux1_out,pc_out);
    ADD npromc(pc_out,4,npc_out);
    ADD add2(s_ext18_out,npc_out,add_out);
    
    
    Regfiles cpu_ref(clk_in,reset,RF_W,imem_out[25:21],imem_out[20:16],mux5_out,mux4_out,rs_out,rt_out);
    alu ALunit(mux2_out,mux3_out,ALUC,reset,alu_out,Z,C,N,O);
    
    MULT mu1(clk_in,reset,rs_out,rt_out,mult_z_out);
    MULTU mu2(clk_in,reset,rs_out,rt_out,multu_z_out);
    DIV di1(rs_out,rt_out,start_div,clk_in,reset,div_q_out,div_r_out,busy_div,over_div);
    DIVU di2(rs_out,rt_out,start_divu,clk_in,reset,divu_q_out,divu_r_out,busy_divu,over_divu);
    
    HILO hl(clk_in,reset,mux8_out,mux9_out,hiin,loin,hilo_hi_out,hilo_lo_out);
    
    MEM_CONV1 mc1(conv1type,alu_out[1:0],rt_out,conv1_data_out32,conv1_data_out16,conv1_data_out8); 
    MEM_CONV2 mc2(conv2type,alu_out[1:0],dmem_out,conv2_data_out); 
    
    
endmodule
