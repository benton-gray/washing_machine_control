module washing_machine_control( tdrain, tfill, trinse,
					  										tspin, twash,
					  										door, start, agitator,
					  										motor, pump, speed,
																water_fill, reset
					  										);
  parameter idle = 0,
						fill_1 = 1,
						wash_1 = 2,
						drain_1 = 3,
						fill_2 = 4,
						wash_2 = 5,
						drain_2 = 6,
						spin = 7,
						hold = 8,
						LOW = 0,
						HIGH = 1,
						TWO = 2;


  //Port Declarations
  input   tdrain, tfill, trinse,
	    		tspin, twash, door, start;
  output  agitator, motor, pump,
	    		speed, water_fill, reset;

  //Nettype
  wire  tdrain, tfill, trinse,
	  		tspin, twash, start;
  reg   agitator, motor, pump,
	  		speed, water_fill, reset;

  //State Register
  reg [TWO : 0] current_state, next_state;
	initial current_state = 3'b000;
	initial next_state = 3'b000;

	//Door can only open on spin cycle and when spin is done
	//wire door = (current_state == spin && tspin == HIGH) ? HIGH : LOW;

  always @( * ) begin
		if(start == HIGH && current_state == idle && door == LOW) 
			next_state = next_state + 1;
			
		if(reset == HIGH && door == LOW)
			next_state = next_state + 1;
			
		if(next_state == 8)
			next_state = idle;
		
		case (current_state)
			idle: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill 	 = LOW;
				reset 	 	 = LOW;
				if(start == HIGH) begin
					current_state = next_state;
					reset = HIGH;
				end
			end
			fill_1: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill 	 = HIGH;
				reset 		 = LOW;
				if(tfill == HIGH) begin
					current_state = next_state;
					reset = HIGH;
				end
			end
			wash_1: begin
				agitator 	 = HIGH;
				motor 	 	 = HIGH;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill   = LOW;
				reset 		 = LOW;
				if(twash == HIGH) begin
					current_state = next_state;
					reset = HIGH;
				end
			end
			drain_1: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = HIGH;
				speed 	 	 = LOW;
				water_fill   = LOW;
				reset 		 = LOW;
				if(tdrain == HIGH) begin
					current_state = next_state;
					reset = HIGH;
				end
			end
			fill_2: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill   = HIGH;
				reset 		 = LOW;
				if(tfill == HIGH) begin
					current_state = next_state;
					reset = HIGH;
				end
			end
			wash_2: begin
				agitator 	 = HIGH;
				motor 	 	 = HIGH;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill   = LOW;
				reset 		 = LOW;
				if(twash == HIGH) begin
					current_state = next_state;
					reset = HIGH;
				end
			end
			drain_2: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = HIGH;
				speed 	 	 = LOW;
				water_fill   = LOW;
				reset 		 = LOW;
				if(tdrain == HIGH) begin
					current_state = next_state;
					reset = HIGH;
				end
			end
			spin: begin
				if(door == HIGH) begin 
					agitator 	 = LOW;
					motor 	 	 = LOW;
					pump 		 	 = LOW;
					speed 	 	 = LOW;
					water_fill   = LOW;
					reset 		 = LOW;
				end 
				else begin
					agitator 	 = LOW;
					motor 	 	 = HIGH;
					pump 		 	 = LOW;
					speed 	 	 = HIGH;
					water_fill   = LOW;
					reset 		 = LOW;
					if(tspin == HIGH && door == LOW) begin
						current_state = next_state;
						reset = HIGH;
					end
				end
			end
			default:
				current_state = idle;
		endcase

  end


endmodule