module washing_machine_control( tdrain, tfill, trinse,
					  										tspin, twash,
					  										door, start, agitator,
					  										motor, pump, speed,
																water_fill, reset, clk, rst
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
	    		tspin, twash, door, start, clk, rst;
  output  agitator, motor, pump,
	    		speed, water_fill, reset;

  //Nettype
  wire  tdrain, tfill, trinse,
	  		tspin, twash, start, clk, rst;
  reg   agitator, motor, pump,
	  		speed, water_fill, reset;

  //State Register
  reg [3 : 0] current_state, next_state;
	initial current_state = 4'b0000;
	initial next_state = 4'b0000;

	//Door can only open on spin cycle and when spin is done
	always @(posedge clk or posedge rst) begin
		if (rst) 
			current_state <= idle;
		else begin
			current_state <= next_state;
		end
	end

  always @( * ) begin
		reset = LOW;
		case (current_state)
			idle: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill 	 = LOW;
				if(start == HIGH) begin
					next_state = fill_1;
					reset = HIGH;
				end
			end
			fill_1: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill 	 = HIGH;
				if(tfill == HIGH) begin
					next_state = wash_1;
					reset = HIGH;
				end
			end
			wash_1: begin
				agitator 	 = HIGH;
				motor 	 	 = HIGH;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill   = LOW;
				if(twash == HIGH) begin
					next_state = drain_1;
					reset = HIGH;
				end
			end
			drain_1: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = HIGH;
				speed 	 	 = LOW;
				water_fill   = LOW;
				if(tdrain == HIGH) begin
					next_state = fill_2;
					reset = HIGH;
				end
			end
			fill_2: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill   = HIGH;
				if(tfill == HIGH) begin
					next_state = wash_2;
					reset = HIGH;
				end
			end
			wash_2: begin
				agitator 	 = HIGH;
				motor 	 	 = HIGH;
				pump 		 	 = LOW;
				speed 	 	 = LOW;
				water_fill   = LOW;
				if(twash == HIGH) begin
					next_state = drain_2;
					reset = HIGH;
				end
			end
			drain_2: begin
				agitator 	 = LOW;
				motor 	 	 = LOW;
				pump 		 	 = HIGH;
				speed 	 	 = LOW;
				water_fill   = LOW;
				if(tdrain == HIGH) begin
					next_state = spin;
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
					next_state   = hold;
				end 
				else begin
					agitator 	 = LOW;
					motor 	 	 = HIGH;
					pump 		 	 = LOW;
					speed 	 	 = HIGH;
					water_fill   = LOW;
					if(tspin == HIGH && door == LOW) begin
						next_state = idle;
						reset = HIGH;
					end
				end
			end
			hold: begin
					agitator 	 = LOW;
					motor 	 	 = LOW;
					pump 		 	 = LOW;
					speed 	 	 = LOW;
					water_fill   = LOW;
					if(door == LOW) begin
						next_state = spin;
					end
			end
			default:
				next_state = idle;
		endcase

  end


endmodule