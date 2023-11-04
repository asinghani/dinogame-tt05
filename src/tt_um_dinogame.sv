`default_nettype none

module tt_um_dinogame (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    logic vR, vG, vB, hs, vs;

    dinogame game (
        .jump_in(ui_in[0]),
        .halt_in(ui_in[1]),
        .debug_in(ui_in[2]),

        .vga_hsync(hs),
        .vga_vsync(vs),
        .vga_red(vR),
        .vga_green(vG),
        .vga_blue(vB),

        .vga_pixel(),

        .cfg_accel(ui_in[3] ? uio_in[7:4] : 4),
        .cfg_speed(ui_in[3] ? uio_in[3:0] : 2),

        .clk(clk),
        .sys_rst(!rst_n)
    );

    assign uio_oe = '0;

    assign uo_out = {hs, vB, vG, vR, vs, vB, vG, vR};

endmodule
