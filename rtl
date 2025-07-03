`ifndef DEFINES_V
`define DEFINES_V

// Data path width
`define DATA_WIDTH 16
// Address width for instruction and data memory
`define ADDR_WIDTH 16
// Register address width (for 8 registers: R0-R7)
`define REG_ADDR_WIDTH 3

// Instruction Opcodes (4 bits)
`define OPCODE_R_TYPE   4'b0000 // R-type instructions (ADD, SUB, AND, OR)
`define OPCODE_ADDI     4'b0001 // Add Immediate
`define OPCODE_LW       4'b0010 // Load Word
`define OPCODE_SW       4'b0011 // Store Word
`define OPCODE_BEQ      4'b0100 // Branch Equal
`define OPCODE_JUMP     4'b0101 // Unconditional Jump
`define OPCODE_HALT     4'b1111 // Halt processor

// R-type Function Codes (3 bits)
`define FUNC_ADD        3'b000
`define FUNC_SUB        3'b001
`define FUNC_AND        3'b010
`define FUNC_OR         3'b011

// ALU Operations (defined by Control Unit)
`define ALU_ADD         3'b000
`define ALU_SUB         3'b001
`define ALU_AND         3'b010
`define ALU_OR          3'b011
`define ALU_PASS_B      3'b100 // For ADDI, pass immediate
`define ALU_EQ          3'b101 // For BEQ, compare equality

// Control Signals
// MemWrite: 1 if data memory write, 0 otherwise
// MemRead: 1 if data memory read, 0 otherwise
// RegWrite: 1 if register file write, 0 otherwise
// MemToReg: 1 if data from memory written to reg, 0 if ALU result
// ALUSrc: 0 if ALU src2 is Rs2, 1 if ALU src2 is immediate
// Branch: 1 if branch instruction
// Jump: 1 if jump instruction
// Halt: 1 if halt instruction

`endif // DEFINES_V
