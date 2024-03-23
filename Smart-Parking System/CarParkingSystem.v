module CarParkingSystem(
  input front_sensor,
  input back_sensor,
  input clock,
  input reset,
  input [1:0] password,
  output reg green_LED,
  output reg red_LED,
  output reg[2:0] display_screen
);

parameter IDLE_STATE = 3'b000;
parameter WAIT_FOR_PASSWORD_STATE = 3'b001;
parameter RIGHT_PASS_STATE = 3'b010;
parameter WRONG_PASS_STATE = 3'b011;
parameter NEW_STOP_STATE = 3'b100;


reg[2:0] state, next_state;


always @(posedge clock or posedge reset) begin
  if (reset) begin
    state <= IDLE_STATE;
  end else begin
    state <= next_state;
  end
end

always @(*) begin
  case(state)
    IDLE_STATE:
      if (front_sensor) begin
        next_state = WAIT_FOR_PASSWORD_STATE;
      end else begin
        next_state = IDLE_STATE;
      end

    WAIT_FOR_PASSWORD_STATE:
      if (password == 2'b11) begin
        next_state = RIGHT_PASS_STATE;
      end else if (password == 2'b01 || password == 2'b10) begin
        next_state = WRONG_PASS_STATE;
      end else begin
        next_state = WAIT_FOR_PASSWORD_STATE;
      end

    RIGHT_PASS_STATE:
      if (back_sensor==1 && front_sensor==0) begin
        next_state = IDLE_STATE;
      end else if (front_sensor==1 && back_sensor==1) begin
        next_state = NEW_STOP_STATE;
      end else begin
        next_state = RIGHT_PASS_STATE;
      end
    WRONG_PASS_STATE:
       if (password == 2'b11) begin
        next_state = RIGHT_PASS_STATE;
      end else if (password == 2'b01 || password == 2'b10) begin
        next_state = WRONG_PASS_STATE;
      end else begin
        next_state = WRONG_PASS_STATE;
      end
    NEW_STOP_STATE:
      if (password == 2'b11) begin
        next_state = RIGHT_PASS_STATE;
      end else if (password == 2'b01 || password == 2'b10) begin
        next_state = WRONG_PASS_STATE;
      end else begin
        next_state = NEW_STOP_STATE;
      end
    default:
      next_state = IDLE_STATE;
  endcase
end


always @(*) begin
 green_LED = (state == RIGHT_PASS_STATE );
 red_LED = (state == WRONG_PASS_STATE);
 display_screen = state;
end
endmodule
