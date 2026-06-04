//working haiii 
/*module eight_bit_register(
    input  [7:0] D1,
    input CLK, CLR, LOAD,
    output reg [7:0] Q1
);
always @(posedge CLK or posedge CLR) begin
    if(CLR)
        Q1 <= 8'b00000000;
    else if (LOAD)
        Q1 <= D1;
end
endmodule*/




module four_bit_register(
    input  [3:0] D2,
    input CLK, CLR, LOAD,
    output reg [3:0] Q2
);
// Sensitivity list changed: only triggered by CLK
always @(posedge CLK) begin
    if(CLR) // Synchronous Reset: Reset takes effect on the CLK edge
        Q2 <= 4'b0000;
    else if (LOAD)
        Q2 <= D2;
end
endmodule