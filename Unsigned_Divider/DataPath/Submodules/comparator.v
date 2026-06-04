                    module comparator(
                        input [7:0] Rem_check,
                        input [3:0] Div_check,
                        output result
                    );
                    assign result = 
                    (Rem_check < {4'b0000, Div_check}) ? 1'b1 : 1'b0;
                    endmodule


