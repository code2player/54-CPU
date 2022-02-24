module sccomp_dataflow(
input clk_in,
input reset,
output [31:0] inst,
output [31:0] pc
    );
    
                            //控制信号
/*------------------------*/
wire Z;
wire C;
wire N;
wire O;
//wire busy_mult;
//wire busy_multu;
wire busy_div;
wire busy_divu;
//wire over_mult;
//wire over_multu;
wire over_div;
wire over_divu;

//wire start_mult;
//wire start_multu;
wire start_div;
wire start_divu;
wire pc_no_add;
// wire  PC_CLK;
//  wire  IM_R;
wire  RF_W;
// wire  RF_CLK;
wire  [3:0]ALUC;

wire  [1:0]M1;
wire  M2;
wire  [1:0]M3;
wire  [2:0]M4;
wire  [1:0]M5;
wire  M6;
wire  M7;
wire  [2:0]M8;
wire  [2:0]M9;

wire  DM_W;
wire [1:0]DMEM_in_type;
wire [1:0]conv1type;//sw:00,sh:01,sb:10
wire [2:0]conv2type;//lw:000,lh:001,lhu:010,lb:011,lbu:100
wire loin;
wire hiin;
wire mfc0_c;
wire mtc0_c;
wire exception;
wire eret_c;
wire [4:0]cause;

/*------------------------*/
//wire [31:0] imem_out;
wire [31:0] dmem_out;
wire [31:0] rt_out;
wire [31:0] alu_out;

wire [31:0] exc_addr_out;
wire [31:0] rdata_out;

wire [31:0] conv1_data_out32;
wire [15:0] conv1_data_out16;
wire [7:0] conv1_data_out8;
wire [31:0] conv2_data_out;

wire [31:0] im_addr;
wire [31:0] dm_addr;

wire [63:0] mult_z_out;
wire [63:0] multu_z_out;
wire [31:0] div_r_out;
wire [31:0] div_q_out;
wire [31:0] divu_r_out;
wire [31:0] divu_q_out;

wire [31:0] hilo_hi_out;
wire [31:0] hilo_lo_out;


wire intr;
wire [31:0] status;
wire timer_int;

//wire [31:0]pcx;

    //assign pc=pcx- 32'h00400000;
    
    assign im_addr =  pc- 32'h00400000;

    assign dm_addr =  alu_out- 32'h10010000;
    
    IMEM_ip imemory(im_addr[12:2],inst);
    DMEM dmemory(clk_in,DMEM_in_type,dm_addr[1:0],DM_W,dm_addr[12:2],conv1_data_out32,conv1_data_out16,conv1_data_out8,dmem_out);
    
    //注意pcx和pc的转换关系
    cpu sccpu(clk_in,reset,pc,inst,dmem_out,rt_out,alu_out,exc_addr_out,rdata_out,
    conv1_data_out32,conv1_data_out16,conv1_data_out8,conv2_data_out,
     mult_z_out,multu_z_out,div_r_out,div_q_out,divu_r_out,divu_q_out,
       hilo_hi_out,hilo_lo_out,
    Z,C,N,O,
    busy_div,busy_divu,
    over_div,over_divu,
    start_div,start_divu,pc_no_add,
    RF_W,ALUC,
    M1,M2,M3,M4,M5,M6,M7,M8,M9,
    conv1type,conv2type,loin,hiin);
    
    
    instruction_to_control itc(
    inst,
    Z,C,N,O,
    busy_div,busy_divu,
    over_div,over_divu,
    start_div,start_divu,pc_no_add,
    RF_W,ALUC,
    M1,M2,M3,M4,M5,M6,M7,M8,M9,
    DM_W,DMEM_in_type,conv1type,conv2type,loin,hiin,
    mfc0_c,mtc0_c,exception,eret_c,cause);
    
    CP0 cp0_uut(clk_in,reset,mfc0_c,mtc0_c,pc,inst[15:11],rt_out,exception,eret_c,cause,intr,rdata_out,status,timer_int,exc_addr_out);
    
    
endmodule
