module AHB2LED(
	//AHBLITE INTERFACE
		//Slave Select Signals
			input wire HSEL,
		//Global Signal
			input wire HCLK,
			input wire HRESETn,
		//Address, Control & Write Data
			input wire HREADY,
			input wire [31:0] HADDR,
			input wire [1:0] HTRANS,
			input wire HWRITE,
			input wire [2:0] HSIZE,
			
			input wire [31:0] HWDATA,
		// Transfer Response & Read Data
			output wire HREADYOUT,
			output wire [31:0] HRDATA,
		//LED Output
			output wire [7:0] LED
);

//Address Phase Sampling Registers
  reg rHSEL;
  reg [31:0] rHADDR, rHRDATA;
  reg [1:0] rHTRANS;
  reg rHWRITE;
  reg [2:0] rHSIZE;

  reg [7:0] rLED, rMASK;
  reg [7:0] masktp [4:1];
  integer i;
 
//Address Phase Sampling
  always @(posedge HCLK or negedge HRESETn)
  begin
	 if(!HRESETn)
	 begin
		rHSEL	<= 1'b0;
		rHADDR	<= 32'h0;
		rHTRANS	<= 2'b00;
		rHWRITE	<= 1'b0;
		rHSIZE	<= 3'b000;
		for(i=1; i<=4; i=i+1) masktp[i][7:0] <= 0;
	 end
    else if(HREADY)
    begin
		rHSEL	<= HSEL;
		rHADDR	<= HADDR;
		rHTRANS	<= HTRANS;
		rHWRITE	<= HWRITE;
		rHSIZE	<= HSIZE;
    end
  end

 

//Data Phase data transfer
  always @(posedge HCLK or negedge HRESETn)
  begin
    if(!HRESETn) begin
      	rLED <= 8'h00;
		rMASK <= 8'hff;
	end
    else if(rHSEL & rHWRITE & rHTRANS[1]) begin
		if (rHADDR == 32'h57000000) begin
			// rLED <= HWDATA[7:0];
			rLED <= masktp[4];
		end
		else if (rHADDR == 32'h57000004)
			rMASK <= HWDATA[7:0];
		// rLED <= HWDATA[7:0];
	end
  end
  always @(*) begin
	masktp[1] <= rLED | rMASK;
	masktp[2] <= masktp[1] ^ rMASK;
	masktp[3] <= rMASK & HWDATA[7:0];
	masktp[4] <= masktp[3] | masktp[2];
  end

//Transfer Response
  assign HREADYOUT = 1'b1; //Single cycle Write & Read. Zero Wait state operations

//Read Data  
  // assign HRDATA = {24'h0000_00,rLED};
	always @(*) begin
		if (rHADDR == 32'h57000000 | rHADDR == 32'h0000_0000)
			rHRDATA <= {24'h0000_00,rLED};
		else if (rHADDR == 32'h57000004)
			rHRDATA <= {24'h0000_00,rMASK};
	end
	assign HRDATA = rHRDATA;
  assign LED = rLED;

endmodule

