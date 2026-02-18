
// ============================================================
// Minimal SoC Timer IP - Fully Spec Compliant
// Supports:
// - One-shot mode
// - Periodic mode
// - Prescaler
// - Sticky timeout flag
// - Write-1-to-clear status
// - Memory mapped registers
// ============================================================

module final_vsd_timer (
    input  wire        clk,
    input  wire        resetn,

    // Memory mapped interface
    input  wire        sel,
    input  wire        we,
    input  wire [3:0]  addr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata,

    // Interrupt / timeout output
    output wire        timeout_irq
);

// ============================================================
// Register offsets
// ============================================================

localparam CTRL   = 4'h0;
localparam LOAD   = 4'h4;
localparam VALUE  = 4'h8;
localparam STATUS = 4'hC;


// ============================================================
// Registers
// ============================================================

reg [31:0] ctrl_reg;
reg [31:0] load_reg;
reg [31:0] value_reg;
reg        timeout_flag;


// ============================================================
// CTRL field extraction
// ============================================================

wire en        = ctrl_reg[0];
wire mode      = ctrl_reg[1];
wire presc_en  = ctrl_reg[2];
wire [7:0] presc_div = ctrl_reg[15:8];


// ============================================================
// Prescaler logic
// ============================================================

reg [7:0] presc_cnt;

wire presc_tick = presc_en ?
                  (presc_cnt == presc_div) :
                  1'b1;


// ============================================================
// Detect rising edge of enable
// ============================================================

reg en_d;

wire en_rise = en & ~en_d;


// ============================================================
// Timeout IRQ output
// ============================================================

assign timeout_irq = timeout_flag;


// ============================================================
// WRITE LOGIC
// ============================================================

always @(posedge clk or negedge resetn)
begin

    if(!resetn)
    begin

        ctrl_reg <= 0;
        load_reg <= 0;
        timeout_flag <= 0;

    end

    else if(sel && we)
    begin

        case(addr)

        CTRL:
            ctrl_reg <= wdata;

        LOAD:
            load_reg <= wdata;

        STATUS:
        begin

            // write 1 to clear
            if(wdata[0])
                timeout_flag <= 0;

        end

        endcase

    end

end


// ============================================================
// PRESCALER COUNTER
// ============================================================

always @(posedge clk or negedge resetn)
begin

    if(!resetn)
        presc_cnt <= 0;

    else if(en && presc_en)
    begin

        if(presc_cnt == presc_div)
            presc_cnt <= 0;
        else
            presc_cnt <= presc_cnt + 1;

    end

    else
        presc_cnt <= 0;

end



// ============================================================
// MAIN TIMER LOGIC
// ============================================================

always @(posedge clk or negedge resetn)
begin

    if(!resetn)
    begin

        value_reg <= 0;
        en_d <= 0;

    end

    else
    begin

        en_d <= en;

        // load on enable rising edge
        if(en_rise)
        begin

            value_reg <= load_reg;

        end

        else if(en && presc_tick)
        begin

            if(value_reg > 0)
            begin

                value_reg <= value_reg - 1;

                if(value_reg == 1)
                begin

                    timeout_flag <= 1;

                end

            end

            else
            begin

                // timeout reached

                if(mode)
                begin

                    // periodic reload

                    value_reg <= load_reg;

                end

                else
                begin

                    // one-shot halt

                    value_reg <= 0;

                end

            end

        end

    end

end



// ============================================================
// READ LOGIC
// ============================================================

always @(*)
begin

    case(addr)

    CTRL:
        rdata = ctrl_reg;

    LOAD:
        rdata = load_reg;

    VALUE:
        rdata = value_reg;

    STATUS:
        rdata = {31'd0, timeout_flag};

    default:
        rdata = 32'd0;

    endcase

end


endmodule
