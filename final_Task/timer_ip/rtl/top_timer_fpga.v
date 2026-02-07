module top_timer_fpga (
    input        clk,        // onboard clock
    input        rst_n,        // reset button
    output [3:0] led          // LEDs on board
);

    wire timeout;

    final_vsd_timer u_timer (
        .clk     (clk),
        .resetn  (rst_n),

        // Tie-off bus for now
        .sel     (1'b1),
        .we      (1'b0),
        .addr    (32'h0),
        .wdata   (32'h0),
        .rdata   (),
        .timeout (timeout)
    );

    // Observe timer on LED
    assign led[0] = timeout;
    assign led[3:1] = 3'b000;

endmodule

