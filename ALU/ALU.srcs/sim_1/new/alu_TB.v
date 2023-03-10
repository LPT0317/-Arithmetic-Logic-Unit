`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2023 01:33:46 PM
// Design Name: 
// Module Name: alu_TB
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


module alu_TB();
    //Inputs
    reg [7:0] A, B;
    reg [3:0] alu_opcode;
    
    //Outputs
    wire [7:0] alu_out;
    wire [3:0] flag;
    wire Z, C, S, O;
    assign Z = flag[3];
    assign C = flag[2];
    assign S = flag[1];
    assign O = flag[0];
    
    integer i;
    
    alu test_unit(
        .operand1(A),
        .operand2(B),
        .opcode(alu_opcode),
        .alu_out(alu_out),
        .flag(flag)
    );
    
    initial begin
        A = 8'b0000_1010;
        B = 8'b0000_0010;
        
        alu_opcode = 4'b0000;
      
      for (i=0;i<=15;i=i+1) begin
        alu_opcode = alu_opcode + 4'b0001;
        #10;
      end;
    end
endmodule
