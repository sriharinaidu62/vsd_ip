`timescale 1ns/1ps

module tb_timer_ip;


// ============================================================
// Signals
// ============================================================

reg clk;
reg resetn;

reg sel;
reg we;
reg [3:0] addr;
reg [31:0] wdata;

wire [31:0] rdata;
wire timeout_irq;


// ============================================================
// Instantiate DUT
// ============================================================

timer_ip dut (

    .clk(clk),
    .resetn(resetn),

    .sel(sel),
    .we(we),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata),

    .timeout_irq(timeout_irq)

);


// ============================================================
// Clock generation
// ============================================================

always #5 clk = ~clk;


// ============================================================
// Write Task
// ============================================================

task write_reg;

input [3:0] address;
input [31:0] data;

begin

    @(posedge clk);

    sel   = 1;
    we    = 1;
    addr  = address;
    wdata = data;

    @(posedge clk);

    sel = 0;
    we  = 0;

end

endtask



// ============================================================
// Read Task
// ============================================================

task read_reg;

input [3:0] address;

begin

    @(posedge clk);

    sel  = 1;
    we   = 0;
    addr = address;

    @(posedge clk);

    sel = 0;

end

endtask




// ============================================================
// Test Sequence
// ============================================================

initial begin


    // dumpfile for waveform

    $dumpfile("timer_ip.vcd");

    $dumpvars(0, tb_timer_ip);



    // initialize

    clk = 0;
    resetn = 0;

    sel = 0;
    we = 0;
    addr = 0;
    wdata = 0;


    // reset

    #20;

    resetn = 1;



// ============================================================
// TEST 1 : One-shot mode
// ============================================================

    $display("TEST 1 : One-shot mode");


    write_reg(4'h4, 10);   // LOAD


    // CTRL
    // EN=1 MODE=0 PRESC=0

    write_reg(4'h0, 32'h1);


    wait(timeout_irq == 1);


    $display("Timeout occurred (One-shot)");



    read_reg(4'hC);



    // clear timeout

    write_reg(4'hC, 32'h1);



    read_reg(4'hC);



// ============================================================
// TEST 2 : Periodic mode
// ============================================================

    $display("TEST 2 : Periodic mode");


    write_reg(4'h4, 5);



    write_reg(4'h0, 32'h3);


    repeat(3)
    begin

        wait(timeout_irq == 1);

        $display("Periodic Timeout");

        write_reg(4'hC, 32'h1);

    end




// ============================================================
// TEST 3 : Prescaler mode
// ============================================================


    $display("TEST 3 : Prescaler mode");


    write_reg(4'h4, 5);


    // prescale divide by 4

    write_reg(4'h0, 32'h00000405);


    wait(timeout_irq == 1);


    $display("Prescaler Timeout");




#100;

$display("Simulation Finished");


$finish;


end


endmodule
