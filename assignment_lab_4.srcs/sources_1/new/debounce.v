`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 08:47:36
// Design Name: 
// Module Name: debounce
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


module debounce(
    input CLOCK,button,
    output pulse
    );
    wire clk_25m,Q0,Q1;
    
    clock_25MHz(CLOCK,clk_25m);
    
    d_ff d1(clk_25m,button,Q0);
    d_ff d2(clk_25m,Q0,Q1);
        
    and(pulse,Q0,~Q1);
    
endmodule
