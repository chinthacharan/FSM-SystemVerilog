package fsm10_pkg;
    typedef enum logic [3:0] {S0 = 4'b0000,
                              S1 = 4'b0001,
                              S2 = 4'b0010,
                              S3 = 4'b0011,
                              S4 = 4'b0110, 
                              S5 = 4'b0101,
                              S6 = 4'b0110,
                              S7 = 4'b0111,
                              S8 = 4'b1000,
                              S9 = 4'b1001,
                              XXX = 'x} state_e;
endpackage

module fsm(
    input logic rst_n, clk, jmp, go,
    output logic y1
);

 import fsm10_pkg::*;
 state_e state, next;

 always_ff @(posedge clk, negedge rst_n)
    if(!rst_n) state <= S0;
    else state <= next;
 
 always_comb begin
    y1 = '0;
    next = XXX; 
    case(state) 
        S0: if(go && !jump) begin
            next = S1;
        end
        else if(go && jmp) next = S3;
        else if(!go) next = S0;

        S1: if(!jmp) next = S2;
        else next = S3;

        S2: next = S3;

        S3: begin
            y1 = '1;
            if(jmp) next = S3;
            else next = S4;
        end

        S4: if(jmp) next = S3;
        else next = S5;

        S5: if(jmp) next = S3;
        else next = S6;

        S6: if(!jmp) next = S7;
        else next = S3;

        S7: if(jmp) next = S3;
        else next = S8;

        S8: if(jmp) next = S3;
        else next = S9;

        S9: if(jmp) next = S3;
        else next = S0;

        default: begin
            y1 = '0;
            next = XXX;
        end
    endcase
 end
endmodule
