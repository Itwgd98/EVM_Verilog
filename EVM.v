`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2025 00:21:38
// Design Name: 
// Module Name: EVM
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


// Code your design here
module EVM (input clk, input reset,
            input v1, input v2, input v3,input v4,
            output reg[7:0]cd1,cd2,cd3,cd4,
           //output int cd1,cd2,cd3,cd4,
            output [3:0]winner );
  
  reg [3:0] state, next_state ; 
  //int cd1, cd2, cd3 ,cd4 ; 
  parameter S =0, A = 1, B = 2, C =3, D =4, S10= 5;
  
  //data path 
  always @(posedge clk) begin 
    if (reset)begin 
      state <= S;
      cd1 <= 8'b0;
      cd2 <= 8'b0;
      cd3 <= 8'b0;
      cd4 <= 8'b0;
    end
    else begin 
      state <= next_state; 
      case(state)
        A: cd1 <= cd1 + 8'b1 ; 
        B: cd2 <= cd2 + 8'b1 ; 
        C: cd3 <= cd3 + 8'b1 ; 
        D: cd4 <= cd4 + 8'b1 ; 
      endcase 
    end 
  end
  
  //control path
  always @(*) begin 
    case (state) 
      S:next_state = v1?A:(v2?B:(v3?C:(v4?D:S)));
      A:next_state = S10;
      B:next_state = S10;
      C:next_state = S10;
      D:next_state = S10;
      S10:next_state = S;
    //  S11:next_state = S;
    endcase 
  end 
  
  assign winner[0] = (cd1 >= cd2) & (cd1 >= cd3) & (cd1 >= cd4) ;
  assign winner[1] = (cd2 >= cd1) & (cd2 >= cd3) & (cd2 >= cd4) ;
  assign winner[2] = (cd3 >= cd1) & (cd3 >= cd2) & (cd3 >= cd4) ;
  assign winner[3] = (cd4 >= cd1) & (cd4 >= cd2) & (cd4 >= cd3) ;
endmodule
