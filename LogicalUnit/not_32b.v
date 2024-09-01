module not_1b(input a, output out);

  assign out = ~a;

endmodule

module not_32b(input[31:0] a, output[31:0] out);
  genvar i;

  generate
    for(i=1;i<=32;i=i+1)
      not_1b not1 (.a(a[i-1]),.out(out[i-1]));
  endgenerate
endmodule

module not_tb;
  reg[31:0]a;
  wire[31:0]out;

  not_32b not32 (.a(a),.out(out));

  initial begin
    a=32'b11001010100110000001010101000111;
    $monitor("a=%b || out = %b",a,out);
    #100
    a=32'b00110101011001111110101010111000;
    $monitor("a=%b || out = %b",a,out);
  end
endmodule
