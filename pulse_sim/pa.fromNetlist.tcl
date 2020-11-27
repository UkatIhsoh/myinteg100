
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name pulse_sim -dir "E:/hoshino_Data/SotsuKen/ISE/myinteg100/pulse_sim/planAhead_run_3" -part xc6slx9tqg144-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/hoshino_Data/SotsuKen/ISE/myinteg100/pulse_sim/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/hoshino_Data/SotsuKen/ISE/myinteg100/pulse_sim} {ipcore_dir} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design