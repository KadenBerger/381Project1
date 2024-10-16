add wave -noupdate -divider {control_unit}
add wave -noupdate -divider {input}
add wave -noupdate -label opcode -radix binary /tb_control_unit/s_opcode
add wave -noupdate -label funct -radix binary /tb_control_unit/s_funct

add wave -noupdate -divider {output}
add wave -noupdate -label o_Ctrl_Unt /tb_control_unit/s_Ctrl_Unt
add wave -noupdate -label expected_out /tb_control_unit/expected_out

run 1250