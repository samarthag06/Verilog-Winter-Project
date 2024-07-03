module DigitalClock(
  input reset,
  input clk,
  input [1:0] H_in1,
  input [3:0] H_in0,
  input [2:0] M_in1,
  input [3:0] M_in0,
  input LD_time,
  input LD_alarm,
  input AL_ON,
  input stop,
  output reg  Alarm=0,
  output reg [1:0] H_out1,
  output reg [3:0] H_out0,
  output reg [2:0] M_out1,
  output reg [3:0] M_out0,
  output reg [2:0] S_out1,
  output reg [3:0] S_out0
);

  reg clk_1s;
  reg [3:0] tmp_1s;
  reg [5:0] tmp_hr, tmp_min, tmp_sec;
  reg [1:0] c_hr1, a_hr1;
  reg [3:0] c_hr0, a_hr0;
  reg [2:0] c_min1, a_min1;
  reg [3:0] c_min0, a_min0;
  reg [2:0] c_sec1, a_sec1;
  reg [3:0] c_sec0, a_sec0;

always @ (posedge reset or posedge clk) begin
  if(reset) begin
    tmp_1s <= 0;
    clk_1s <= 0;
  end else begin
    tmp_1s = tmp_1s + 1;
    if(tmp_1s <= 5)
      clk_1s = 0;
    else if(tmp_1s >= 10) begin
      clk_1s = 1;
      tmp_1s = 1;
    end else
      clk_1s = 1;
  end
end

always @(posedge clk_1s or posedge reset) begin
  if(reset) begin
    a_hr1 <= 1'b0;
    a_hr0 <= 4'b0;
    a_min1 <= 4'b0;
    a_min0 <= 4'b0;
    a_sec1 <= 3'b0;
    a_sec0 <= 4'b0;

    c_hr1 = H_in1;
    c_hr0 = H_in0;
    c_min0 = M_in0;
    c_min1 = M_in1;
    c_sec0 = 4'b0;
    c_sec1 = 3'b0;

    tmp_hr = H_in1 * 10 + H_in0;
    tmp_min = M_in1 * 10 + M_in0;
    tmp_sec = 0;

  end else begin
    if(LD_alarm) begin
      a_hr1 = H_in1;
      a_hr0 = H_in0;
      a_sec0 = 4'b0;
      a_sec1 = 3'b0;
      a_min0 = M_in0;
      a_min1 = M_in1;
    end
    if(LD_time) begin
      c_hr1 = H_in1;
      c_hr0 = H_in0;
      c_min0 = M_in0;
      c_min1 = M_in1;
      c_sec0 = 4'b0;
      c_sec1 = 3'b0;

      tmp_hr = H_in1 * 10 + H_in0;
      tmp_min = M_in1 * 10 + M_in0;
      tmp_sec = 0;
    end

    tmp_sec = tmp_sec + 1;

    if(tmp_sec >= 60) begin
      tmp_sec = 0;
      tmp_min = tmp_min + 1;
      if(tmp_min >= 60) begin
        tmp_min = 0;
        tmp_hr = tmp_hr + 1;
        if(tmp_hr >= 24) begin
          tmp_hr = 0;
        end
      end
    end

    if((a_hr1 * 10 + a_hr0 == tmp_hr) && (a_min1 * 10 + a_min0 == tmp_min) && (a_sec1 * 10 + a_sec0 == tmp_sec)) begin
      if(AL_ON) begin
        Alarm = 1'b1;
      end 
    end

    if(stop) begin
      Alarm = 1'b0;
    end
  end
end

always @(*) begin
  c_hr1 = tmp_hr / 10;
  c_hr0 = tmp_hr % 10;
  c_min1 = tmp_min / 10;
  c_min0 = tmp_min % 10;
  c_sec1 = tmp_sec / 10;
  c_sec0 = tmp_sec % 10;

  H_out1 = c_hr1;
  H_out0 = c_hr0;
  M_out1 = c_min1;
  M_out0 = c_min0;
  S_out1 = c_sec1;
  S_out0 = c_sec0;
end

endmodule
