module  timer(clk, reset,
                td, tf, tr, ts, tw, load);
  parameter   ONE = 1,
              TWO = 2,
              FOUR = 4,
              EIGHT = 8,
              WIDTH = 8;

  //Port Declarations
  output td, tf, tr, ts, tw;
  input  [ONE : 0] load;
  input  clk, reset;

  //Nettype Definitions
  reg  [WIDTH-1 : 0]  out;
  reg  td, tf, tr, ts, tw;
  wire [ONE  : 0] load;
  wire clk, reset;

  //Non-Blocking Concurrent Logic
  always @(posedge clk or posedge reset) begin
    if (reset)
		out <= 0;
    else begin
		out <= out + 1;
    end
  end

  //Blocking Combinatorial Logic
  always @(*)
    if (reset) begin
      td = 0;
      tf = 0;
      tr = 0;
      ts = 0;
      tw = 0;
    end
    else begin
      case(out)
        ONE: begin
          td = ONE;
        end
        TWO: begin
          tf = ONE;
          if (load == 0)
            tw = ONE;
        end
        FOUR: begin
          tr = ONE;
          if (load == ONE)
            tw = ONE;
        end
        EIGHT: begin
          ts = ONE;
          if (load == TWO)
            tw = ONE;
        end
      endcase
    end

endmodule