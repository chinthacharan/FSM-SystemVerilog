package fsm2_10_pkg;
    typedef enum logic [3:0] {S0 = 4'b0000,
                              S1 = 4'b0001,
                              S2 = 4'b0010,
                              S3 = 4'b0011,
                              S4 = 4'b0100
                              S5 = 4'b0101,
                              S6 = 4'b0110,
                              S7 = 4'b0111,
                              S8 = 4'b1000,
                              S9 = 4'b1001,
                              XXX = 'x} state_e;
endpackage

module fsm2_10(
    input logic rst_n, go, jmp, sk0, sk1, clk,
    output logic y1, y2, y3
);

 import fsm2_10_pkg::*;
 state_e state, next;

    always_ff @(posedge clk, negedge rst_n)
        if(!rst_n) state <= S0;
        else state <= next;
    always_comb begin
        y1 = '0;
        y2 = '0;
        y3 = '0;
        next = XXX;
        case(state)
            S0: if(go && !jmp) next = S1;
            else if(go && jmp) next = S3;
            else next = S0;

            S1: begin
                y2 = '1;
                if(!jmp) next = S2;
                else next = S3;
            end

            S2: if(!jmp) next = S9;
            else next = S3;

            S3: begin
                y1 = '1;
                y2 = '1;
                if(!jmp) next = S4;
                else next = S3;
            end

            S4: if(!sk0 && !jmp) next = S5;
            else if(sk0 && !jmp) next = S6;
            else next = S3;

            S5: if(jmp) next = S3;
            else if(sk1 && sk0 && !jmp) next = S9;
            else if(sk1 && !sk0 && !jmp) next = S8;
            else if(!sk1 && sk0 && !jmp) next = S7;
            else next = S6;

            S6: begin
                y1 = '1;
                y2 = '1;
                y3 = '1;
                if(jmp) next = S3;
                else if(!go && !jmp) next = S6;
                else next = S7;
            end

            S7: begin
                y3 = '1;
                if(jmp) next = S3;
                else next = S8;
            end

            S8: begin
                y2 = '1;
                y3 = '1;
                if(jmp) next = S3;
                else next = S9;
            end

            S9: begin
                y1 = '1;
                y2 = '1;
                y3 = '1;
                if(jmp) next = S3;
                else next = S0;
            end

            default: begin
                y1 = '0;
                y2 = '0;
                y3 = '0;
                next = XXX;
            end
        endcase
    end
endmodule

