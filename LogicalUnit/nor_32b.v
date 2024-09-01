module not_1b(input a, output out);

  assign out = ~a;

endmodule

module or_1b(input a, input b, output out);

  assign out = a|b;

endmodule

module nor_32b(input[31:0] a, input[31:0] b, output[31:0] out);
  genvar i;
  wire[31:0] aux;

  generate
    for(i=1;i<=32;i=i+1)
      or_1b o1 (.a(a[i-1]),.b(b[i-1]),.out(aux[i-1]));
  endgenerate

  generate
  for(i=1;i<=32;i=i+1)
    not_1b n1 (.a(aux[i-1]),.out(out[i-1]));
  endgenerate

endmodule

module nor_tb;
  reg[31:0]a;
  reg[31:0]b;
  wire[31:0]out;

  nor_32b nor32 (.a(a),.b(b),.out(out));

  initial begin
    a=32'b11001010100110000001010101000111;
    b=32'b00110101011001111110101010111000;
    $monitor("a=%b || b=%b || out = %b",a,b,out);
    #100
    a=32'b00110101011001111110101010111000;
    b=32'b00110101011001111110101010111000;
    $monitor("a=%b || b=%b || out = %b",a,b,out);
  end
endmodule
