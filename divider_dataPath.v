            module divider_dataPath(
                input  [7:0] A,                     // Dividend
                input  [3:0] B,                     // Divisor
                input  CLK, CLR,
                input  LdRem, LdDiv, LdQ, RemSel,   // Control from Controller
                output eqz,
                output B_is_zero,                  // Flag for B == 0
                output [7:0] Quotient,
                output [7:0] Remainder
            );
            
                wire [7:0] Rem_out, Rem_in;
                wire [3:0] Div_out;
                wire [7:0] Sub_out;
                wire [7:0] Q_out, Q_inc;
            
                assign B_is_zero = (B == 4'd0); // B is a 4-bit input
            
                // --------------- REGISTERS ------------------
                eight_bit_register Remainder_Reg(
                    .D1(Rem_in), .CLK(CLK), .CLR(CLR), .LOAD(LdRem), .Q1(Rem_out)
                );
            
                four_bit_register Divisor_Reg(
                    .D2(B), .CLK(CLK), .CLR(CLR), .LOAD(LdDiv), .Q2(Div_out)
                );
            
                eight_bit_register Quot_Reg(
                    .D1(Q_inc), .CLK(CLK), .CLR(CLR), .LOAD(LdQ), .Q1(Q_out)
                );
            
                // --------------- SUBTRACTOR -----------------
                subtractor_8bit SUB(
                    .Remain(Rem_out), .Div(Div_out), .Sub_out(Sub_out)
                );
            
                // --------------- COMPARATOR -----------------
                // eqz = 1 when remainder < divisor (STOP condition)
                comparator CMP(
                    .Rem_check(Rem_out), .Div_check(Div_out), .result(eqz)
                );
            
                // --------------- MUX FOR REMAINDER LOAD -----
                mux2_8bit RemMUX(
                    .A(A), .B(Sub_out), .Sel(RemSel), .Y(Rem_in)
                );
            
                // --------------- QUOTIENT INCREMENTER -------
                incrementer_8bit INC(
                    .Q_in(Q_out), .Q_out(Q_inc)
                );
            
                // --------------- OUTPUTS --------------------
                assign Quotient  = Q_out;
                assign Remainder = Rem_out;
            
            endmodule
