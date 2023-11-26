module bit_fulladder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    assign sum = a^b^cin;
    assign cout = a^b&cin | a&b;
   
endmodule

module FA_struct(A, B,Cin ,S, C);
input A, B , Cin ;
output S, C ;
and i1(C, A, B ,Cin);
xor i2(S, A, B , Cin);
endmodule

// Test Banch code
module FA_tb();
reg a, b , cin ;
wire sum, cout;
FA_struct inst_l(.A(a),.B(b),.Cin(cin),.S(sum),.C(cout));
initial
begin
a = 0; b= 0;cin = 0;
#10 a = 0; b= 0;cin = 1;
#10 a = 0; b= 1;cin = 0;
#10 a = 0; b= 1;cin = 1;
#10 a = 1; b= 0;cin = 0;
#10 a = 1; b= 0;cin = 1;
#10 a = 1; b= 1;cin = 0;
#10 a = 1; b= 1;cin = 1;
#10
$stop;
end
endmodule
