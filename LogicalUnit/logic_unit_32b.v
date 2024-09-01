module logic_unit_32b (
    input [31:0] a,
    input [31:0] b,
    input [2:0] sel,
    output reg [31:0] out
);

wire [31:0] and_out, or_out, xor_out, nota_out, notb_out, nand_out, nor_out, xnor_out;

and_32b and32 (.a(a), .b(b), .out(and_out));
or_32b or32 (.a(a), .b(b), .out(or_out));
xor_32b xor32 (.a(a), .b(b), .out(xor_out));
not_32b nota32 (.a(a), .out(nota_out));
not_32b notb32 (.a(b), .out(notb_out));
nand_32b nand32 (.a(a), .b(b), .out(nand_out));
nor_32b nor32 (.a(a), .b(b), .out(nor_out));
xnor_32b xnor32 (.a(a), .b(b), .out(xnor_out));

always @* begin
    case(sel)
        3'b000: out = and_out;
        3'b001: out = or_out;
        3'b010: out = xor_out;
        3'b011: out = nota_out;
        3'b100: out = notb_out;
        3'b101: out = nand_out;
        3'b110: out = nor_out;
        3'b111: out = xnor_out;
        default: out = 32'b0;
    endcase
end

endmodule

module logic_unit_32b_tb;

    reg [31:0] a, b;
    reg [2:0] sel;
    wire [31:0] out;

    logic_unit_32b dut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin

        a = 32'b11110000111100001111000011110000;
        b = 32'b10101010101010101010101010101010;
        sel = 3'b000;
        #100;
	$display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
        a = 32'b11001100110011001100110011001100;
        b = 32'b00110011001100110011001100110011;
        sel = 3'b001;
        #100;
        $display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
        a = 32'b10101010101010101010101010101010;
        b = 32'b01010101010101010101010101010101;
        sel = 3'b010;
        #100;
        $display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
	a = 32'b11110000111100001111000011110000;
        b = 32'b10101010101010101010101010101010;
        sel = 3'b011;
        #100;
	$display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
        a = 32'b11110000111100001111000011110000;
        b = 32'b10101010101010101010101010101010;
        sel = 3'b100;
        #100;
	$display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
        a = 32'b11001100110011001100110011001100;
        b = 32'b00110011001100110011001100110011;
        sel = 3'b101;
        #100;
	$display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
        a = 32'b11001100110011001100110011001100;
        b = 32'b00110011001100110011001100110011;
        sel = 3'b110;
        #100;
	$display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
        a = 32'b10101010101010101010101010101010;
        b = 32'b01010101010101010101010101010101;
        sel = 3'b111;
        #100;
	$display("a=%b || b=%b || sel=%b || out=%b", a, b, sel, out);
	#100;
    end

endmodule