module tb_seq_detector;
    logic clk = 0, rst;
    logic bit_in;
    logic seq_detected;

    seq_detector uut (
        .clk(clk), .rst(rst), .bit_in(bit_in), .seq_detected(seq_detected)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1; bit_in = 0;
        #10 rst = 0;
        
        // Test sequence: 1 0 1
        bit_in = 1; #10;
        bit_in = 0; #10;
        bit_in = 1; #10;
        
        // Expected: seq_detected = 1
        $display("Detected: %b", seq_detected);
        $finish;
    end
endmodule
