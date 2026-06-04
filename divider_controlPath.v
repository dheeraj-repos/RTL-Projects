/*module divider_controlPath(
    input eqz, B_is_zero, CLK, CLR, start,  // NEW: B_is_zero input
    output reg LdRem, LdDiv, LdQ, RemSel, done
);

    reg [2:0] state, next_state;
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S_DBZ=3'b101; // NEW: S_DBZ state

    /* State Register (Synchronous)
    always @(posedge CLK or posedge CLR) begin
        if(CLR)
            state <= S0;
        else
            state <= next_state;
    end
    */
    /* State Register (Now Fully Synchronous)
    always @(posedge CLK) begin // Removed 'or posedge CLR'
        if(CLR) // Synchronous Reset: Only takes effect on CLK edge
            state <= S0;
        else
            state <= next_state;
    end

    // Next State and Output Logic (Combinational)
    always @(*) begin
        // Default outputs
        LdRem = 0; LdDiv = 0; LdQ = 0; RemSel = 0; done = 0;
        next_state = S0; // Default transition to S0

        case(state)
            S0: begin // IDLE state, waiting for start
                if(start)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin // LOAD A and B
                LdRem = 1; RemSel = 0; // Load Remainder = A
                LdDiv = 1; LdQ = 0;    // Load Divisor = B, Clear Quotient
                
                if(B_is_zero)
                    next_state = S_DBZ;    // JUMP to error state if B=0
                else
                    next_state = S2;       // Continue to check
            end

            S2: begin // CHECK Remainder >= Divisor (eqz == 0)
                if(eqz) // If R < B (eqz is 1), STOP
                    next_state = S4;   // stop dividing
                else
                    next_state = S3;   // continue subtracting
            end

            S3: begin // SUBTRACT and INCREMENT
                RemSel = 1; LdRem = 1; LdQ = 1; // Load R = R-B, Load Q = Q+1
                next_state = S2;
            end

            S4: begin // DONE state
                done = 1;
                next_state = S4;
            end
            
            S_DBZ: begin // NEW: Division By Zero state
                done = 1;
                // Remainder will be A, Quotient will be 0 (as Q was cleared in S1).
                next_state = S_DBZ;
            end

            default: next_state = S0;
        endcase
    end

endmodule*///worjing hai ye dhyan rkhana neeche wla to RGB ke liye kara hai

                module divider_controlPath(
                    input eqz, B_is_zero, CLK, CLR, start,  
                    output reg LdRem, LdDiv, LdQ, RemSel, done,
                    output reg DBZ_Error 
                );
                    reg [2:0] state, next_state;
                    parameter S0=3'b000, S1=3'b001, S2=3'b010, 
                    S3=3'b011, S4=3'b100, S_DBZ=3'b101; 
                
                    // State Register (Fully Synchronous)
                    always @(posedge CLK) begin 
                        if(CLR) 
                            state <= S0;
                        else
                            state <= next_state;
                    end
                
                    // Next State and Output Logic (Combinational)
                    always @(*) begin
                        // Default outputs
                        LdRem = 0; LdDiv = 0; LdQ = 0; RemSel = 0; done = 0; 
                        DBZ_Error = 0;
                        next_state = S0; 
                
                        case(state)
                            S0: begin // IDLE state, waiting for start
                                if(start)
                                    next_state = S1;
                                else
                                    next_state = S0;
                            end
                
                            S1: begin // LOAD A and B (Check for B=0)
                                LdRem = 1; RemSel = 0; 
                                LdDiv = 1; LdQ = 0;    
                                
                                if(B_is_zero)
                                    next_state = S_DBZ;    
                                else
                                    next_state = S2;      
                            end
                
                            S2: begin // CHECK R >= D
                                if(eqz) 
                                    next_state = S4;   
                                else
                                    next_state = S3;   
                            end
                
                            S3: begin // SUBTRACT and INCREMENT
                                RemSel = 1; LdRem = 1; LdQ = 1; 
                                next_state = S2;
                            end
                
                            S4: begin // DONE state (Normal Completion)
                                done = 1;
                                next_state = S4;
                            end
                            
                            S_DBZ: begin // Division By Zero state (Error)
                                done = 1;
                                DBZ_Error = 1; // Assert Error Signal
                                next_state = S_DBZ;
                            end
                
                            default: next_state = S0;
                        endcase
                    end
                
                endmodule
