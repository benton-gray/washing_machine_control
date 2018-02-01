`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:48:43 02/01/2018
// Design Name:   connect
// Module Name:   Z:/Desktop/fpga/homework/washing-machine/connect_tb.v
// Project Name:  washing-machine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: connect
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module connect_tb;

	// Inputs
	reg door;
	reg start;
	reg [1:0] load;
	reg clk;

	// Outputs
	wire agitator;
	wire motor;
	wire pump;
	wire speed;
	wire water;

	// Instantiate the Unit Under Test (UUT)
	connect uut (
		.door(door), 
		.start(start), 
		.load(load), 
		.clk(clk), 
		.agitator(agitator), 
		.motor(motor), 
		.pump(pump), 
		.speed(speed), 
		.water(water)
	);

	initial begin
		// Initialize Inputs
		door = 0;
		start = 0;
		load = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10
		load = 1;
		start = 1;
		
	end
	
  always #5 clk = !clk;
      
endmodule

