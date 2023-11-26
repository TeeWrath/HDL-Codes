// Module 4-bit adder-subtractor


`timescale 1ns / 1ps


module full_adder (

    input wire a,

    input wire b,

    input wire cin,

    output wire sum,

    output wire cout

);

    assign sum = a ^ b ^ cin;

    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule


module adder_subtractor_4bit (

    input wire [3:0] a,

    input wire [3:0] b,

    input wire subtract,

    output wire [3:0] sum

);

    wire [3:0] neg_b;

    wire cin[5:0];

    wire cout;


    assign neg_b = subtract ? (~b + 1) : b;


    assign cin[0] = 0;

    genvar i;

    generate

        for (i = 0; i < 4; i = i + 1) begin : gen_loop

            full_adder fa (

                .a(a[i]),

                .b(neg_b[i]),

                .cin(cin[i]),

                .sum(sum[i]),

                .cout(cout)

            );

            assign cin[i+1] = cout;

        end

    endgenerate


endmodule


//TESTBENCH


`timescale 1ns / 1ps


module tb;

    reg [3:0] a;

    reg [3:0] b;

    reg subtract;

    wire [3:0] sum;


    adder_subtractor_4bit DUT (

        .a(a),

        .b(b),

        .subtract(subtract),

        .sum(sum)

    );


    initial begin

        $monitor("a=%b, b=%b, subtract=%b, sum=%b", a, b, subtract, sum);


        // Test 1: Addition

        a = 4'b0101;

        b = 4'b0010;

        subtract = 0;

        #10;


        // Test 2: Subtraction

        a = 4'b0011;

        b = 4'b0010;

        subtract = 1;

        #10;


        $finish;

    end

endmodule
