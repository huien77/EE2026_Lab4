`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 10:22:37
// Design Name: 
// Module Name: clock_381Hz
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


module clock_381Hz(
    input clock,
    output reg f
    );
    
    reg [16:0] count;
    
    always @(posedge clock)
    begin
        count <= count + 1;
        f <= (count == 0) ? ~f : f;
    end
    
endmodule
