module or_1b(input a, input b, output out);

  assign out = a|b;

endmodule

module or_32b(input[31:0] a,input[31:0] b, output[31:0] out);
  genvar i;

  generate
    for(i=1;i<=32;i=i+1)
      or_1b o1 (.a(a[i-1]),.b(b[i-1]),.out(out[i-1]));
  endgenerate
endmodule

module or_tb;
  reg[31:0]a;
  reg[31:0]b;
  wire[31:0]out;

  or_32b or32 (.a(a),.b(b),.out(out));

  initial begin
    a=32'b11001010100110000001010101000111;
    b=32'b00110101011001111110101010111001;
    $monitor("a=%b || b = %b || out = %b",a,b,out);
    #100
    a=32'b00110101011001111110101010111000;
    b=32'b00110101011001111110101010111001;
    $monitor("a=%b || b = %b || out = %b",a,b,out);
  end
endmodule
