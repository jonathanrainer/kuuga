
################################################################
# This is a generated script based on design: simple_cache_test
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source simple_cache_test_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# core2axi_wrapper, core2axi_wrapper, godai_wrapper, gouram_wrapper, simple_cache_wrapper

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx485tffg1761-2
   set_property BOARD_PART xilinx.com:vc707:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name simple_cache_test

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_vip:1.1\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
core2axi_wrapper\
core2axi_wrapper\
godai_wrapper\
gouram_wrapper\
simple_cache_wrapper\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set clk [ create_bd_port -dir I -type clk clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {5000000} \
 ] $clk
  set rst_n [ create_bd_port -dir I -type rst rst_n ]
  set trace_out [ create_bd_port -dir O -from 127 -to 0 -type data trace_out ]

  # Create instance: Core2AXI_Data, and set properties
  set block_name core2axi_wrapper
  set block_cell_name Core2AXI_Data
  if { [catch {set Core2AXI_Data [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Core2AXI_Data eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.C_M_AXI_ADDR_WIDTH {16} \
 ] $Core2AXI_Data

  # Create instance: Core2AXI_Instruction, and set properties
  set block_name core2axi_wrapper
  set block_cell_name Core2AXI_Instruction
  if { [catch {set Core2AXI_Instruction [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Core2AXI_Instruction eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.C_M_AXI_ADDR_WIDTH {16} \
 ] $Core2AXI_Instruction

  # Create instance: axi_vip_0, and set properties
  set axi_vip_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_0 ]
  set_property -dict [ list \
   CONFIG.INTERFACE_MODE {SLAVE} \
 ] $axi_vip_0

  # Create instance: axi_vip_1, and set properties
  set axi_vip_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_1 ]
  set_property -dict [ list \
   CONFIG.INTERFACE_MODE {SLAVE} \
 ] $axi_vip_1

  # Create instance: godai_wrapper_0, and set properties
  set block_name godai_wrapper
  set block_cell_name godai_wrapper_0
  if { [catch {set godai_wrapper_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $godai_wrapper_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_ADDR_WIDTH {16} \
   CONFIG.INSTR_ADDR_WIDTH {16} \
 ] $godai_wrapper_0

  # Create instance: gouram_wrapper_0, and set properties
  set block_name gouram_wrapper
  set block_cell_name gouram_wrapper_0
  if { [catch {set gouram_wrapper_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $gouram_wrapper_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: simple_cache_wrapper_0, and set properties
  set block_name simple_cache_wrapper
  set block_cell_name simple_cache_wrapper_0
  if { [catch {set simple_cache_wrapper_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $simple_cache_wrapper_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {4} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_2

  # Create interface connections
  connect_bd_intf_net -intf_net Core2AXI_Data_M_AXI [get_bd_intf_pins Core2AXI_Data/M_AXI] [get_bd_intf_pins axi_vip_0/S_AXI]
  connect_bd_intf_net -intf_net Core2AXI_Instruction_M_AXI [get_bd_intf_pins Core2AXI_Instruction/M_AXI] [get_bd_intf_pins axi_vip_1/S_AXI]

  # Create port connections
  connect_bd_net -net Core2AXI_0_data_gnt_o [get_bd_pins Core2AXI_Instruction/data_gnt_o] [get_bd_pins godai_wrapper_0/instr_gnt_i] [get_bd_pins gouram_wrapper_0/instr_gnt]
  connect_bd_net -net Core2AXI_0_data_rdata_o [get_bd_pins Core2AXI_Instruction/data_rdata_o] [get_bd_pins godai_wrapper_0/instr_rdata_i] [get_bd_pins gouram_wrapper_0/instr_rdata]
  connect_bd_net -net Core2AXI_0_data_rvalid_o [get_bd_pins Core2AXI_Instruction/data_rvalid_o] [get_bd_pins godai_wrapper_0/instr_rvalid_i] [get_bd_pins gouram_wrapper_0/instr_rvalid]
  connect_bd_net -net Core2AXI_0_data_rvalid_o1 [get_bd_pins Core2AXI_Data/data_rvalid_o] [get_bd_pins gouram_wrapper_0/data_mem_rvalid] [get_bd_pins simple_cache_wrapper_0/out_data_rvalid_i]
  connect_bd_net -net Core2AXI_Data_data_gnt_o [get_bd_pins Core2AXI_Data/data_gnt_o] [get_bd_pins simple_cache_wrapper_0/out_data_gnt_i]
  connect_bd_net -net Core2AXI_Data_data_rdata_o [get_bd_pins Core2AXI_Data/data_rdata_o] [get_bd_pins simple_cache_wrapper_0/out_data_rdata_i]
  connect_bd_net -net Godai_0_data_addr_o [get_bd_pins Core2AXI_Data/data_addr_i] [get_bd_pins gouram_wrapper_0/data_mem_addr] [get_bd_pins simple_cache_wrapper_0/out_data_addr_o]
  connect_bd_net -net Godai_0_data_req_o [get_bd_pins Core2AXI_Data/data_req_i] [get_bd_pins gouram_wrapper_0/data_mem_req] [get_bd_pins simple_cache_wrapper_0/out_data_req_o]
  connect_bd_net -net Godai_0_instr_addr_o [get_bd_pins Core2AXI_Instruction/data_addr_i] [get_bd_pins godai_wrapper_0/instr_addr_o] [get_bd_pins gouram_wrapper_0/instr_addr]
  connect_bd_net -net Godai_0_instr_req_o [get_bd_pins Core2AXI_Instruction/data_req_i] [get_bd_pins godai_wrapper_0/instr_req_o] [get_bd_pins gouram_wrapper_0/instr_req]
  connect_bd_net -net Godai_0_jump_done_o [get_bd_pins godai_wrapper_0/jump_done_o] [get_bd_pins gouram_wrapper_0/jump_done]
  connect_bd_net -net clk_100MHz_1 [get_bd_ports clk] [get_bd_pins Core2AXI_Data/M_AXI_ACLK] [get_bd_pins Core2AXI_Instruction/M_AXI_ACLK] [get_bd_pins axi_vip_0/aclk] [get_bd_pins axi_vip_1/aclk] [get_bd_pins godai_wrapper_0/clk] [get_bd_pins gouram_wrapper_0/clk] [get_bd_pins simple_cache_wrapper_0/clk]
  connect_bd_net -net godai_wrapper_0_branch_decision_o [get_bd_pins godai_wrapper_0/branch_decision_o] [get_bd_pins gouram_wrapper_0/branch_decision]
  connect_bd_net -net godai_wrapper_0_branch_req_o [get_bd_pins godai_wrapper_0/branch_req_o] [get_bd_pins gouram_wrapper_0/branch_req]
  connect_bd_net -net godai_wrapper_0_data_addr_o [get_bd_pins godai_wrapper_0/data_addr_o] [get_bd_pins simple_cache_wrapper_0/in_data_addr_i]
  connect_bd_net -net godai_wrapper_0_data_be_o [get_bd_pins godai_wrapper_0/data_be_o] [get_bd_pins simple_cache_wrapper_0/in_data_be_i]
  connect_bd_net -net godai_wrapper_0_data_req_o [get_bd_pins godai_wrapper_0/data_req_o] [get_bd_pins simple_cache_wrapper_0/in_data_req_i]
  connect_bd_net -net godai_wrapper_0_data_wdata_o [get_bd_pins godai_wrapper_0/data_wdata_o] [get_bd_pins simple_cache_wrapper_0/in_data_wdata_i]
  connect_bd_net -net godai_wrapper_0_data_we_o [get_bd_pins godai_wrapper_0/data_we_o] [get_bd_pins simple_cache_wrapper_0/in_data_we_i]
  connect_bd_net -net godai_wrapper_0_is_decoding_o [get_bd_pins godai_wrapper_0/is_decoding_o] [get_bd_pins gouram_wrapper_0/is_decoding]
  connect_bd_net -net godai_wrapper_0_pc_set_o [get_bd_pins godai_wrapper_0/pc_set_o] [get_bd_pins gouram_wrapper_0/pc_set]
  connect_bd_net -net gouram_wrapper_0_trace_data_o [get_bd_ports trace_out] [get_bd_pins gouram_wrapper_0/trace_data_o]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_ports rst_n] [get_bd_pins Core2AXI_Data/M_AXI_ARESETN] [get_bd_pins Core2AXI_Instruction/M_AXI_ARESETN] [get_bd_pins axi_vip_0/aresetn] [get_bd_pins axi_vip_1/aresetn] [get_bd_pins godai_wrapper_0/rst_n] [get_bd_pins gouram_wrapper_0/rst_n] [get_bd_pins simple_cache_wrapper_0/rst_n]
  connect_bd_net -net simple_cache_wrapper_0_in_data_gnt_o [get_bd_pins godai_wrapper_0/data_gnt_i] [get_bd_pins simple_cache_wrapper_0/in_data_gnt_o]
  connect_bd_net -net simple_cache_wrapper_0_in_data_rdata_o [get_bd_pins godai_wrapper_0/data_rdata_i] [get_bd_pins simple_cache_wrapper_0/in_data_rdata_o]
  connect_bd_net -net simple_cache_wrapper_0_in_data_rvalid_o [get_bd_pins godai_wrapper_0/data_rvalid_i] [get_bd_pins simple_cache_wrapper_0/in_data_rvalid_o]
  connect_bd_net -net simple_cache_wrapper_0_out_data_be_i [get_bd_pins Core2AXI_Data/data_be_i] [get_bd_pins simple_cache_wrapper_0/out_data_be_o]
  connect_bd_net -net simple_cache_wrapper_0_out_data_wdata_i [get_bd_pins Core2AXI_Data/data_wdata_i] [get_bd_pins simple_cache_wrapper_0/out_data_wdata_o]
  connect_bd_net -net simple_cache_wrapper_0_out_data_we_i [get_bd_pins Core2AXI_Data/data_we_i] [get_bd_pins simple_cache_wrapper_0/out_data_we_o]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins Core2AXI_Instruction/data_we_i] [get_bd_pins godai_wrapper_0/data_err_i] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins Core2AXI_Instruction/data_be_i] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins Core2AXI_Instruction/data_wdata_i] [get_bd_pins godai_wrapper_0/irq_i] [get_bd_pins xlconstant_2/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x00000000 [get_bd_addr_spaces Core2AXI_Data/M_AXI] [get_bd_addr_segs axi_vip_0/S_AXI/Reg] SEG_axi_vip_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00000000 [get_bd_addr_spaces Core2AXI_Instruction/M_AXI] [get_bd_addr_segs axi_vip_1/S_AXI/Reg] SEG_axi_vip_1_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_msg_id "BD_TCL-1000" "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

