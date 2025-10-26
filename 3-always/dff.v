// DFF
module dff (
    input i_clk, i_d,
    output reg o_q, o_qbar
);
    always @(posedge i_clk)
    begin
        o_q <= i_d;
        o_qbar <= !i_d;
    end

endmodule

// testbench
module dff_tb;
    reg r_D_TB, r_CLK_TB;
    wire w_Q_TB, w_QBAR_TB;

    always
        #5 r_CLK_TB = !r_CLK_TB;
    
    dff UUT 
        (
        .i_clk(r_CLK_TB),
        .i_d(r_D_TB),
        .o_q(w_Q_TB),
        .o_qbar(w_QBAR_TB)
        );

    initial 
    begin
        r_CLK_TB <= 1'b0;
        r_D_TB   <= 1'b0;
        #40;
        r_D_TB <= 1'b1;
        #40 $finish;
    end

    initial
    begin
    $dumpfile("dff_tb.vcd");
    $dumpvars(0, dff_tb);
    end


endmodule