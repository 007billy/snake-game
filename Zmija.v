`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:05 07/06/2023 
// Design Name: 
// Module Name:    Zmija 
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
module Zmija(
input clk50, reset, up, down, left, right,
output [9:0] yCount,
output [9:0] xCount,
output VGA_hSync,
output VGA_vSync,
output VGA_R,
output VGA_G,
output VGA_B
 );
 
 // Parametri za VGA rezoluciju 640x480
	 parameter H_DISPLAY = 640;

    parameter H_FRONT_PORCH = 27;

    parameter H_SYNC_WIDTH = 96;

    parameter H_BACK_PORCH = 37;

    parameter H_TOTAL = 800;



    



    parameter V_DISPLAY = 485;

    parameter V_FRONT_PORCH = 8;

    parameter V_SYNC_WIDTH = 2;

    parameter V_BACK_PORCH = 26;

    parameter V_TOTAL = 521;


 // Unutarnji registri
	 reg [9:0] hCount, vCount;
	 reg [5:0] k_s;
	 
	 reg [4:0] k_r;

	 reg [9:0] hCount_next, vCount_next;

	 reg hSync, vSync;

	 reg hSync_next, vSync_next;
	 

	 //reg displayArea;

	 reg red_value, blue_value, green_value;


	 
	 reg [5:0] x1 = 4;
	 reg [5:0] x2 = 3;
	 reg [5:0] x3 = 2;
	 reg [5:0] x4 = 1;
	 
	 reg [4:0] y1 = 1;
	 reg [4:0] y2 = 1;
	 reg [4:0] y3 = 1;
	 reg [4:0] y4 = 1;
	 
	 reg [5:0] apple_x1,apple_x2; 
	 reg [4:0] apple_y1,apple_y2; 
	 
	 
	 
	 
	 
	 reg game_over;
	 
	 reg [31:0] timer_1;
	 
	 reg b;
	 
	 reg [1:0] direction;
	 
	 reg [1:0] controll;
	 
	 
	 
	 


 always @(posedge clk50 or posedge reset) 

	 begin

		if(reset) begin

			vCount <= 0;

			hCount <= 0;

			vSync <= 1'b0;

			hSync <= 1'b0;
		end

		else begin

			vCount <= vCount_next;

			hCount <= hCount_next;

			vSync <= vSync_next;
	
			hSync <= hSync_next;

		end

	end
	
	
	reg clk25 = 0;
	always @(posedge clk50)
		clk25 = ~clk25;
		
		
	
	// Horizontalni brojaè



    always @(posedge clk25 or posedge reset) begin

		if(reset)

			hCount_next <= 0;

		else begin

        if (hCount == H_TOTAL - 1) 

            hCount_next <= 0;

       else 

            hCount_next <= hCount + 1;

        end



    end
	 
	 
	 // Vertikalni brojaè



    always @(posedge clk25 or posedge reset) begin

        if(reset)

			vCount_next <= 0;

			else begin

				if (hCount == H_TOTAL - 1) begin

					if(vCount == V_TOTAL - 1)

							vCount_next <= 0;

					else 

							vCount_next <= vCount + 1;

				end

        end



    end
	 
	 
	 initial begin
	 
		x1 = 4;
		x2 = 3;
		x3 = 2;
		x4 = 1;
	 
		y1 = 1;
		y2 = 1;
		y3 = 1;
		y4 = 1;
		apple_x1 =32;
		apple_y1 = 3; 
		apple_x2 =5 ;
		apple_y2 = 25; 
		
		direction = 0;
		controll = 0;
		game_over = 0;
		reset_done = 0;
	
	 
	 
	
	 end
	 
	 
	 
	 
	 /*if (reset)
	 begin
		x1 <= 4;
		x2 <= 3;
		x3 <= 2;
		x4 <= 1;
	 
		y1 <= 1;
		y2 <= 1;
		y3 <= 1;
		y4 <= 1;
		game_over<=0;
		
		
	 
	 end*/
	 
	 
	 
	 always @(posedge clk25 or posedge reset)begin	
		if(reset)
			controll<=0;
		else
		begin
			if(up) begin
				if(direction != 1)
					controll <= 3;
				else
					controll<=controll;
			end
			else if(left)begin
				if(direction != 0)
					controll <= 2;
				else
					controll<=controll;			
			end
			else if(down)begin
				if(direction != 3)
					controll <= 1;
			else
				controll<=controll;
			end
	else if(right)begin
		if(direction !=2)
			controll <= 0;
		else
			controll<=controll;
	end
	else begin
		controll <= controll;
	end
	end
	
end

	 
	 
	 always @(posedge clk25) 
	 begin
		k_s <= hCount [9:4];
		k_r <= vCount [9:4];
		
		if (reset)
		begin
			x1 <= 4;
			x2 <= 3;
			x3 <= 2;
			x4 <= 1;
	 
			y1 <= 1;
			y2 <= 1;
			y3 <= 1;
			y4 <= 1;
			game_over<=0;
			
			apple_x1 <=32;
			apple_y1 <= 3; 
			apple_x2 <=5 ;
			apple_y2 <= 25; 
			direction <=0;
		end
		
		else
		begin
	
		//glavom o zid
		if(x1==0 || x1 == 37 || y1==0 || y1==29 || game_over==1)
		begin
			game_over<=1;
			if(k_s>=0&&k_r>=0)
			begin
				red_value<=0;
				green_value<=0;
			end
		end
		else
		begin
		if(k_r < 30 && hCount [3:0]==0)
		begin// za crnu liniju 
				green_value <= 0;
				red_value<=0;
		end
		else if(k_s < 38 && vCount [3:0]==0) // za crnu liniju 
		begin
				green_value <= 0;
				red_value<=0;
		end
		else if((k_r == y1)&&(k_s==x1))
		begin
				green_value<=1;
				red_value<=0;
		end
					
		else if(k_r == y2 && k_s==x2)
		begin
				green_value<=1;
				red_value<=0;
		end
		else if(k_r == y3 && k_s==x3)
		begin
				green_value<=1;
				red_value<=0;
		end
		else if(k_r == y4 && k_s==x4)
		begin
				green_value<=1;
				red_value<=0;
		end
		else if(k_r== apple_y1 && k_s == apple_x1)
				red_value<=1;
		else if(k_r== apple_y2 && k_s == apple_x2)
				red_value<=1;
		else
		begin
				green_value<=0;
				red_value<=0;
		end
		end
		
		//grlom u jagode
		if(x1 == apple_x1 && y1==apple_y1)
				apple_x1<=45;
		else
				apple_x1<=apple_x1;
		
		if(x1 == apple_x2 && y1==apple_y2)
				apple_x2<=45;
		else
				apple_x2<=apple_x2;
			
		
		case(direction)
			0: begin
				if(b)
				begin
					x1<=x1+1;
					y1<=y1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
				end
			end
			
			1:begin
				if(b)
				begin
						
					x1<=x1;
					y1<=y1+1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
				end
			end
			
			
			
			2:begin
				if(b)
				begin
					x1<=x1-1;
					y1<=y1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
					
				end	
			end
			
			3:begin	
				if(b)
				begin
					x1<=x1;
					y1<=y1-1;
					x2<=x1;
					y2<=y1;
					x3<=x2;
					y3<=y2;
					x4<=x3;
					y4<=y3;
				end
			end
					
			endcase
		
		
		
			if(k_s== 0 && k_r<30)
				red_value <= 1;
			else if(k_s== 37 && k_r<30)
				red_value <= 1;
			else if(k_s<40 && k_r==0)
				red_value <= 1;
			else if(k_s<40 && k_r==29)
				red_value <= 1;

			
			
			
		if(timer_1==10000000)
		begin
			timer_1 <= 0;
			b <= 1;
			direction<=controll;
		end
		else begin
			
			timer_1 <= timer_1+1;
			b <= 0;
		end
			
		
		end
	 end
		
	 
	 
	 
	 
	 



always @(posedge clk25) begin



        hSync_next <= (hCount >= (H_DISPLAY + H_FRONT_PORCH) && hCount <= (H_DISPLAY + H_FRONT_PORCH + H_SYNC_WIDTH - 1));

		  vSync_next <= (vCount >= (V_DISPLAY + V_FRONT_PORCH) && vCount <= (V_DISPLAY + V_FRONT_PORCH + V_SYNC_WIDTH - 1));

    end
	 
	 
	 
	  // Ostali izlazi



    //assign blank_n = displayArea;

    assign xCount = hCount;

    assign yCount = vCount;

	 assign VGA_hSync = ~hSync;

	 assign VGA_vSync = ~vSync;

	 assign VGA_R = red_value;

	 assign VGA_B = blue_value;

	 assign VGA_G = green_value;














 






endmodule
