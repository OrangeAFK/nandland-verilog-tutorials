`timescale 1ns/1ns

module tb_and_gate;
    reg a; reg b; wire y;
    example_and_gate uut (.i1(a), .i2(b), .and_result(y));

    initial begin
        // Test all input combinations
        $display("a b | y");
        a = 0; b = 0; #10 $display("%b %b | %b", a, b, y);
        a = 0; b = 1; #10 $display("%b %b | %b", a, b, y);
        a = 1; b = 0; #10 $display("%b %b | %b", a, b, y);
        a = 1; b = 1; #10 $display("%b %b | %b", a, b, y);
        $finish;
    end

endmodule