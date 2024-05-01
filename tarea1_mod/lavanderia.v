module Lavanderia (
    input clk,
    input rst,
    input intro_moneda,
    input finalizar_pago,
    output reg SECADO,
    output reg LAVADO,
    output reg LAVADO_PESADO,
    output reg insuficiente
);

reg [3:0] count;
reg [1:0] state;

// State definitions
localparam IDLE = 2'b00;
localparam COUNTING = 2'b01;
localparam VERIFY = 2'b10;

// State transition and counting logic
always @(posedge clk) begin
    if (rst) begin
        count <= 0;
        state <= IDLE;
        SECADO <= 0;
        LAVADO <= 0;
        LAVADO_PESADO <= 0;
        insuficiente <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (intro_moneda) begin
                    state <= COUNTING;
                    count <= count + 1;
                end
            end
            COUNTING: begin
                if (intro_moneda) begin
                    count <= count + 1;
                end
                if (finalizar_pago) begin
                    state <= VERIFY;
                end
            end
            VERIFY: begin
                if (count == 3) begin
                    SECADO <= 1;
                    #30; // Pulse duration for SECADO
                    SECADO <= 0;
                end
                else if (count == 4) begin
                    LAVADO <= 1;
                    #40; // Pulse duration for LAVADO
                    LAVADO <= 0;
                end
                else if (count == 9) begin
                    LAVADO_PESADO <= 1;
                    #90; // Pulse duration for LAVADO_PESADO
                    LAVADO_PESADO <= 0;
                end
                else begin
                    insuficiente <= 1;
                    #10; // Insufficient pulse duration
                    insuficiente <= 0;
                end
                count <= 0; // Resetting the coin count after each transaction
                state <= IDLE; // Returning to IDLE state
            end
        endcase
    end
end

endmodule