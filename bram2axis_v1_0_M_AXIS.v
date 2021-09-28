
`timescale 1 ns / 1 ps

	module bram2axis_v1_0_M_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
		parameter integer C_M_START_COUNT	= 32
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// Global ports
		input wire  M_AXIS_ACLK,
		// 
		input wire  M_AXIS_ARESETN,
		// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		output wire  M_AXIS_TVALID,
		// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
		// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
		// TLAST indicates the boundary of a packet.
		output wire  M_AXIS_TLAST,
		// TREADY indicates that the slave can accept a transfer in the current cycle.
		input wire  M_AXIS_TREADY
	);
	// -256   362   768   362  -255  -362  -256  -362
	reg signed [15:0] sample0 =  -16'd256;
    reg signed [15:0] sample1 =   16'd362;
    reg signed [15:0] sample2 =   16'd768;
    reg signed [15:0] sample3 =   16'd362;
    reg signed [15:0] sample4 =  -16'd255;
    reg signed [15:0] sample5 =  -16'd362;   
	reg signed [15:0] sample6 =  -16'd256;
    reg signed [15:0] sample7 =  -16'd362;
    
    parameter TOTAL_COUNTS = 10;
    
    parameter RST = 0,
              S0 = 1,
              S1 = 2,
              S2 = 3,
              S3 = 4,
              S4 = 5,
              S5 = 6,
              S6 = 7,
              S7 = 8,
              HALT = 9;
              
    reg [3:0] state = RST;
    reg [5:0] counter = 0;
    always @(posedge M_AXIS_ACLK) 
        if(M_AXIS_ARESETN) begin
            state <= RST;
            counter <= 0;        
        end
        else
            case(state)
            RST: begin
                    if(counter < TOTAL_COUNTS) begin
                        counter <= counter +1;
                        state <= RST;
                    end
                    else begin
                        counter <= 0;
                        state <= S0;
                    end
                 end
            S0: begin
                    if(M_AXIS_TREADY) begin
                        state <= S1;
                    end
                    else begin
                        state <= S0;
                    end
                end
            S1: begin
                    if(M_AXIS_TREADY) begin
                        state <= S2;
                    end
                    else begin
                        state <= S1;
                    end
                end
            S2: begin
                    if(M_AXIS_TREADY) begin
                        state <= S3;
                    end
                    else begin
                        state <= S2;
                    end
                end
            S3: begin
                    if(M_AXIS_TREADY) begin
                        state <= S4;
                    end
                    else begin
                        state <= S3;
                    end
                end
            S4: begin
                    if(M_AXIS_TREADY) begin
                        state <= S5;
                    end
                    else begin
                        state <= S4;
                    end
                end
            S5: begin
                    if(M_AXIS_TREADY) begin
                        state <= S6;
                    end
                    else begin
                        state <= S5;
                    end
                end
            S6: begin
                    if(M_AXIS_TREADY) begin
                        state <= S7;
                    end
                    else begin
                        state <= S6;
                    end
                end
            S7: begin
                    if(M_AXIS_TREADY) begin
                        state <= HALT;
                    end
                    else begin
                        state <= S7;
                    end
                end
            HALT: begin
                        state <= HALT;
                  end
            default: begin
                  state <= RST;
            end
            endcase
            
    // TDATA Circuit
    reg [15 : 0] DATA;
    always @(state) 
        case(state)
        RST:  DATA <= 0; 
        S0:   DATA <= sample0; 
        S1:   DATA <= sample1; 
        S2:   DATA <= sample2; 
        S3:   DATA <= sample3;
        S4:   DATA <= sample4; 
        S5:   DATA <= sample5; 
        S6:   DATA <= sample6; 
        S7:   DATA <= sample7; 
        HALT: DATA <= 0;
        default: DATA <= 0; 
        endcase 
     assign M_AXIS_TDATA = {16'd0,DATA};
	
	// TVALID Circuit
	assign M_AXIS_TVALID = (state == RST || state == HALT ) ? 0 : 1;

    // M_AXIS_TLAST Circuit
    assign M_AXIS_TLAST = (state == S7 ) ? 1 : 0;

	endmodule
