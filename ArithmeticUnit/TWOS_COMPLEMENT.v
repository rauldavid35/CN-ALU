module twos_complement (
    input [31:0] input_number,
    output reg [31:0] twos_complement_output
);

wire [31:0] ones_complement_output;

assign ones_complement_output = ~input_number;

always @* begin
    twos_complement_output = ones_complement_output + 1;
end

endmodule

module twos_complement_tb;
reg [31:0] input_number;
wire [31:0] twos_complement_output;

twos_complement uut(.input_number(input_number),.twos_complement_output(twos_complement_output));

initial begin
    input_number=32'b00000000000000000000000000000000;
    $monitor("input=%b || twos_complement=%b",input_number,twos_complement_output);
    #100
    input_number=32'b11111111111111111111111111111111;
    $monitor("input=%b || twos_complement=%b",input_number,twos_complement_output);
end
endmodule