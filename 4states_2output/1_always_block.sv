package fsm1_pkg;
    typedef enum logic [2:0] {IDLE = 3'b000, READ = 3'b001, DLY = 3'b010, DONE = 3'b011, XXX = 'x} state_e; 
endpackage

module fsm1(
    input logic go, ws, rst_n, clk,
    output logic rd, ds
);

 import fsm1_pkg::*;
 state_e state;

 always_ff @(posedge clk, negedge rst_n)
  if(!rst_n) begin
    rd <= '0;
    ds <= '0;
  end

  else begin
    state <= XXX;
    rd <= '0;
    ds <= '0;
    case(state)
        IDLE: if(go) begin
            rd <= '1;
            state <= READ;
            else begin
                state <= IDLE;
            end
        end

        READ: begin
            rd <= '1;
            state <= DLY;
        end

        DLY: if(ws) begin
            rd <= '1;
            state <= READ;
        end
        else begin
            ds <= '1;
            state <= DONE;
        end

        DONE: begin
            state <= IDLE;
        end

        default: begin
            ds <= 'x;
            rd <= 'x;
            state <= XXX;
        end
    endcase
end
endmodule
