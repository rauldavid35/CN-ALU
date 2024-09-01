module subtractor_32bit(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] diff
);
wire [31:0] carry;
wire [31:0] alt_a,alt_b;
wire [31:0] alt_sum;

twos_complement TCA(.input_number(a),.twos_complement_output(alt_a));
twos_complement TCB(.input_number(-b),.twos_complement_output(alt_b));

genvar i;

full_adder FA (.a(alt_a[0]), .b(alt_b[0]), .c_in(1'b0), .sum(alt_sum[0]), .c_out(carry[0]));

generate
    for(i=1;i<33;i=i+1)
        full_adder FA1 (.a(alt_a[i]), .b(alt_b[i]), .c_in(carry[i-1]), .sum(alt_sum[i]), .c_out(carry[i]));
endgenerate

always @(*)begin
    diff=~(alt_sum-1);
end

endmodule

module tb_sub_32bit;
reg [31:0]a;
reg [31:0]b;
wire [31:0]diff;

subtractor_32bit uut(.a(a),.b(b),.diff(diff));

initial begin
    a=32'b11111111111111111111111111111111;
    b=32'b11111111111111111111111111111111;
    $monitor("a=%b || b=%b || diff=%b",a,b,diff);
    #100
    a=-1;
    b=-1;
    $monitor("a=%b || b=%b || diff=%b",a,b,diff);
    #100
    a=32'b00000000000000000000000000000001;
    b=32'b00000000000000000000000000000000;
    $monitor("a=%b || b=%b || diff=%b",a,b,diff);
    #100
    a=32'b00000000000000000000000000000000;
    b=32'b00000000000000000000000000000000;
    $monitor("a=%b || b=%b || diff=%b",a,b,diff);
    #100
    a=32'b00000000000000000000000000000000;
    b=32'b00000000000000000000000000000001;
    $monitor("a=%b || b=%b || diff=%b",a,b,diff);
    #100
    a=32'b10101010101010101010101010101010;
    b=32'b01010101010101010101010101010101;
    $monitor("a=%b || b=%b || diff=%b",a,b,diff);
end
endmodule
