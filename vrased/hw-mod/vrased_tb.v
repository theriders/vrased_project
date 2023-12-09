module tb;
    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 37;
    parameter DEPTH = 2**ADDR_WIDTH;

    reg clk;
    reg [15:0] pc;
    reg data_en;
    reg data_wr;
    reg [15:0] data_addr;
    reg [15:0] dma_addr;
    reg dma_en;
    reg irq;
    wire reset;
    reg clr_ram;

vrased u0 (
    .clk(clk),
    .pc(pc),
    .data_en(data_en),
    .data_wr(data_wr),
    .data_addr(data_addr),
    .dma_addr(dma_addr),
    .dma_en(dma_en),
    .irq(irq),
    .reset(reset),
    .clr_ram(clr_ram)
    );

always #10 clk = ~clk;

initial begin
    {clk, pc, data_en, data_wr, data_addr, dma_addr, dma_en, irq, clr_ram} <= 0;
    repeat (2) @ (posedge clk);
    clr_ram <= 1;
    repeat (2) @ (posedge clk);
    clr_ram <= 0;

    // X_Stack reset test
    pc <= 0;
    data_addr <= 16'h440;
    data_en <= 1;
    repeat (1) @ (posedge clk);
    data_en <= 0;

    //AC reset test
    repeat (1) @ (posedge clk);
    data_addr <= 16'h6A00;
    data_en <= 1;
    repeat (1) @ (posedge clk);
    data_en <= 0;

    //atomicity reset test
    repeat (1) @ (posedge clk);
    pc <= 16'hA000;
    repeat (1) @ (posedge clk);
    pc <= 16'h0000;
    repeat (1) @ (posedge clk);

    repeat (4) @ (posedge clk);

    #20 $finish;

end

endmodule