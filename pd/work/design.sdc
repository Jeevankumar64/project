set sdc_version 2.0
current_design Hybrid_Decryption_Top 
set_unit -capacitance 1000.00fF
set_units -time 1000.00ps
create_clock -name clk -period 10 -waveform {0 5} [get_ports clk]
create_clock -name VCLK -period 10 -waveform {0 5}

set_clock_uncertainty -setup 0.0626 [get_port clk]

set_input_delay -clock VCLK -max 4  [all_inputs]; #40
set_input_delay -clock VCLK -min 2  [all_inputs]; #20
set_output_delay -clock VCLK -max 3 [all_output] ; #30
set_output_delay -clock VCLK -min 1 [all_output]; #10

set_max_fanout 30.00 [current_design]





