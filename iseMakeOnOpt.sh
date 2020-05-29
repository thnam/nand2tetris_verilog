#!/usr/bin/env bash
OptBuild=/home/nam/work/Xilinx/projects/ise
rsync -tqr rtl/*.v opt:$OptBuild/modules/
rsync -tqr constraint/*.ucf opt:$OptBuild/ucf/
ssh opt "cd $OptBuild; make PROJECT=$1"
mkdir -p bit && rsync -tqr opt:$OptBuild/build/$1.bit bit
