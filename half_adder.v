`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2023 15:46:29
// Design Name: 
// Module Name: half_adder_1014
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


module half_adder_1014(
    input a,
    input b,
    output sum,
    output cout
    );
    assign sum = a^b;
    assign cout = a&b;
endmodule

module HA_struct(A,B,S,C);
input A,B;
input S,C;
and i1(C,A,B);
xor i2(S,A,B);
endmodule

module HA_tb();
reg a,b;
wire s,c;
HA_struct inst_1(.A(a),.B(b),.S(s),.C(c));
initial
begin
a=0; b=0;
#10 a=0; b=1;
#10 a=1; b=0;
#10 a=1; b=1;
#10
$stop;
end
endmodule
