module aritmetic_unit_32bit(
	input[31:0] a,
	input[31:0] b,
	input[2:0] sel,
	output reg[63:0] out
);

wire[31:0] sum;
wire[31:0] diff;
wire[63:0] mult;
wire[16:0] rest;
wire[15:0] cat;

adder_32bit uut( .a(a), .b(b), .sum(sum));

subtractor_32bit uut1( .a(a), .b(b), .diff(diff));

mp_32bit uut2( .a(a), .b(b), .product(mult));

div_32bit uut3( .a(a), .b(b), .rest(rest), .cat(cat));

always @* begin
    case(sel)
        3'b000: out = {32'b0, sum};
        3'b001: out = {32'b0, diff};
        3'b010: out = mult;
        3'b011: out = {rest, cat};
	3'b100: out = {47'b0, rest};
        default: out = 64'b0;
    endcase
end

endmodule

module aritmetic_unit_32bit_tb;

    reg [31:0] a, b;
    reg [2:0] sel;

    wire [63:0] out;

    aritmetic_unit_32bit uut(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 5310;
        b = 112;
        sel = 3'b000;
        #100;
        $display("Addition test: a:%d, b:%d, out:%d", a, b, out);

        sel = 3'b001;
        #100;
        $display("Subsctraction test: a:%d, b:%d, out:%d", a, b, out);

        sel = 3'b010;
        #100;
        $display("Multiplier test: a:%d, b:%d, out:%d", a, b, out);

        sel = 3'b011;
        #100;
        $display("Division test: a:%d, b:%d, rest:%d, cat:%d", a, b, out[33:16], out[15:0]);

        sel = 3'b100;
        #100;
        $display("Modulo test: a:%d, b:%d, out:%d", a, b, out);
    end

endmodule
