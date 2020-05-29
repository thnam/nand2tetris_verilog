# Project setup
TOP ?= top
SIM = iverilog
WAVE = vvp

BUILD = ./build
VCD = $(BUILD)/waveform.vcd

# Files
MODULES += $(wildcard rtl/*.v)
TEST = tb.v

.PHONY: all clean burn

all: sim

sim: $(TEST) $(MODULES)
	@mkdir -p $(BUILD)
	@$(SIM) -o $(BUILD)/tb_out $< $(MODULES) && $(WAVE) $(BUILD)/tb_out && open $(VCD)

clean:
	rm -rf $(BUILD)
