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
	  		tspin, twash, door, start;
  reg   agitator, motor, pump,
	  		speed, water_fill, reset;

  //State Register
  reg [TWO : 0] current_state, next_state;
	initial current_state = 3'b000;
	initial next_state = 3'b000;

	//Door can only open on spin cycle and when spin is done
	assign door = (current_state == spin && tspin == HIGH) ? HIGH : LOW;

  always @(   posedge tdrain or posedge tfill
					 or posedge trinse or posedge tspin
					 or posedge twash  or posedge start ) begin

		case (current_state)
			idle: begin
				if(start == HIGH)
					current_state <= next_state;
					reset <= LOW;
			end
			fill_1: begin
				if(tfill == HIGH)
					current_state <= next_state;
					reset <= LOW;
			end
			wash_1: begin
				if(twash == HIGH)
					current_state <= next_state;
					reset <= LOW;
			end
			drain_1: begin
				if(tdrain == HIGH)
					current_state <= next_state;
					reset <= LOW;
			end
			fill_2: begin
				if(tfill == HIGH)
					current_state <= next_state;
					reset <= LOW;
			end
			wash_2: begin
				if(twash == HIGH)
					current_state <= next_state;
					reset <= LOW;
			end
			drain_2: begin
				if(tdrain == HIGH)
					current_state <= next_state;
					reset <= LOW;
			end
			spin: begin
				if(tspin == HIGH && door == LOW)
					current_state <= next_state;
					reset <= LOW;
			end
			default:
				current_state <= idle;
		endcase

  end

	always @(current_state or door) begin
		if(current_state == spin) begin
			if(!door)
				motor = LOW;
				next_state = idle;
		end
		else
			next_state = next_state + 1;
			reset = HIGH;

		case (current_state)
			idle: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
	  		speed 	 	 = LOW;
				water_fill = LOW;
				reset 	 	 = LOW;
			end
			fill_1: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
	  		speed 	 	 = LOW;
				water_fill = HIGH;
			end
			wash_1: begin
				agitator 	 = HIGH;
				motor 	 	 = HIGH;
				pump 		 	 = LOW;
	  		speed 	 	 = LOW;
				water_fill = LOW;
			end
			drain_1: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = HIGH;
	  		speed 	 	 = LOW;
				water_fill = LOW;
			end
			fill_2: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
	  		speed 	 	 = LOW;
				water_fill = HIGH;
			end
			wash_2: begin
				agitator 	 = HIGH;
				motor 	 	 = HIGH;
				pump 		 	 = LOW;
	  		speed 	 	 = LOW;
				water_fill = LOW;
			end
			drain_2: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = HIGH;
	  		speed 	 	 = LOW;
				water_fill = LOW;
			end
			spin: begin
				agitator 	 = LOW;
				motor 	 	 = HIGH;
				pump 		 	 = LOW;
	  		speed 	 	 = HIGH;
				water_fill = LOW;
			end
			default: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
	  		speed 	 	 = LOW;
				water_fill = LOW;
				reset 	 	 = LOW;
			end
		endcase
	end

endmodule