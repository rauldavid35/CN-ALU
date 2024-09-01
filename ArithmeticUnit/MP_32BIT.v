module mp_32bit( //booth radix 4
    input [31:0] a,
    input [31:0] b,
    output [63:0] product
);

reg [32:0] A, Q;
reg [3:0]count;
reg [31:0] M;

integer i;

always @(*) begin
    A = 0;
    count=0;
    Q = {a,1'b0};
    M=b;
    for(i=1;i<=16;i=i+1)
    begin
        case(Q[2:0])
            3'b001: begin
                A=A+{M[31],M};
            end
            3'b010: begin
                A=A+{M[31],M};
            end
            3'b011: begin
                A=A+(M<<1);
            end
            3'b100: begin
                A=A-(M<<1);
            end
            3'b101: begin
                A=A-{M[31],M};
            end
            3'b110: begin
                A=A-{M[31],M};
            end
        endcase
        Q={A[1:0],Q[32:2]};
        A={A[32:31],A[32:2]};
	    $display("count=%b || A=%b",count,A);
	    $display("count=%b || Q=%b",count,Q); //am facut count ca sa vezi fiecare pas pe ecran , poti sa stergi display de aici si si variabila count
        count=count+1;
    end
end

assign product={A[31:0],Q[32:1]};

endmodule

module tb_mp_32bit;
reg [31:0]a,b;
wire [63:0] product;

mp_32bit uut(.a(a),.b(b),.product(product));

initial begin
    a=-115;
    b=-38;
    $monitor("multiplicand=%b || multiplier=%b || product=%b",a,b,product);
end

endmodule
