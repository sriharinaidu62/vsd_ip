`timescale 1ns/1ps

module tb_vsd_timer_ip;

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
    // Instantiate DUT
    // ------------------------------------------------------------
    final_vsd_timer dut (
        .clk     (clk),
        .resetn (resetn),
        .sel     (sel),
        .we      (we),
        .addr    (addr),
        .wdata   (wdata),
        .rdata   (rdata),
        .timeout (timeout)
    );

    // ------------------------------------------------------------
    // Clock generation (100 MHz)
    // ------------------------------------------------------------
    always #5 clk = ~clk;

    // ------------------------------------------------------------
    // Bus write task
    // ------------------------------------------------------------
    task bus_write(input [31:0] waddr, input [31:0] data);
    begin
        @(posedge clk);
        sel   <= 1'b1;
        we    <= 1'b1;
        addr  <= waddr;
        wdata <= data;
        @(posedge clk);
        sel   <= 1'b0;
        we    <= 1'b0;
        addr  <= 32'b0;
        wdata <= 32'b0;
    end
    endtask

    // ------------------------------------------------------------
    // Bus read task
    // ------------------------------------------------------------
    task bus_read(input [31:0] raddr);
    begin
        @(posedge clk);
        sel  <= 1'b1;
        we   <= 1'b0;
        addr <= raddr;
        @(posedge clk);
        $display("TIME=%0t READ addr=0x%0h data=0x%0h",
                  $time, raddr, rdata);
        sel  <= 1'b0;
        addr <= 32'b0;
    end
    endtask

    // ------------------------------------------------------------
    // Test sequence
    // ------------------------------------------------------------
    initial begin
        // Dump waves
        $dumpfile("final_vsd_timer.vcd");
        $dumpvars(0, tb_vsd_timer_ip);

        // Init
        clk    = 0;
        resetn = 0;
        sel    = 0;
        we     = 0;
        addr   = 0;
        wdata  = 0;

        // Reset
        #20;
        resetn = 1;

        // --------------------------------------------------------
        // TEST 1: ONE-SHOT MODE
        // --------------------------------------------------------
        $display("\n--- ONE-SHOT MODE TEST ---");

        bus_write(32'h04, 10);      // LOAD = 10
        bus_write(32'h00, 32'b01);  // CTRL: en=1, mode=0

        repeat (12) begin
            bus_read(32'h08);       // VALUE
            @(posedge clk);
        end

        bus_read(32'h0C);           // STATUS (timeout)

        // --------------------------------------------------------
        // TEST 2: PERIODIC MODE
        // --------------------------------------------------------
        $display("\n--- PERIODIC MODE TEST ---");

        bus_write(32'h04, 5);       // LOAD = 5
        bus_write(32'h00, 32'b11);  // CTRL: en=1, mode=1

        repeat (15) begin
            bus_read(32'h08);       // VALUE
            @(posedge clk);
        end

        $display("\nSimulation completed successfully.");
        #20;
        $finish;
    end

endmodule
