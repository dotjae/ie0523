module Generador (
    input clk, 
    input rst,
    input MDIO_START,
    input MDIO_IN,
    input [31:0] T_DATA,
    output reg [15:0] RD_DATA,
    output reg DATA_RDY,
    output reg MDC, 
    output reg MDIO_OE,
    output reg MDIO_OUT
);

localparam  START = 0001,
            SELECT = 0010,
            READ = 0100,
            WRITE = 1000;

reg mdc_count = 0;
reg [1:0] ST, OP, TA;
reg [4:0] PHYADDR, REGADDR; 
reg [15:0] DATA; 

localparam STATE = START;

always @(posedge clk) begin

    if (rst) begin
        RD_DATA <= 0;
        DATA_RDY <= 0;
        MDC <= 0;
        MDIO_OE <= 0;
        MDIO_OUT <= 0;
    end
    else begin
        ST = T_DATA[31:30];
        OP = T_DATA[29:28];
        TA = T_DATA[17:16];
        PHYADDR = T_DATA[27:23];
        REGADDR = T_DATA[22:18];
        DATA = T_DATA[15:0];
        mdc_count += 1;
        MDC <= mdc_count;

        case (STATE)
            START: begin
                
            end
            SELECT: begin
                
            end
            READ: begin
                
            end
            WRITE: begin
                
            end 
            default: START;
        endcase

    end




end

// assign mdc_count = MDC;
    
endmodule