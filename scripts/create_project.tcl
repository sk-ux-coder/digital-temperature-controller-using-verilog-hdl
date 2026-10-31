# Run from the repository root in Vivado 2016.1.
set root [file normalize [file join [file dirname [info script]] ..]]
create_project temperature_controller $root/vivado_project -part xc7a100tcsg324-1 -force
add_files [glob -nocomplain $root/src/*.v]
add_files -fileset constrs_1 $root/constraints/nexys4ddr.xdc
add_files -fileset sim_1 $root/sim/tb_temperature_top.v
set_property top temperature_demo_top [current_fileset]
set_property top tb_temperature_top [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
save_project_as temperature_controller $root/vivado_project
puts "Project created: $root/vivado_project/temperature_controller.xpr"
