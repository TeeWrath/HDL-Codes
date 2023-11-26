module half_adder(input a, b, output s0, c0);
  assign s0 = a ^ b;
  assign c0 = a & b;
endmodule

module full_adder(input a, b, cin, output s0, c0);
  assign s0 = a ^ b ^ cin;
  assign c0 = (a & b) | (b & cin) | (a & cin);
endmodule

module arraymultiplier(input [3:0] A, B, output [4:0]g)
  reg unsigned p[3][3];
  wire [3:0] c; // c represents carry of HA/FA
  wire [1:0] s;  // s represents sum of HA/FA
  // For ease and readability, two diffent name s and c are used instead of single wire name.
  genvar i;
 
  generate
    for(i = 0;i<3;i++) begin
      and a0(p[i][0], A[i], B[0]);
      and a1(p[i][1], A[i], B[1]);
      and a2(p[i][2], A[i], B[2]);
    end
  endgenerate
  assign g[0] = p[0][0];

  //row 0
  half_adder h0(p[0][1], p[1][0], g[1], c[0]);
  full_adder f1(p[1][1], p[2][0],c[0], s[0], c[1]);
 
  //row1
  full_adder f0(p[0][2], c[1], s[0], g[2], c[2]);
  full_adder f1(p[1][2],p[2][1], c[2], g[3],c[3]);
  half_adder h0(p[2][1],c[3], g[4], c[4]);
 
 assign g[5] = c[4]
endmodule



------------------------------------------------------------------------------------------------------------------------------------------------------------------
Testbanch code
//module arraymultiplier_tb(

//    );
//endmodule
module TB;
  reg [3:0] A, B;
  wire [7:0] P;
  
  array_multiplier am(A,B,P);
  
  initial begin
    $monitor("A = %b: B = %b --> P = %b, P(dec) = %0d", A, B, P, P);
    A = 1; B = 0; #3;
    A = 7; B = 5; #3;
    A = 8; B = 9; #3;
    A = 4'hf; B = 4'hf;
  end
endmodule
