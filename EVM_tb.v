`timescale 1ns/1ps  

module EVM_tb;  
    // Testbench signals  
    reg clk, reset;  
    reg v1, v2, v3, v4;  
    wire [7:0] cd1, cd2, cd3, cd4;  
    wire [3:0] winner;  
    
    // Instantiate the EVM module  
    EVM uut (  
        .clk(clk),  
        .reset(reset),  
        .v1(v1),  
        .v2(v2),  
        .v3(v3),  
        .v4(v4),  
        .cd1(cd1),  
        .cd2(cd2),  
        .cd3(cd3),  
        .cd4(cd4),  
        .winner(winner)  
    );  
    
    // Clock Generation  
    always #5 clk = ~clk;  // 10 ns period clock  

    // Test Procedure  
    initial begin  
        // Initialize signals  
        clk = 0;  
        reset = 1;  
        v1 = 0; v2 = 0; v3 = 0; v4 = 0;  

        // Apply Reset  
        #10 reset = 0;  

        // Voting Sequence  
        #10 v1 = 1;  // Vote for Candidate 1  
        #10 v1 = 0;  

        #10 v2 = 1;  // Vote for Candidate 2  
        #10 v2 = 0;  

        #10 v3 = 1;  // Vote for Candidate 3  
        #10 v3 = 0;  

        #10 v4 = 1;  // Vote for Candidate 4  
        #10 v4 = 0;  

        // Multiple votes for a single candidate  
        #10 v1 = 1;  
        #10 v1 = 0;  
        #10 v1 = 1;  
        #10 v1 = 0;  

        // Wait for vote processing  
        #50;  

        // Display results  
        $display("Vote Counts: Candidate 1 = %d, Candidate 2 = %d, Candidate 3 = %d, Candidate 4 = %d", cd1, cd2, cd3, cd4);  
        $display("Winner: %b", winner);  

        // End simulation  
        #20 $stop;  
    end  
endmodule  
