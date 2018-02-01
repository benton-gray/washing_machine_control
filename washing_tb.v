module washing_tb;

  reg start = 0;
  reg door = 0;
  reg td, tf, tr, ts, tw;
  initial begin
	  $dumpfile("washing.vcd");
	  $dumpvars(0,washing_tb);
    # 10 start = 1;
    repeat (8) begin
      # 10 td = 1;
      # 10 tf = 1;
      td = 0;
      # 10 tr = 1;
      tf = 0;
      # 10 ts = 1;
      tr = 0;
      # 10 tw = 1;
      ts = 0;
      #10 tw = 0;
		# 1 start = 0;
    end
	 
	  # 200 $stop;
  end
  
  initial  begin
		#160 door = 1;
		#10 door = 0;
	end


  wire  agitator, motor, pump, speed, water_fill, reset;

  washing_machine_control w1 (td, tf, tr, ts, tw,
                              door, start, agitator,
                              motor, pump, speed,
                              water_fill, reset);


  initial
	$monitor("At time %t, value = %h (%0d)",
			  $time, agitator, agitator);


endmodule