`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 08:42:23 PM
// Design Name: 
// Module Name: main_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_tb(

    );
    
          reg m_axis_aclk_0;
          reg m_axis_aresetn_0;
          wire [47:0]m_axis_data_tdata_0;
          wire m_axis_data_tlast_0;
          reg m_axis_data_tready_0;
          wire m_axis_data_tvalid_0;
          
    main_wrapper uut
       (.m_axis_aclk_0(m_axis_aclk_0),
        .m_axis_aresetn_0(m_axis_aresetn_0),
        .m_axis_data_tdata_0(m_axis_data_tdata_0),
        .m_axis_data_tlast_0(m_axis_data_tlast_0),
        .m_axis_data_tready_0(m_axis_data_tready_0),
        .m_axis_data_tvalid_0(m_axis_data_tvalid_0));
        
    initial begin
        m_axis_aclk_0 = 0;
        forever #5 m_axis_aclk_0 = ~m_axis_aclk_0;
    end
    
    initial begin
        m_axis_aresetn_0 = 1;
        m_axis_data_tready_0 = 1;
        
        #20 m_axis_aresetn_0 = 0;
        
        #10000;
        
        
    end
endmodule
