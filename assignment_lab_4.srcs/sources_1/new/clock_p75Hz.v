`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 09:57:27
// Design Name: 
// Module Name: clock_p75Hz
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


module clock_p75Hz(
    input clock,
    output reg f
    );
    
    reg [25:0] count;
    
    always @(posedge clock)
    begin
        count <= count + 1;
        f <= (count == 0) ? ~f : f;
    end
    
endmodule
