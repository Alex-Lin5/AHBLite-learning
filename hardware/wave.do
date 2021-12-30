onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/top/CLK
add wave -noupdate /testbench/top/uAHB2LED/HCLK
add wave -noupdate /testbench/top/uAHB2LED/HADDR
add wave -noupdate /testbench/top/uAHB2LED/rHADDR
add wave -noupdate /testbench/top/uAHB2LED/HRDATA
add wave -noupdate /testbench/top/uAHB2LED/HREADY
add wave -noupdate /testbench/top/uAHB2LED/HREADYOUT
add wave -noupdate /testbench/top/uAHB2LED/HRESETn
add wave -noupdate /testbench/top/uAHB2LED/HSEL
add wave -noupdate /testbench/top/uAHB2LED/HSIZE
add wave -noupdate /testbench/top/uAHB2LED/HTRANS
add wave -noupdate /testbench/top/uAHB2LED/HWDATA
add wave -noupdate /testbench/top/hwdatas
add wave -noupdate /testbench/top/uAHB2LED/HWRITE
add wave -noupdate /testbench/top/uAHB2LED/rLED
add wave -noupdate /testbench/top/uAHB2LED/rMASK
add wave -noupdate /testbench/top/uAHBDCD/MUX_SEL
add wave -noupdate /testbench/top/uAHB2LED/masktp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {629409 ps} 0} {{Cursor 2} {532053 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 265
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {235723 ps} {662129 ps}
