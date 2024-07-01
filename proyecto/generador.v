`timescale 1ns/1ns

module Generador (
    input clk, 
    input rst,
    input MDIO_START,
    input [15:0] MDIO_IN,
    input [31:0] T_DATA,
    output reg [15:0] RD_DATA,
    output reg DATA_RDY,
    output reg MDC, 
    output reg MDIO_OE,
    output reg MDIO_OUT
);

localparam  START = 4'b0001,
            // SELECT = 4'b0010,
            READ = 4'b0100,
            WRITE = 4'b1000;

reg mdc_counter = 0;
reg [5:0] data_counter = 0;
reg internal_rst = 0;

reg [1:0] ST, OP, TA;
reg [4:0] PHYADDR, REGADDR; 
reg [15:0] DATA; 

reg [3:0] STATE = 0;



always @(*) begin

    ST <= T_DATA[31:30];
    OP <= T_DATA[29:28];
    TA <= T_DATA[17:16];
    PHYADDR <= T_DATA[27:23];
    REGADDR <= T_DATA[22:18];
    DATA <= T_DATA[15:0];

    if (!rst || internal_rst) begin
        RD_DATA <= 0;
        DATA_RDY <= 0;
        MDC <= 0;
        MDIO_OE <= 0;
        MDIO_OUT <= 0;
        internal_rst <= 0;
        STATE <= START;
        data_counter <= 0;
    end
end

// MDC clock
always @(posedge clk) begin
    mdc_counter += 1;
    MDC <= mdc_counter; 
end

always @(posedge MDC) begin

    case (STATE)
        START: begin
            if (MDIO_START == 1) begin
                STATE = (OP == 00) ? READ : WRITE;
            end
            else begin
                STATE = START;
            end
        end
        READ: begin
            MDIO_OUT = T_DATA[31-data_counter];
            MDIO_OE <= (data_counter < 16) ? 1 : 0;


            if (data_counter >= 16) begin
                RD_DATA[data_counter-16] <= MDIO_IN[data_counter-16];
            end


            data_counter += 1;
            if (data_counter > 32) begin
                DATA_RDY <= 1;
                #20
                internal_rst <= 1;
                STATE = START;
            end
            else begin
                STATE = READ;
            end
        end

        WRITE: begin
            MDIO_OUT = T_DATA[31-data_counter];
            MDIO_OE <= 1;
            data_counter += 1;

            if (data_counter > 32) begin
                MDIO_OE <= 0;
                internal_rst <= 1;
                STATE = START;
            end
            else begin
                STATE = WRITE;
            end            
        end 
        default: STATE = START;
    endcase
end    
endmodule