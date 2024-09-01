module div_32bit(
	input [31:0]a,
	input [15:0]b,
	output [16:0]rest,
	output [15:0]cat
);
reg [16:0]A;
reg [15:0]Q;
reg [5:0]count;
reg [16:0]M;

integer i;

always@(*)begin
    count = 0;
    A={1'b0,a[31:16]};
    Q=a[15:0];
    M={1'b0,b};
    for(i=0;i<=15;i=i+1)
    begin
        A = {A[15:0],Q[15]};
        Q = {Q[14:0],1'b0};
        case(A[16])
            1'b0: begin
                A=A-M;
            end
            1'b1: begin
                A=A+M;
            end
        endcase
	if(A[16]==1'b0) begin
		Q[0]=1;
	end
	count = count + 1;
    end	
end

assign rest = A;
assign cat = Q;

endmodule

module tb_div_32bit;
reg [31:0]a;
reg [15:0]b;
wire [16:0]rest;
wire [15:0]cat;

div_32bit uut(
	.a(a),
	.b(b),
	.rest(rest),
	.cat(cat)
);

initial begin
    a=6529;
    b=43;
    $monitor("a=%d  b=%d cat=%d  rest =%d ",a,b,cat,rest);
    #100
    a=7982;
    b=84;
    $monitor("a=%d  b=%d cat=%d  rest =%d ",a,b,cat,rest);
end


endmodule
