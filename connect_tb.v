module connect_tb;

	// Inputs
	reg door;
	reg start;
	reg [1:0] load;
	reg clk;
	reg rst;

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
		.rst(rst),
		.agitator(agitator), 
		.motor(motor), 
		.pump(pump), 
		.speed(speed), 
		.water(water)
	);
      
	initial begin
		// Initialize Inputs
		
		start = 0;
		load = 1;
		//clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
        
		// Add stimulus here
		#10
		start = 1;
		
		#5
		start = 0;
		

		#500 $finish;
	end
	initial begin
	clk=0;
  forever #5 clk = !clk;end

	initial begin
	door = 0;
		#280 door = 1;
		#10 door = 0;
	end
endmodule

