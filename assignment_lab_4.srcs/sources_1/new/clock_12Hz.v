`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 08:38:02
// Design Name: 
// Module Name: clock_12Hz
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


module clock_12Hz(
    input clock,
    output reg f
    );
    
    reg [21:0] count = 0;
    
    always @(posedge clock)
    begin
        count <= count + 1;
        f <= (count == 0) ? ~f : f;
    end
    
endmodule
