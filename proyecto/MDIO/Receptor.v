/******************************
* Codigo de receptor MDIO
*
*   Jose Flores
*   Antonio Franchi
*   Sebastian Rojas
*******************************/


module receptor_mdio(
    input MDC,
    input RESET,
    input [31:0] MDIO_OUT,
    input MDIO_OE,
    input [15:0] RD_DATA,
    output reg MDIO_DONE,
    output reg MDIO_IN,
    output reg [4:0] ADDR,
    output reg [15:0] WR_DATA,
    output reg WR_STB   // Indica que los datos de WR_DATA y ADDR son validos
);

// Parametros locales para los estados de la FSM usando OneHot
localparam  IDLE = 4'b0000,    // Estado base (ground state)
            START = 4'b0001,   // Estado de Inicio/espera
            WRITE = 4'b0010,  // Estado de escritura
            READ = 4'b0100,   // Estado de lectura
            DONE = 4'b1000;   // Estado de transaccion completada

// "Input" MDIO_OUT
reg MDIO_OUT1;

// Variables internas para la FSM
reg [3:0] state;
reg [5:0] data_counter;
reg [31:0] shift_reg; // Reg de desplazameinto para guardar los bits de entrada
reg internal_rst = 0;     // Señal de reinicio interno

// Variables intenas para las posiciones del frame format de Basic MDIO
reg [1:0] ST, OP, TA;
reg [4:0] PHYADDR, REGADDR;
reg [15:0] DATA;

// Asignacion de posiciones del frame format de Basic MDIO
always @(*) begin
    ST = MDIO_OUT[31:30];
    OP = MDIO_OUT[29:28];
    PHYADDR = MDIO_OUT[27:23];
    REGADDR = MDIO_OUT[22:18];
    TA = MDIO_OUT[17:16];
    DATA = MDIO_OUT[15:0];

    if (!RESET || internal_rst) begin
        // Se reinician de todas las señales
        state <= IDLE;
        MDIO_DONE <= 0;
        MDIO_IN <= 0;
        ADDR <= 0;
        WR_DATA <= 0;
        WR_STB <= 0;
        data_counter <= 0;
        internal_rst <= 0;
    end
end

always @(posedge MDC)begin
    if (state == IDLE && (OP == 2'b00 || OP == 2'b01))
        state <= START;
end

always @(posedge MDC) begin
        // Logica de la FSM
        case (state)
            // Estado de Inicio
            START: begin
                if (MDIO_OE) begin
                    MDIO_OUT1 <= MDIO_OUT[31 - data_counter];
                    data_counter <= data_counter + 1;
                    if (data_counter == 31) begin
                        // Proximo estado basado en el tipo de OP
                        state <= (OP == 2'b01) ? WRITE : READ;
                        ADDR <= PHYADDR;  // Asigna la dir desde el registro de desplazamiento
                        WR_DATA <= DATA;  // Asigna datos de escritura desde el registro de desplazamiento
                        data_counter <= 0;
                    end
                end
            end
            // Estado de escritura
            WRITE: begin
                WR_STB <= 1;  // Indica datos son validos para Write
                MDIO_DONE <= 1; 
                state <= DONE;  // Pasa al estado de transaccion completada
            end
            // Estado de lectura
            READ: begin
                MDIO_IN <= MDIO_OUT[15 - data_counter];  // Enviar datos de lectura desde RD_DATA
                data_counter <= data_counter + 1;
                if (data_counter == 15) begin
                    MDIO_DONE <= 1;
                    state <= DONE;
                end
            end
            // Estado de transaccion completada
            DONE: begin
                WR_STB <= 0;  // Desactiva señal de escritra
                MDIO_DONE <= 0; // Desactiva señal de transac completada
                state <= IDLE;  // Pasa a estado de base
                internal_rst <= 1;
            end
            // Estado por default
            default: state = START;
        endcase
    end


endmodule