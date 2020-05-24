`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:08 04/19/2019 
// Design Name: 
// Module Name:    Project_Start 
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
module Project_Start(input clk,input dispclock, input cccc,
    input rst,
    input clr,
    input ent,
    input change,
	output reg [5:0] led,
	output reg [19:0] ssd,
    input [3:0] sw,
	 input [3:0] bd,
	 output[3:0] anodes,
	 output [6:0] cathodes); 




//registers
 reg counter_open; //changes to one if its open 
 reg counter_change; //changes to one if user presses change
 reg [2:0] bdcount;
 reg [3:0] counter;
 reg [15:0] password; 
 reg [15:0] inpassword;
 reg [5:0] current_state;
 reg [5:0] next_state;
 reg flag;
 

// parameters for States, you will need more states obviously
parameter IDLE = 6'b000000; //idle state 
parameter GETFIRSTDIGIT = 6'b000001; // get_first_input_state // this is not a must, one can use counter instead of having another step, design choice
parameter GETSECONDIGIT = 6'b000010; //get_second input state
parameter GETTHIRDIGIT = 6'b000100;
parameter GETFOURTHDIGIT = 6'b001000;
parameter CHFIRSTDIGIT = 6'b011000; 
parameter CHSECONDIGIT = 6'b011100;
parameter CHTHIRDIGIT = 6'b011110;
parameter CHFOURTHDIGIT = 6'b011111;
parameter BACKDOOR = 6'b100000;

parameter OPEN = 6'b000011; //opened

// parameters for output, you will need more obviously
parameter C=5'b01100; // you should decide on what should be the value of C, the answer depends on your binary_to_segment file implementation
parameter L=5'b10001; // same for L and for other guys, each of them 5 bit. IN ssd module you will provide 20 bit input, each 5 bit will be converted into 7 bit SSD in binary to segment file.
parameter O = 5'b00000;
parameter P = 5'b10111;
parameter E = 5'b01110;
parameter n = 5'b11000;
parameter d = 5'b10011;
parameter V = 5'b11010;
parameter I = 5'b11011;
parameter tire=5'b11111; //"-"
parameter blank=5'b11001;
parameter five = 5'b00101;//"S"
parameter three = 5'b00011;//"S"
parameter one = 5'b00001;//"S"



//Sequential part for state transitions
	always @ (posedge clk or posedge rst)
	begin
		// your code goes here
		if(rst==1)
		current_state<= IDLE;
		else
		current_state<= next_state;
		
	end



	// combinational part - next state definitions
	always @ (*)
	begin
		led<=current_state;
		if(current_state == IDLE)
		begin
			//assign password[15:0]=16'b0000000000000000;
			// your code goes here
			if (bdcount == 3'b110) begin
			next_state = BACKDOOR;
			end
			
			else if(ent == 1) begin
				next_state = GETFIRSTDIGIT;
				end
			else 
				next_state = current_state;
		end
		
		else if ( current_state == BACKDOOR)
		if(ssd == 20'b00001110011100111001) begin
		next_state = IDLE;
		end
		else
		next_state = current_state;
		
		
		else if ( current_state == GETFIRSTDIGIT )
			if (bdcount == 3'b110) begin
			next_state = BACKDOOR;
			end
			
			else if (ent == 1) begin
			 	next_state = GETSECONDIGIT;
				end
			 else
			 	next_state = current_state;

		else if  (current_state == GETSECONDIGIT )
			if (bdcount == 3'b110) begin
			next_state = BACKDOOR;
			end
			
			else if (ent == 1) begin
			 	next_state = GETTHIRDIGIT;
				end
			else if(clr == 1) begin
			next_state= GETFIRSTDIGIT;
			end
			 else
			 	next_state = current_state;

		else if	(current_state == GETTHIRDIGIT) begin

			if (bdcount == 3'b110) begin
			next_state = BACKDOOR;
			end
			else if (ent == 1) begin
			 	next_state = GETFOURTHDIGIT;
				end
			else if(clr == 1) begin
			next_state= GETFIRSTDIGIT;
			end
			 else
			 	next_state = current_state;
			end
				
		else if	(current_state == GETFOURTHDIGIT ) begin
			
			if (bdcount == 3'b110 && ent ==1) begin
			next_state = BACKDOOR;
			end

			else if (ent == 1 && password == inpassword && (counter_open == 1'b0||flag==0))
				begin
				next_state = OPEN;
				end
			else if(clr == 1) 
				begin
				next_state= GETFIRSTDIGIT;
				end
			else if (ent == 1 && password != inpassword && (counter_open == 1'b0|| flag==0))
				begin
				next_state = IDLE;
				end 
		  else if (ent == 1 && counter_open==1'b1 && (password == inpassword||flag==1))
			 begin
				next_state = IDLE;
			 end
		  else if (ent == 1 && counter_open==1'b1 && (password != inpassword||flag==1))
			 begin
				next_state = OPEN;
			 end
		  else
			 	next_state = current_state;
		  end
			
		else if  (current_state == CHFIRSTDIGIT )
			 if (ent == 1) begin
			 	next_state = CHSECONDIGIT;
				end
			 else
			 	next_state = current_state;

		else if	(current_state == CHSECONDIGIT )
			 if (ent == 1) begin
			 	next_state = CHTHIRDIGIT;
				end
			else if(clr == 1) begin
			next_state= CHFIRSTDIGIT;
			end
			 else
			 	next_state = current_state;
				
		else if	(current_state == CHTHIRDIGIT )
			 if (ent == 1) begin
			 	next_state = CHFOURTHDIGIT;
				end
			else if(clr == 1) begin
			next_state= CHFIRSTDIGIT;
			end
			 else
			 	next_state = current_state;
				
		else if	(current_state == CHFOURTHDIGIT )
			begin
			 if (ent == 1) begin
			 	next_state = OPEN;
				end
			else if(clr == 1) begin
			next_state= CHFIRSTDIGIT;
			end
			else
			 next_state = current_state;
			end
				
		else if (current_state == OPEN)begin
	
			if (change == 1)
			begin
				next_state = CHFIRSTDIGIT;

			end
			
			else if(ent==1 ) begin
			next_state = GETFIRSTDIGIT;
			end
			
			else
				next_state = current_state;
		end
	end

   initial bdcount <= 3'b000;
	

	 //Sequential part for control registers, this part is responsible from assigning control registers or stored values
	always @ (posedge clk or posedge rst)
	begin
		if(rst)
		begin
			
			counter_change = 0;
			bdcount <= 3'b000;
			inpassword[15:0]<=0; // password which is taken coming from user, 
			password[15:0]<=0;
		end

		else if(current_state == IDLE)
			begin
	
			 if(ent == 1) 
			 begin
				counter_open = 0;		
				if(bd == 4'b1010 ) 
				begin
				bdcount <= bdcount + 1;
				end
				else if(clr == 1)
				begin
					bdcount <= 0;
				end
				else
					bdcount <= bdcount;
				end
			
		
			end
			
			else if (current_state == BACKDOOR)
			begin
				bdcount[2:0] <= 3'b000;
				password[15:0] <= 16'b0000001100010001;
			end
		
			else if(current_state == GETFIRSTDIGIT)
			begin
				if(ent==1) begin
					inpassword[15:12]<=sw[3:0];
					if(bd == 4'b1010 ) begin
					bdcount <= bdcount +  1;
					end
				else if(clr == 1)
				begin
					bdcount <= 0;
				end
				else
				begin
					bdcount <= bdcount;
				end
					// inpassword is the password entered by user, first 4 digin will be equal to current switch values
					end
			
			end
				
			
			else if(current_state == GETSECONDIGIT)
			begin
				if(ent==1) begin
					inpassword[11:8]<=sw[3:0];
					if(bd == 4'b1010 ) begin
					bdcount <= bdcount + 1;
					end
				else if(clr == 1)
				begin
					bdcount <= 0;
				end
				else
				begin
					bdcount <= bdcount;
				end
					// inpassword is the password entered by user, first 4 digin will be equal to current switch values
					end
				
			end
			
			else if(current_state == GETTHIRDIGIT)
			begin
				if(ent==1) begin
					inpassword[7:4]<=sw[3:0];
					if(bd == 4'b1010) begin
					bdcount <= bdcount + 1;
					end
				else if(clr == 1)
				begin
					bdcount <= 0;
				end
				else
				begin
					bdcount <= bdcount;
				end
					// inpassword is the password entered by user, first 4 digin will be equal to current switch values
					end
				
			end
			
			
			else if(current_state == GETFOURTHDIGIT)
			begin
				if(ent==1) begin
					inpassword[3:0]<=sw[3:0];
					if(bd == 4'b1010) 
					begin
						bdcount <= bdcount + 1;
					end
				else if(clr == 1)
				begin
					bdcount <= 0;
				end
				else
				begin
					bdcount <= bdcount;
				end
					// inpassword is the password entered by user, first 4 digin will be equal to current switch values
					end
				
			end
				
			else if(current_state == CHFIRSTDIGIT)
			begin 
				if(ent==1) begin
				
						
					password[15:12]<=sw[3:0];
					// inpassword is the password entered by user, first 4 digin will be equal to current switch values
					end
					if (flag ==0)
				counter_open = 1;
			else
				counter_open = 0;
			end
	
			else if(current_state == CHSECONDIGIT)
			begin 
				if(ent==1) begin
			
						
					password[11:8]<=sw[3:0];
					end
			
			end
				
			else if(current_state == CHTHIRDIGIT)
			begin 
				if(ent==1) begin
				
					
					password[7:4]<=sw[3:0];
					end
			
			end
			
			else if(current_state == CHFOURTHDIGIT)
			begin 
				if(ent==1) begin
				
					password[3:0]<=sw[3:0];
					end
			
			end
			
			else if (current_state == OPEN)
				begin
				if(ent==1) begin
				counter_open = 1;
				bdcount[2:0] <= 3'b000;
			
				end
		
				end
			end
		/*w

		Complete the rest of ASM chart, in this section, you are supposed to set the values for control registers, stored registers(password for instance)
		number of trials, counter values etc... 

		*/

	

	// Sequential part for outputs; this part is responsible from outputs; i.e. SSD and LEDS


reg [28:0] ticker; //to hold a count of 50M
wire click;
initial counter = 0; 
	always @(posedge cccc)
	begin
		if (current_state == BACKDOOR)
		counter = counter + 1;
		else if (current_state == OPEN)
		flag = 1;
		else if (current_state == IDLE)
		flag = 0;
		else
		counter = 0;
	end

	always @(posedge dispclock)
	begin
		if(current_state == IDLE)
		begin
		ssd <= {C, L, five, d};	//CLSd
		
		
		end

		
		else if(current_state == OPEN)//OPEn
		begin
			ssd <= {O, P, E, n};
			
		end
		
		else if(current_state == GETFIRSTDIGIT)
		begin
			ssd[19] <= 0;
			ssd[18:15]<= sw[3:0];
			ssd[14:10]<=blank;
			ssd[9:5]<=blank;
			ssd[4:0]<=blank;
			
		end
		
		else if(current_state == GETSECONDIGIT)
		begin
			ssd[19:15] <= tire;
			ssd[14]<= 0;
			ssd[13:10]<=sw[3:0];
			ssd[9:5]<=blank;
			ssd[4:0]<=blank;
		end
		
		else if(current_state == GETTHIRDIGIT)
		begin
			
			ssd[19:15] <= tire;
			ssd[14:10]<= tire;
			ssd[9]<=0;
			ssd[8:5]<=sw[3:0];
			ssd[4:0]<=blank;
		end
		
		else if(current_state == GETFOURTHDIGIT)
		begin
			
			ssd[19:15] <= tire;
			ssd[14:10]<= tire;
			ssd[9:5]<= tire;
			ssd[4]<=0;
			ssd[3:0]<=sw[3:0];
		end
		

		else if(current_state == BACKDOOR)
		begin
		
		
		case(counter)
		0:
		begin
			ssd[19:15] <= blank;
			ssd[14:10]<= blank;
			ssd[9:5]<= blank;
			ssd[4:0]<=I;
		end
		1:
		begin
			ssd[19:15] <= blank;
			ssd[14:10]<= blank;
			ssd[9:5]<= I;
			ssd[4:0]<=blank;
		end
		2:
		begin
			ssd<=  { blank, I, blank, L};
		end
		3:
		begin
			ssd<= { I, blank, L, O};
		end
		4:
		begin
			ssd<= {blank, L, O, V};
		end
		5:
		begin
			ssd<= {L, O, V, E};
		end
		6:
		begin
			ssd<= {O, V, E, blank};
		end
		7:
		begin
			ssd<= {V, E, blank, E};
		end
		8:
		begin
				ssd<= {E, blank, E, C};
		end
		9:
		begin
			ssd<= {blank, E, C, three};
		end
		10:
		begin
			ssd<= {E, C, three, one};
		end
		11:
		begin
			ssd<= {C, three, one, one};
		end
		12:
		begin
			ssd<= {three, one, one, blank};
		end
		13:
		begin
			ssd<= {one, one, blank, blank};
		end
		14:
		begin
			ssd<= {one, blank, blank, blank};
		end
		endcase
			end
		else if(current_state == CHFIRSTDIGIT)
		begin
			ssd[19] <= 0;
			ssd[18:15]<= sw[3:0];
			ssd[14:10]<=blank;
			ssd[9:5]<=blank;
			ssd[4:0]<=blank;
		end
		
		
		else if(current_state == CHSECONDIGIT)
		begin// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.	
			ssd[19] <= 0;
			ssd[18:15]<= password[15:12];
			ssd[14]<=0;
			ssd[13:10]<=sw[3:0];
			ssd[9:5]<=blank;
			ssd[4:0]<=blank;
		end
		
		
		else if(current_state == CHTHIRDIGIT)
		begin		
				// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.
			ssd[19] <= 0;
			ssd[18:15]<= password[15:12];
			ssd[14]<=0;
			ssd[13:10]<=password[11:8];
			ssd[9]<=0;
			ssd[8:5]<=sw[3:0];
			ssd[4:0]<=blank;	
		end
		

		
		else if( current_state == CHFOURTHDIGIT)
		begin
			// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.	
		   ssd[19] <= 0;
			ssd[18:15]<= password[15:12];
			ssd[14]<=0;
			ssd[13:10]<=password[11:8];
			ssd[9]<=0;
			ssd[8:5]<=password[7:4];
			ssd[4]<=0;
			ssd[3:0]<=sw[3:0];	
		end
		
		/*
		 You need more else if obviouslys
		*/


	end

			seven_segment displayit(dispclock,ssd,anodes,cathodes);

endmodule