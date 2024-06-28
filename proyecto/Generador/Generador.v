// GENERADOR MDIO

module generador (
    input clk, rst, mdio_start, mdio_in,
    input [31:0] t_data,
    output reg MDC, mdio_oe, mdio_out, data_rdy,
    output reg [15:0] rd_data
);
    
    localparam  START = 001,
                READ = 010,
                WRITE = 100;

    reg [2:0] state;
    reg [2:0] next_state;

    reg [1:0] mdc_count = 0;
    reg [5:0] count_1;
    reg [4:0] count_2;

    reg ST = T_DATA[31:30];
    reg OP = T_DATA[29:28];
    reg TA = T_DATA[17:16];
    reg PHYADDR = T_DATA[27:23];
    reg REGADDR = T_DATA[22:18];
    reg DATA = T_DATA[15:0];


    always @(posedge clk) begin
        if (rst) begin
            rd_data <= 0;
            data_rdy <= 0;
            MDC <= 0;
            mdio_oe <= 0;
            mdio_out <= 0;
            count_1 <= 6'd32;
            count_2 <= 5'd16;
        end else begin
            mdc_count += 1;
            MDC <= mdc_count;
            if (mdio_start)
                state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            START: begin
                if (OP == 10 && posedge MDC) begin
                    next_state <= READ;
                end else if (OP == 01 && posedge MDC) begin
                    next_state <= WRITE;
                end
            end
            READ: begin
                mdio_out <= t_data[count_1 - 1];
                mdio_oe = (count_1 < 16);
                if (posedge MDC && count_1 < 16) begin
                    rd_data[count_2 - 1] = mdio_in;
                    count_2 <= count_2 - 1;
                    if (count_1 == 0) begin
                        next_state <= START;
                    end
                end
                count_1 <= count_1 - 1;
            end
            WRITE: begin
                mdio_oe <= 1;
                mdio_out <= t_data[count_1 - 1];
                count_1 <= count_1 - 1;
                if (count == 0)
                    next_state <= START;
            end
            default: 
        endcase
    end

endmodule