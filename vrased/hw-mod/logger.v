`include "ram.v"
module logger 
(
    clk,
    X_stack_reset,
    AC_reset,
    dma_AC_reset,
    dma_detect_reset,
    dma_X_stack_reset,
    atomicity_reset,
    data_addr,
    data_en,
    data_wr,
    dma_addr,
    dma_en,
    pc,
    re,
    rd_addr,
    rd_data,
    clr_ram,
    wr_data,
    wr_addr,
    we
);

input   clk;
input   X_stack_reset;
input   AC_reset;
input   dma_AC_reset;
input   dma_detect_reset;
input   dma_X_stack_reset;
input   atomicity_reset;
input   [15:0]  data_addr;
input   data_en;
input   data_wr;
input   [15:0]  dma_addr;
input   dma_en;
input   [15:0]  pc;
input   re;
input   [15:0] rd_addr;
output  [36:0] rd_data;
input   clr_ram;
output  reg [36:0] wr_data;
output  reg [15:0] wr_addr;
output  reg we;




// reg     [36:0] wr_data;
// reg     we;

// reg     [15:0] wr_addr;
initial
    begin
        wr_addr = 16'd0;
    end

always @(posedge clk)
begin

    if(X_stack_reset == 1'b1) begin
            //assign wr_data = {3'b000, pc, data_addr, data_en, data_wr};
            wr_data[36:34] = 3'b000;
            wr_data[33:18] = pc;
            wr_data[17:2] = data_addr;
            wr_data[1] = data_en;
            wr_data[0] = data_wr;
            assign we = 1;
        end else if(AC_reset) begin
            //assign wr_data = {3'b001, pc, data_addr, data_en, 1'b0};
            wr_data[36:34] = 3'b001;
            wr_data[33:18] = pc;
            wr_data[17:2] = data_addr;
            wr_data[1] = data_en;
            wr_data[0] = 1'b0;
            assign we = 1;
        end else if(atomicity_reset) begin
            //assign wr_data = {3'b010, pc, 18'd0};
            wr_data[36:34] = 3'b010;
            wr_data[33:18] = pc;
            wr_data[17:0] = 18'd0;
            assign we = 1;
        end else if(dma_AC_reset) begin
            //assign wr_data = {3'b011, pc, dma_addr, dma_en, 1'b0};
            wr_data[36:34] = 3'b011;
            wr_data[33:18] = pc;
            wr_data[17:2] = dma_addr;
            wr_data[1] = dma_en;
            wr_data[0] = 1'b0;
            assign we = 1;
        end else if(dma_detect_reset) begin
            //assign wr_data = {3'b100, pc, dma_addr, dma_en, 1'b0};
            wr_data[36:34] = 3'b100;
            wr_data[33:18] = pc;
            wr_data[17:2] = dma_addr;
            wr_data[1] = dma_en;
            wr_data[0] = 1'b0;
            assign we = 1;
        end else if(dma_X_stack_reset) begin
            //assign wr_data = {3'b101, pc, dma_addr, dma_en, 1'b0};
            wr_data[36:34] = 3'b101;
            wr_data[33:18] = pc;
            wr_data[17:2] = dma_addr;
            wr_data[1] = dma_en;
            wr_data[0] = 1'b0;
            assign we = 1;
        end else begin
            wr_data = 37'd0;
            assign we = 0;
        end

    if (clr_ram) begin
        wr_addr <= 16'd0;
    end else if (we) begin
        if (wr_addr < 16'hFFFF)
            wr_addr <= wr_addr + 1;
        else
            wr_addr <= 16'd0;
    end
end



endmodule


