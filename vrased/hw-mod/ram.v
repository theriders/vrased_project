module ram
    #(
        parameter ADDR_WIDTH = 8,
        parameter DATA_WIDTH = 37)
    (
        input clk,
        input clr,
        input [ADDR_WIDTH-1:0]  wr_addr,
        input [DATA_WIDTH-1:0]  wr_data,
        input                   we,
        input                   re,
        input [ADDR_WIDTH-1:0]  rd_addr,
        output [DATA_WIDTH-1:0] rd_data
    );

    parameter DEPTH = ADDR_WIDTH**2;

    reg [DATA_WIDTH-1:0] tmp_data;
    reg [DATA_WIDTH-1:0] mem [DEPTH-1:0];

    parameter [36:0] zero_37 = 37'd0;
    integer j;
    initial
        begin
            for (j=0; j < ADDR_WIDTH**2; j=j+1) begin
                mem[j] <= zero_37;
            end
        end

    always @ (posedge clk) begin
        if (clr) begin
            for (j=0; j < ADDR_WIDTH**2; j=j+1) begin
                mem[j] <= zero_37;
            end
        end else if (we)
            mem[wr_addr] <= wr_data;
    end

    always @ (posedge clk) begin
        if (re & !we)
            tmp_data <= mem[rd_addr];
    end

    assign rd_data = !we & re ? tmp_data : '0;
endmodule