package fsm_pkg;
    typedef enum logic [1:0] {IDLE = 2'b00, READ = 2'b01, DLY = 2'b10, DONE = 2'b11, XXX = 'x} state_e;
endpackage

module fsm2(
    input logic go, ws,rst_n,
    output logic rd, ds
);

 import fsm_state::*;
 state_e state, next;

    always_ff @(posedge clk, negedge rst_n)
        if(!rst_n) state <= IDLE;
        else state <= next;

    always_comb begin
        next = XXX;
        rd = '0;
        ds = '0;
        case(state)
            IDLE: if(go) next = READ;
                  else next = IDLE;
            READ: begin
                rd = 1;
                next = DLY;
            end
            DLY: begin
                rd = '1;
                if(ws) next = READ;
                else next = DONE;
            end
            DONE: begin
                ds = '1;
                next = IDLE;
            end
            default: begin
                ds = 'x;
                rd = 'x;
                next = XXX;
            end
        endcase
    end

endmodule
