`timescale 1ns/1ns
`include "Clock.v"


module Clock_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in time units

  // Inputs
  reg reset;
  reg clk;
  reg [1:0] H_in1;
  reg [3:0] H_in0;
  reg [2:0] M_in1;
  reg [3:0] M_in0;
  reg LD_time;
  reg LD_alarm;
  reg AL_ON;
  reg stop;

  // Outputs
  wire Alarm;
  wire [1:0] H_out1;
  wire [3:0] H_out0;
  wire [2:0] M_out1;
  wire [3:0] M_out0;
  wire [2:0] S_out1;
  wire [3:0] S_out0;

  // Instantiate the DigitalClock module
  DigitalClock uut (
    .reset(reset),
    .clk(clk),
    .H_in1(H_in1),
    .H_in0(H_in0),
    .M_in1(M_in1),
    .M_in0(M_in0),
    .LD_time(LD_time),
    .LD_alarm(LD_alarm),
    .AL_ON(AL_ON),
    .stop(stop),
    .Alarm(Alarm),
    .H_out1(H_out1),
    .H_out0(H_out0),
    .M_out1(M_out1),
    .M_out0(M_out0),
    .S_out1(S_out1),
    .S_out0(S_out0)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Initial block
  initial begin

    $dumpfile("Clock_tb.vcd");
    $dumpvars(0, Clock_tb);

    // Initialize inputs
    reset = 1;
    clk = 0;
    H_in1 = 2'b00;
    H_in0 = 4'b0000;
    M_in1 = 3'b000;
    M_in0 = 4'b0000;
    LD_time = 0;
    LD_alarm = 0;
    AL_ON = 0;
    stop = 0;
    
   
    #10 reset = 0;

    // Apply test scenario
    
     H_in1 <= 2'b01;
     H_in0 <= 4'b0101;
     M_in1 <= 3'b011;
     M_in0 <= 4'b1001;
      #100 AL_ON = 1;
    //  #10000 LD_time <= 0;
    
     #1000 LD_time =1;
     #1000 LD_time =0;
   #1000 H_in1 <= 2'b01;
     H_in0 <= 4'b0110;
     M_in1 <= 3'b011;
     M_in0 <= 4'b1001;

     #1000 LD_alarm = 1;
     #1000 LD_alarm = 0;
     #1000000 stop = 1;
     #100 stop = 0;
    
      // #1000 LD_time <= 0;
      #5070632 stop=1;
    #5071632 reset=1;
    
    #10000000 $finish;
  end

endmodule
