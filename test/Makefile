# Makefile
# Adaptado para proyecto ALU con Prefix y Display en Tiny Tapeout

# Simulador por defecto
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Directorio fuente
SRC_DIR = $(PWD)/src
PROJECT_SOURCES = \
    tt_um_alu_prefix_display.v \
    alu.v \
    prefix.v \
    display_controller.v

# RTL simulation:
ifneq ($(GATES),yes)
SIM_BUILD = sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))
else
# Gate-level simulation:
SIM_BUILD = sim_build/gl
COMPILE_ARGS    += -DGL_TEST
COMPILE_ARGS    += -DFUNCTIONAL
COMPILE_ARGS    += -DSIM
VERILOG_SOURCES += $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_io/verilog/sg13g2_io.v
VERILOG_SOURCES += $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_stdcell/verilog/sg13g2_stdcell.v
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v
endif

# Incluir la carpeta src para archivos compartidos
COMPILE_ARGS += -I$(SRC_DIR)

# Testbench
VERILOG_SOURCES += $(PWD)/test/test_tb.v
TOPLEVEL = tt_um_alu_prefix_display

# Python test file base name (si se usa cocotb)
MODULE = test

# Incluir reglas de cocotb
include $(shell cocotb-config --makefiles)/Makefile.sim
