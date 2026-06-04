            module subtractor_8bit(
                input  [7:0] Remain,
                input  [3:0] Div,
                output [7:0] Sub_out
            );
            assign Sub_out = Remain - {4'b0000, Div};
            endmodule



