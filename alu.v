module alu_32bit(
	input[31:0] a,
	input[31:0] b,
	input[3:0] sel,
	output reg[63:0] out
);

wire[63:0] aritmetic;
wire[31:0] logic;

aritmetic_unit_32bit uut( .a(a), .b(b), .sel(sel[2:0]), .out(aritmetic));

logic_unit_32b uut1( .a(a), .b(b), .sel(sel[2:0]), .out(logic));

always @* begin
    case(sel[3])
	1'b0: out = aritmetic;
	1'b1: out = logic;
        default: out = 64'b0;
    endcase
end

endmodule

module alu_32bit_tb;

    reg [31:0] a, b;
    reg [3:0] sel;

    wire [63:0] out;

    alu_32bit uut(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 5310;
        b = 112;
        sel = 4'b0000;
        #100;
        $display("Addition test: a:%d, b:%d, out:%d", a, b, out);

        sel = 4'b0001;
        #100;
        $display("Subsctraction test: a:%d, b:%d, out:%d", a, b, out);

        sel = 4'b0010;
        #100;
        $display("Multiplier test: a:%d, b:%d, out:%d", a, b, out);

        sel = 4'b0011;
        #100;
        $display("Division test: a:%d, b:%d, rest:%d, cat:%d", a, b, out[33:16], out[15:0]);

        sel = 4'b0100;
        #100;
        $display("Modulo test: a:%d, b:%d, out:%d", a, b, out);

	sel = 4'b1000;
        #100;
        $display("AND test: a:%b, b:%b, out:%b", a, b, out);

	sel = 4'b1001;
        #100;
        $display("OR test: a:%b, b:%b, out:%b", a, b, out);

        sel = 4'b1010;
        #100;
        $display("XOR test: a:%b, b:%b, out:%b", a, b, out);

        sel = 4'b1011;
        #100;
        $display("NOT a test: a:%d, out", a, out);

        sel = 4'b1100;
        #100;
        $display("NOT b test: b:%b, out:%b", b, out);

	sel = 4'b1101;
	#100;
	$display("NAND test: a:%b, b:%b, out:%b", a, b, out);

	sel = 4'b1110;
        #100;
        $display("NOR test: a:%b, b:%b, out:%b", a, b, out);

	sel = 4'b1111;
        #100;
        $display("XNOR test: a:%b, b:%b, out:%b", a, b, out);


    end

endmodule