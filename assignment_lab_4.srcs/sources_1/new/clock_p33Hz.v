`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2021 16:08:07
// Design Name: 
// Module Name: clock_p33Hz
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


module clock_p33Hz(
    input clock,
    output reg f
    );
    
    reg [26:0] count = 0;
    
    always @(posedge clock)
    begin
        count <= count + 1;
        f <= (count == 0) ? ~f : f;
    end
    
endmodule
