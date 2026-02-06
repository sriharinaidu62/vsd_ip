`timescale 1ns/1ps

module tb_timer_ip;

    // ------------------------------------------------------------
    // DUT signals
    // ------------------------------------------------------------
    reg         clk;
    reg         resetn;
    reg         sel;
    reg         we;
    reg [31:0]  addr;
    reg [31:0]  wdata;
    wire [31:0] rdata;
    wire        timeout;

    // ------------------------------------------------------------
    // DUT instantiation
    // ------------------------------------------------------------
    timer_ip dut (
        .clk     (clk),
        .resetn  (resetn),
        .sel     (sel),
        .we      (we),
        .addr    (addr),
        .wdata   (wdata),
        .rdata   (rdata),
        .timeout (timeout)
    );

    // ------------------------------------------------------------
    // Clock generation: 100 MHz (10 ns)
    // ------------------------------------------------------------
    always #5 clk = ~clk;

    // ------------------------------------------------------------
    // Bus write task
    // ------------------------------------------------------------
    task bus_write(input [31:0] a, input [31:0] d);
    begin
        @(posedge clk);
        sel   <= 1'b1;
        we    <= 1'b1;
        addr  <= a;
        wdata <= d;
        @(posedge clk);
        sel   <= 1'b0;
        we    <= 1'b0;
        addr  <= 32'd0;
        wdata <= 32'd0;
    end
    endtask

    // ------------------------------------------------------------
    // Bus read task
    // ------------------------------------------------------------
    task bus_read(input [31:0] a);
    begin
        @(posedge clk);
        sel  <= 1'b1;
        we   <= 1'b0;
        addr <= a;
        @(posedge clk);
        $display("[%0t] READ addr=0x%0h data=0x%0h",
                  $time, a, rdata);
        sel  <= 1'b0;
        addr <= 32'd0;
    end
    endtask

    // ------------------------------------------------------------
    // Timeout monitor
    // ------------------------------------------------------------
    always @(posedge clk) begin
        if (timeout)
            $display("[%0t] >>> TIMEOUT ASSERTED <<<", $time);
    end

    // ------------------------------------------------------------
    // VCD DUMP
    // ------------------------------------------------------------
    initial begin
        $dumpfile("timer_ip.vcd");      // waveform file
        $dumpvars(0, tb_timer_ip);      // dump everything
    end

    // ------------------------------------------------------------
    // Test sequence
    // ------------------------------------------------------------
    initial begin
        // Init
        clk    = 0;
        resetn = 0;
        sel    = 0;
        we     = 0;
        addr   = 0;
        wdata  = 0;

        $display("==== TIMER IP TESTBENCH START ====");

        // Apply reset
        #20;
        resetn = 1;
        $display("[%0t] Reset deasserted", $time);

        // --------------------------------------------------------
        // ONE-SHOT MODE TEST
        // --------------------------------------------------------
        $display("\n--- ONE-SHOT MODE TEST ---");

        bus_write(32'h04, 32'd10);     // LOAD = 10
        bus_write(32'h00, 32'b01);     // CTRL: en=1, mode=0

        repeat (15) begin
            @(posedge clk);
            bus_read(32'h08);          // VALUE
        end

        // --------------------------------------------------------
        // PERIODIC MODE TEST
        // --------------------------------------------------------
        $display("\n--- PERIODIC MODE TEST ---");

        bus_write(32'h04, 32'd5);      // LOAD = 5
        bus_write(32'h00, 32'b11);     // CTRL: en=1, mode=1

        repeat (20) begin
            @(posedge clk);
            bus_read(32'h08);
        end

        // --------------------------------------------------------
        // Disable timer
        // --------------------------------------------------------
        $display("\n--- DISABLE TIMER ---");
        bus_write(32'h00, 32'b00);     // en=0

        repeat (5) @(posedge clk);

        $display("\n==== SIMULATION END ====");
        $finish;
    end

endmodule
