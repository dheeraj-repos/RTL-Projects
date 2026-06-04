/*module divider_Top(  chal rahi hai ye 
    input CLK, start, CLR,
    input [7:0] A,        // Dividend
    input [3:0] B,        // Divisor
    output [7:0] Quotient,
    output [7:0] Remainder,
    output done
);

    wire eqz;
    wire B_is_zero; // NEW: Declare the wire for the B=0 check
    wire LdRem, LdDiv, LdQ, RemSel;

    
    divider_dataPath DP (
        .A(A),
        .B(B),
        .CLK(CLK),
        .CLR(CLR),
        .LdRem(LdRem),
        .LdDiv(LdDiv),
        .LdQ(LdQ),
        .RemSel(RemSel),
        .eqz(eqz),
        .B_is_zero(B_is_zero), // NEW: Connect to DataPath
        .Quotient(Quotient),
        .Remainder(Remainder)
    );

    // calling ControlPath
    divider_controlPath CP (
        .eqz(eqz),
        .B_is_zero(B_is_zero), // NEW: Connect to ControlPath
        .CLK(CLK),
        .CLR(CLR),
        .start(start),
        .LdRem(LdRem),
        .LdDiv(LdDiv),
        .LdQ(LdQ),
        .RemSel(RemSel),
        .done(done)
    );

endmodule*/


            module divider_Top(
                input CLK, start, CLR,
                input [7:0] A,          // Dividend (e.g., SW[7:0])
                input [3:0] B,          // Divisor (e.g., SW[11:8])
                output [7:0] Quotient,
                output [7:0] Remainder,
                output done,            // General completion signal
                output reg RGB1_R, 
                output reg RGB1_G  
            );
                wire eqz;
                wire B_is_zero;
                wire LdRem, LdDiv, LdQ, RemSel;
                wire DBZ_Error;         //Division by Zero flag from CP
                //Instantiate DataPath
                divider_dataPath DP (
                    .A(A),
                    .B(B),
                    .CLK(CLK),
                    .CLR(CLR),
                    .LdRem(LdRem),
                    .LdDiv(LdDiv),
                    .LdQ(LdQ),
                    .RemSel(RemSel),
                    .eqz(eqz),
                    .B_is_zero(B_is_zero),
                    .Quotient(Quotient),
                    .Remainder(Remainder)
                );
                // 2. Instantiate ControlPath (FSM)
               divider_controlPath CP (
                    .eqz(eqz),
                    .B_is_zero(B_is_zero),
                    .CLK(CLK),
                    .CLR(CLR),
                    .start(start),
                    .LdRem(LdRem),
                    .LdDiv(LdDiv),
                    .LdQ(LdQ),
                    .RemSel(RemSel),
                    .done(done),
                    .DBZ_Error(DBZ_Error) // Connect the new DBZ error signal
                );
                // 3. RGB LED Logic (Output Driver)
                always @(*) begin
                    if (DBZ_Error) begin
                        RGB1_R = 1;     // Division by Zero Error -> Glow RED
                        RGB1_G = 0;
                    end else if (done) begin
                        RGB1_R = 0;
                        RGB1_G = 1;     // Normal division completion-> Glow GREEN
                    end else begin
                        RGB1_R = 0;     // System Idle or currently Calculating -> OFF
                        RGB1_G = 0;
                    end
                end
            endmodule 
