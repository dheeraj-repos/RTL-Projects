        `timescale 1ns / 1ps
        //////////////////////////////////////////////////////////////////////////////////
        // Company: 
        // Engineer: 
        // 
        // Create Date: 18.11.2025 18:43:03
        // Design Name: 
        // Module Name: divider_tb
        // Project Name: 
        // Target Devices: 
        // Tool Versions: 
        // Description: 
        // 
        // Dependencies: 
        // 
        // Revision:
        // Revision 0.01 - File Created
        // Additional Comments:
        // 
        //////////////////////////////////////////////////////////////////////////////////
        
        
        /*module divider_tb;
            reg CLK,start,CLR;
            reg [7:0] A;    // dividend
            reg [3:0] B;    // divisor
        
            wire [7:0] Quotient;
            wire [7:0] Remainder;
            wire done;
        
            divider_Top DUT (
                .CLK(CLK),
                .start(start),
                .CLR(CLR),
                .A(A),
                .B(B),
                .Quotient(Quotient),
                .Remainder(Remainder),
                .done(done)
            );
        
           
            always #5 CLK = ~CLK;
        
            initial begin
                CLK = 0;
                start = 0;
                CLR = 1;
                A = 0;
                B = 0;
        
                #10 CLR = 0;
        
                A = 8'd255; 
                B = 4'd0; 
                start = 1;
                #10 start = 0;
        
                wait(done);
                #10;
                //#20000; // Wait 20000 ns (2 us) to ensure the 255 cycles complete
                $finish;
            end
        
        endmodule*/
        
        
        
        /*working testbewch hai ye yaad rkhna 
        module divider_tb;
            reg CLK,start,CLR;
            reg [7:0] A;    // dividend
            reg [3:0] B;    // divisor
        
            wire [7:0] Quotient;
            wire [7:0] Remainder;
            wire done;
        
            divider_Top DUT (
                .CLK(CLK),
                .start(start),
                .CLR(CLR),
                .A(A),
                .B(B),
                .Quotient(Quotient),
                .Remainder(Remainder),
                .done(done)
            );
        
            
            always #5 CLK = ~CLK;
        
            initial begin
                $display("Starting Simulation...");
                // --- Initialization ---
                CLK = 0;
                start = 0;
                CLR = 1;
                A = 0;
                B = 0;
        
                #10 CLR = 0; // Release Reset
        
                // ----------------------------------------------------------------
                // 1. Test Case: 27 / 2 (Expected: Q=13, R=1) - Multi-cycle test
                // ----------------------------------------------------------------
                $display("--- Test 1: 27 / 2 ---");
                A = 8'd27; 
                B = 4'd2; 
                start = 1;
                #10 start = 0;
        
                wait(done); // Wait for the division to complete
                $display("Test 1 Complete. Quotient: %d, Remainder: %d", Quotient, Remainder);
                #20; // Wait a little more before the next test
                
                // ----------------------------------------------------------------
                // 2. Test Case: 255 / 0 (Expected: immediate DONE, Q=0, R=255) - DBZ test
                // ----------------------------------------------------------------
                $display("--- Test 2: 255 / 0 (Division by Zero) ---");
                CLR = 1; #10 CLR = 0; // Reset
                
                A = 8'd255;
                B = 4'd0; // Divisor is zero
                start = 1;
                #10 start = 0;
        
                wait(done); // Should complete instantly (1-2 cycles after start)
                $display("Test 2 Complete. Quotient: %d, Remainder: %d", Quotient, Remainder);
        
                #10;
                $finish;
            end
        
        endmodule*/
        
        
        `timescale 1ns / 1ps
        
            module divider_tb;
                reg CLK, start, CLR;
                reg [7:0] A;    // dividend
                reg [3:0] B;    // divisor
            
                wire [7:0] Quotient;
                wire [7:0] Remainder;
                wire done;
            
                // Instantiate the Top Module
                divider_Top DUT (
                    .CLK(CLK),
                    .start(start),
                    .CLR(CLR),
                    .A(A),
                    .B(B),
                    .Quotient(Quotient),
                    .Remainder(Remainder),
                    .done(done)
                );
                always #5 CLK = ~CLK;
                initial begin
                    
                    CLK = 0; start = 0; A = 0; B = 0;
                    CLR = 1; #10; CLR = 0; #10;         // Assert CLR (Reset)
                    // 1. Test Case: 10 / 3 (Expected: Q=3, R=1) - Multi-cycle test
                    $display("Test 1 (10/3): Q=3, R=1");
                    A = 8'd10; 
                    B = 4'd3; 
                    #3; start = 1; #7; #3; start = 0; #7;// Assert start 
                    wait(done); 
                    $display("Test 1 Complete. Cycles: 4. Final Q: %d, R: %d", Quotient, Remainder);
                    #20;
            
                    // 2. Test Case: 5 / 0 (Expected: Q=0, R=5) - Division by Zero test
                    $display("Test 2 (5/0): Division by Zero");
                    #3; CLR = 1; #7; #3; CLR = 0; #7;
                    A = 8'd5;
                    B = 4'd0; 
                    #3; start = 1; #7; #3; start = 0; #7;// Assert start 
                    wait(done); 
                    $display("Test 2 Complete. Cycles: 2. Final Q: %d, R: %d", Quotient, Remainder);
                    #20;
            
                    // 3. Test Case: 1 / 4 (Expected: Q=0, R=1) - Greater Divisor test
                    $display("Test 3 (1/4): Greater Divisor");
                    #3; CLR = 1; #7; #3; CLR = 0; #7;
                    A = 8'd1;
                    B = 4'd4; 
                    #3; start = 1; #7; #3; start = 0; #7;// Assert start 
                    wait(done);
                    $display("Test 3 Complete. Cycles: 2. Final Q: %d, R: %d", Quotient, Remainder);
                    #10;
                    $finish;
                end
            endmodule 
