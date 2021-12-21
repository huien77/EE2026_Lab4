`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 08:18:47
// Design Name: 
// Module Name: task_a
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


module task_a(
    input CLOCK,button0,button1,button2,button3,
    input [3:0] sw,
    output [15:0] led,
    output [3:0] an,
    output dp,
    output [6:0] seg
    );
    
    wire clk_2p98,clk_fast,clk_p75,clk_381;
    reg [15:0] led0 = 0;
    reg [15:0] led1 = 16'b1111_1111_1111_1111;
    reg [5:0] count = 0;
    reg [3:0] tasks = 0;
    //reg [2:0] partA = 0;
    
    clock_2p98Hz(CLOCK,clk_2p98);
    clock_fast(CLOCK,clk_fast);
    clock_p75Hz(CLOCK,clk_p75);
    clock_381Hz(CLOCK,clk_381);
    //debounce(CLOCK,button,pulse);
    
    assign led = led0;
    
    always @(posedge clk_2p98)
    begin
        if (button2 == 1 && tasks[0] == 0)
        begin
            count <= count + 1;
        end
        else if (button2 == 0 && tasks[0] == 0)
        begin
            count <= 0;
        end
    end
    
    always @(posedge clk_fast)
    begin
        case(count)
        0:  led0 <= 0;
        1:  led0 <= 1'b1;
        2:  led0 <= 2'b11;
        3:  led0 <= 3'b111;
        4:  led0 <= 4'b1111;
        5:  led0 <= 5'b1_1111;
        6:  led0 <= 6'b11_1111;
        7:  led0 <= 7'b111_1111;
        8:  led0 <= 8'b1111_1111;
        9:  led0 <= 9'b1_1111_1111;
        10: led0 <= 10'b11_1111_1111;
        11: led0 <= 11'b111_1111_1111;
        12: led0 <= 12'b1111_1111_1111;
        13: led0 <= 13'b1_1111_1111_1111;
        14: led0 <= 14'b11_1111_1111_1111;
        15: led0 <= 15'b111_1111_1111_1111;
        16: begin
            led0 <= 16'b1111_1111_1111_1111;
            tasks[0] = 1;  //when all led successfully light up
            end
        default: led0 <= 2'b10;
        endcase
    end
    
    reg [3:0] count1 = 0;
    reg [2:0] count2 = 0;
    reg [2:0] count3 = 0;
    reg [3:0] an0 = 4'b1111;
    reg [6:0] seg0 = 7'b1111111;
    reg [3:0] an1 = 4'b1111;
    reg [6:0] seg1 = 7'b1111111;
    reg [3:0] an2 = 4'b1111;
    reg [6:0] seg2 = 7'b1111111;
    reg [3:0] an3 = 4'b1111;
    reg [6:0] seg3 = 7'b1111111;
    
    always @(posedge clk_p75)
    begin
        if (button2 == 0 && tasks[0] == 1 && count1 < 9)
        begin
            count1 <= count1 + 1;
        end
    end
    
    always @(posedge clk_fast)
    begin
        case(count1)  //to print s,a,f,e one by one
        1:  begin
            an0 <= 4'b0111;
            seg0 <= 7'b0010010;  //s
            end
        2:  begin
            an0 <= 4'b1011;
            seg0 <= 7'b0001000;  //a
            end
        3:  begin
            an0 <= 4'b1101;
            seg0 <= 7'b0001110;  //f
            end
        4:  begin
            an0 <= 4'b1110;
            seg0 <= 7'b0000110;  //e  //when s,a,f,e successfully lights up one by one
            end
        5:  tasks[1] = 1;
        9:  tasks[2] = 1;  //when safe lights up all at once
        default:begin
                an0 <= 4'b1111;
                seg0 <= 4'b1111;
                end
        endcase
    end
    
    always @(posedge clk_381)
    begin
        if (tasks[1] == 1 && tasks[2] == 0)
            count2 <= count2 + 1;
        
        if (tasks[2] == 1 && tasks[3] == 0)
            count3 <= count3 + 1;
    end
    
    always @(posedge clk_fast)
    begin
        case(count2)  //to print safe all at once
        1:  begin
            an1 <= 4'b0111;
            seg1 <= 7'b0010010;  //s
            end
        2:  begin
            an1 <= 4'b1011;
            seg1 <= 7'b0001000;  //a
            end
        3:  begin
            an1 <= 4'b1101;
            seg1 <= 7'b0001110;  //f
            end
        4:  begin
            an1 <= 4'b1110;
            seg1 <= 7'b0000110;  //e
            end
        default:begin
                an1 <= 4'b1111;
                seg1 <= 7'b1111111;
                end
        endcase
    end
        
    always @(posedge clk_fast)
    begin
        case(count3)  //to print 1841
        1:  begin
            an2[3] = sw[3];
            an2[2:0] <= 3'b111;
            seg2 <= 7'b1111001;  //1
            end
        2:  begin
            an2[2] = sw[2];
            an2[1:0] <= 2'b11;
            an2[3] = 1;
            seg2 <= 7'b0000000;  //8
            end
        3:  begin
            an2[1] = sw[1];
            an2[3:2] <= 2'b11;
            an2[0] = 1;
            seg2 <= 7'b0011001;  //4
            end
        4:  begin
            an2[0] = sw[0];
            an2[3:1] <= 3'b111;
            seg2 <= 7'b1111001;  //1
            end
        default:begin
                seg2 <= 7'b1111111;
                end
        endcase
        
        if (sw == 4'b1111)
            tasks[3] <= 1;
    end
    
    wire clk_p33,clk_1p49,clk_25m;
    wire reset;  //if btnu pressed, reset == 1
    wire r1,r2,r3;
    reg [2:0] chances = 7;
    reg [3:0] total = 0;  //total number of people in all room
    reg [1:0] rm1 = 0,rm2 = 0,rm3 = 0;  //total number of people in each room
    reg c1 = 1,c2 = 1,c3 = 1;  //keep track of conecutive enters, 1 = available, 0 = unavailable
    reg [3:0] penalty = 0;  //0 = no penalty, 1 = penalty
    
    
    clock_p33Hz(CLOCK,clk_p33);
    clock_1p49Hz(CLOCK,clk_1p49);
    clock_25MHz(CLOCK,clk_25m);
    debounce d0(CLOCK,button0,reset);  //debounced signal for reset
    debounce d1(CLOCK,button1,r1);  //debounced signal for entering room1
    debounce d2(CLOCK,button2,r2);  //debounced signal for entering room2
    debounce d3(CLOCK,button3,r3);  //debounced signal for entering room3
    
    reg count4 = 0;
    
    always @(posedge clk_p33)
    begin
        if (tasks[3] == 1)
        begin
            if (reset == 1)
                count4 <= 0;
            if (count4 == 0)
                count4 <= count4 + 1;
        end
    end
    
    reg [1:0] count6 = 0;
    
    always @(posedge clk_381)
    begin
        if (tasks[3] == 1)
            count6 <= count6 + 1;
    end
    
    always @(posedge clk_fast)
    begin
        if (tasks[3] == 1)
        begin
            if (reset == 1)  //check of reset pressed
            begin
                chances <= 7;
                total <= 0;
                rm1 <= 0; rm2 <= 0; rm3 <= 0;
                c1 <= 1; c2 <= 1; c3 <= 1;
                penalty <= 0;
            end
            
            if (count4 == 1 && total != 9)
                chances <= chances - 4;
                     
            if (r1 == 1)
            begin
                if ((((rm1 == rm2 - 1) || (rm1 == rm2)) && 
                ((rm1 == rm3 - 1) || (rm1 == rm3))) && c1 == 1 && rm1 < 3)
                begin
                    rm1 <= rm1 + 1;
                    c1 <= 0; c2 <= 1; c3 <= 1;
                    total <= total + 1;
                end
                else
                begin
                    chances <= chances - 1;
                end
            end
            
            if (r2 == 1)
            begin
                if ((((rm2 + 1 == rm1) || (rm2 == rm1)) && 
                ((rm2 + 1 == rm3) || (rm2 == rm3))) && c2 == 1 && rm2 < 3)
                begin
                    rm2 <= rm2 + 1;
                    c2 <= 0; c1 <= 1; c3 <= 1;
                    total <= total + 1;
                end
                else
                begin
                    chances <= chances - 1;
                end
            end
            
            if (r3 == 1)
            begin
                if ((((rm3 + 1 == rm1) || (rm3 == rm1)) && 
                ((rm3 + 1 == rm2) || (rm3 == rm2))) && c3 == 1 && rm3 < 3)
                begin
                    rm3 <= rm3 + 1;
                    c3 <= 0; c1 <= 1; c2 <= 1;
                    total <= total + 1;
                end
                else
                begin
                    chances <= chances - 1;
                end
            end
        end
    end
        
    always @(posedge clk_fast)
    begin
    case(count6)
    0:  begin
        if (chances != 0)
        begin
            //case(rm3)
            if (rm3 == 0)
                begin
                an3 <= 4'b0111;
                seg3 <= 7'b1111111;
                end
            else if (rm3 == 1)
                begin
                an3 <= 4'b0111;
                seg3 <= 7'b1110111;
                end
            else if(rm3 == 2)
                begin
                an3 <= 4'b0111;
                seg3 <= 7'b0110111;
                end
            else if (rm3 == 3)
                begin
                an3 <= 4'b0111;
                seg3 <= 7'b0110110;
                end
            //endcase
        end
        if (chances == 0)
        begin
            an3 <= 4'b0111;
            seg3 <= 7'b0001110;  //F
        end
        end
    1:  begin
        if (chances != 0)
        begin
            //case(rm2)
            if (rm2 == 0)
                begin
                an3 <= 4'b1011;
                seg3 <= 7'b1111111;
                end
            if (rm2 == 1)
                begin
                an3 <= 4'b1011;
                seg3 <= 7'b1110111;
                end
            if (rm2 == 2)
                begin
                an3 <= 4'b1011;
                seg3 <= 7'b0110111;
                end
            if (rm2 == 3)
                begin
                an3 <= 4'b1011;
                seg3 <= 7'b0110110;
                end
            //endcase
        end
        if(chances == 0)
        begin
            an3 <= 4'b1011;
            seg3 <= 7'b0001000;  //A
        end
        end
    2:  begin
        if (chances != 0)
        begin
            //case(rm1)
            if (rm1 == 0)
                begin
                an3 <= 4'b1101;
                seg3 <= 7'b1111111;
                end
            if (rm1 == 1)
                begin
                an3 <= 4'b1101;
                seg3 <= 7'b1110111;
                end
            if (rm1 == 2)
                begin
                an3 <= 4'b1101;
                seg3 <= 7'b0110111;
                end
            if (rm1 == 3)
                begin
                an3 <= 4'b1101;
                seg3 <= 7'b0110110;
                end
            //endcase
        end
        if (chances == 0)
        begin
            an3 <= 4'b1101;
            seg3 <= 7'b1001111;  //I
        end
        end
    3:  begin
        if (chances != 0)
        begin
            //case(chances)
            if (chances == 1)
                begin
                an3 <= 4'b1110; 
                seg3 <= 7'b1111001;
                end
            if (chances == 2)
                begin
                an3 <= 4'b1110; 
                seg3 <= 7'b0100100;
                end
            if (chances == 3)
                begin
                an3 <= 4'b1110; 
                seg3 <= 7'b0110000;
                end
            if (chances == 4)
                begin
                an3 <= 4'b1110; 
                seg3 <= 7'b0011001;
                end
            if (chances == 5)
                begin
                an3 <= 4'b1110; 
                seg3 <= 7'b0010010;
                end
            if (chances == 6)
                begin
                an3 <= 4'b1110; 
                seg3 <= 7'b0000010;
                end
            if (chances == 7)
                begin
                an3 <= 4'b1110; 
                seg3 <= 7'b1111000;
                end
            //endcase
        end
        if (chances == 0)
        begin
            an3 <= 4'b1110; 
            seg3 <= 7'b1000111;  //L
        end
        end
    endcase
    end
    
    assign an = (tasks[1] == 0) ? an0 : 
    (tasks[2] == 0) ? an1 : (tasks[3] == 0) ? an2 : an3;
    assign seg = (tasks[1] == 0) ? seg0 : 
    (tasks[2] == 0) ? seg1: (tasks[3] == 0) ? seg2 : seg3;
    assign dp = 1;
    
endmodule
