module instruction_to_control(
input [31:0]instru,
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
    
        i_to_controller i_to_con(instru[31:26],instru[25:21],instru[5:0],
        Z,C,N,O,
        busy_div,busy_divu,
        over_div,over_divu,
        start_div,start_divu,pc_no_add,
        RF_W,ALUC,
        M1,M2,M3,M4,M5,M6,M7,M8,M9,
        DM_W,DMEM_in_type,conv1type,conv2type,loin,hiin,
        mfc0_c,mtc0_c,execption,eret_c,cause);
    
endmodule
