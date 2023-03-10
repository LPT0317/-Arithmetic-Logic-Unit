`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2023 07:44:29 AM
// Design Name: 
// Module Name: alu
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


module alu(
    input [7:0] operand1,
    input [7:0] operand2,
    input [3:0] opcode,
    output [7:0] alu_out,
    output [3:0] flag //Z (zero), C (carry), S (sign), O (overflow) bits
    );
    
    reg [7:0] ALU_Result;
    reg O, C;
    wire Z, S;
    
    always @(*) begin
        case(opcode)
            //Arithmetic
            4'b0000:
                {C, ALU_Result} = operand1 + operand2;
            4'b0001:
                {C, ALU_Result} = operand1 - operand2;
            4'b0010:
                {C, ALU_Result} = operand1 + 1;                
            4'b0011:
                {C, ALU_Result} = operand1 -1;
            4'b0100:
                ALU_Result = operand1;
            //Logic
            4'b0101:
                ALU_Result = operand1 & operand2;
            4'b0110:
                ALU_Result = operand1 | operand2;
            4'b0111:
                ALU_Result = operand1 ^ operand2;
            4'b1000:
                ALU_Result = ~(operand1 | operand2);
            4'b1001:
                ALU_Result = ~(operand1 & operand2);
            4'b1010:
                ALU_Result = ~(operand1 ^ operand2);
            4'b1011:
                ALU_Result = ~operand1;
            //Shift
            4'b1100:
                ALU_Result = operand1 << operand2[2:0];
            4'b1101:
                ALU_Result = operand1 >> operand2[2:0];
            4'b1110:
                ALU_Result = (operand1 << operand2[2:0]) | (operand1 >> (3'b111 - operand2[2:0]));
            4'b1111:
                ALU_Result = (operand1 >> operand2[2:0]) | (operand1 << (3'b111 - operand2[2:0]));
            default:
                ALU_Result = 8'b1111_1111;
        endcase
        if(opcode[3:2] == 0)begin
            O = (operand1[7] ^ operand2[7]) ? 0 : (operand1[7] ^ ALU_Result[7]);
        end
        else begin
            C = 1'b0;
            O = 1'b0;
        end
    end
    assign Z = (ALU_Result == 0) ? 1'b1 : 1'b0;
    assign S = ALU_Result[7];
    assign flag = {Z, C, S, O};
    assign alu_out = ALU_Result;
endmodule
