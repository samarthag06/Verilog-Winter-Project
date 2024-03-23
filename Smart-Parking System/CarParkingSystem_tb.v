`timescale 1ns/1ns
`include "CarParkingSystem.v"


module CarParkingSystem_tb;

  parameter CLOCK_PERIOD = 10; 
  parameter SIM_TIME = 2000;   


  reg clock;
  reg reset;
  reg front_sensor;
  reg back_sensor;
  reg [1:0] password;
  wire green_LED, red_LED;
  wire [2:0] display_screen;

  CarParkingSystem uut (
    .front_sensor(front_sensor),
    .back_sensor(back_sensor),
    .clock(clock),
    .reset(reset),
    .password(password),
    .green_LED(green_LED),
    .red_LED(red_LED),
    .display_screen(display_screen)
  );

 
  always begin
     #5 clock = ~clock;
  end;

  initial begin

    $dumpfile("CarParkingSystem_tb.vcd");
    $dumpvars(0, CarParkingSystem_tb);

    clock = 0;
    reset = 1;
    front_sensor = 0;
    back_sensor = 0;
    password = 2'b00;

    #10 reset = 0;

    #200 front_sensor = 1; 
    #100 password = 2'b01; 

    #20 password = 2'b00;
    #200 password = 2'b11; 

    #20 back_sensor = 1; 
    front_sensor = 0;
    #10 password= 2'b00;

    #200 front_sensor = 1; back_sensor = 0; 
    #50 password = 2'b01; 
    #50 password = 2'b11;
    #50 password = 2'b00; 
    
    #50 back_sensor = 1; 
//new stop state
    #20 back_sensor =0;
    #100 password = 2'b11;
    //right
    #50 front_sensor= 0; back_sensor =1; 

    #SIM_TIME $finish;
  end

endmodule
