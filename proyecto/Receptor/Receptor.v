module receptor (
    input rst, MDC, mdio_oe, mdio_out,
    input [15:0] rd_data,
    output reg mdio_in, mdio_done, wr_stb,
    output reg [4:0] addr,
    output reg [15:0] wr_data
);
    
    localparam  START = 3'b000,
                RECEIVE = 3'b010,
                SEND = 3'b100;

    always @(posedge MDC) begin
        if (!rst) begin
            mdio_in <= 0;
            mdio_done <= 0;
            wr_stb <= 0;
        end else begin
            
        end
    end

endmodule