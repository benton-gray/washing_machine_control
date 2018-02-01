`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:39:19 02/01/2018 
// Design Name: 
// Module Name:    connect 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module connect(
    input wire door,
					start,
    input wire[1:0] load,
    input wire clk,
	 output wire agitator, motor, pump, speed, water
    );
	 
	wire td, tf, tr, ts, tw, reset;
	
	washing_machine_control c1 (td,tf,tr,ts,tw,door,start,agitator,motor,pump,speed,water,reset);
	timer t1 (clk,reset,td,tf,tr,ts,tw,load);


endmodule
