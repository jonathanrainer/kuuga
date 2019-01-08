#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.2 (64-bit)
#
# Filename    : compile.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for compiling the simulation design source files
#
# Generated by Vivado on Tue Jan 08 08:34:26 GMT 2019
# SW Build 2258646 on Thu Jun 14 20:02:38 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: compile.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
echo "xvlog --incr --relax -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_3 -L axi_vip_v1_1_3 -L xilinx_vip -prj axi_verifier_testbench_vlog.prj"
ExecStep xvlog --incr --relax -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_3 -L axi_vip_v1_1_3 -L xilinx_vip -prj axi_verifier_testbench_vlog.prj 2>&1 | tee compile.log
echo "xvhdl --incr --relax -prj axi_verifier_testbench_vhdl.prj"
ExecStep xvhdl --incr --relax -prj axi_verifier_testbench_vhdl.prj 2>&1 | tee -a compile.log
