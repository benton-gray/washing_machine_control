module timer_tb;

  /* Reset Plus Load */
  reg reset = 0;
  reg [2:0] load;
  initial begin
	  $dumpfile("timer.vcd");
	  $dumpvars(0,timer_tb);
	  # 17 reset = 1;
    # 0 load = 0;
	  # 11 reset = 0;
    # 35 load = 1;
    # 34 reset = 1;
    # 35 reset = 0;
    # 100 load = 2;
    # 99 reset = 1;
    # 100 reset = 0;
	  # 150 $stop;
  end


  /* Clock */
  reg clk = 0;
  always #5 clk = !clk;


  wire [7:0] value;
  wire  td, tf, tr, ts, tw;
  timer c1 (clk, reset, td, tf, tr, ts, tw, load);


  initial
	$monitor("At time %t, value = %h (%0d)",
			  $time, value, value);

endmodule