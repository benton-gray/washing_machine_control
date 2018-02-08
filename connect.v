module connect(
    input wire door,
					start,
    input wire[1:0] load,
    input wire clk, rst,
	 output wire agitator, motor, pump, speed, water
    );

	wire td, tf, tr, ts, tw, reset;
	
	// Instantiate the module
	washing_machine_control w1 (
    .tdrain(td), 
    .tfill(tf), 
    .trinse(tr), 
    .tspin(ts), 
    .twash(tw), 
    .door(door), 
    .start(start), 
    .agitator(agitator), 
    .motor(motor), 
    .pump(pump), 
    .speed(speed), 
    .water_fill(water), 
    .reset(reset), 
    .clk(clk), 
    .rst(rst)
    );

	// Instantiate the module
	timer t1 (
    .clk(clk), 
    .reset(reset), 
    .td(td), 
    .tf(tf), 
    .tr(tr), 
    .ts(ts), 
    .tw(tw), 
    .load(load)
    );

endmodule
