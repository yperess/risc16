grammar Risc16;

program
  : (line NL+)*
  ;

line : WS* statement WS* COMMENT? ;

statement
  : add_statement
  | addi_statement
  | nand_statement
  | lui_statement
  | sw_statement
  | lw_statement
  | beq_statement
  | jalr_statement
  ;

COMMENT
  : '#' ~[\r\n]* -> skip
  ;

add_statement
  : ADD WS+ reg_reg_reg
  ;
addi_statement
  : ADDI WS+ reg_reg_imm
  ;
nand_statement
  : NAND WS+ reg_reg_reg
  ;
lui_statement
  : LUI WS+ REGISTER WS_COMMA_WS IMM
  ;
sw_statement
  : SW WS+ reg_reg_imm
  ;
lw_statement
  : LW WS+ reg_reg_imm
  ;
beq_statement
  : BEQ WS+ reg_reg_imm
  ;
jalr_statement
  : JALR WS+ REGISTER WS_COMMA_WS REGISTER
  ;

reg_reg_reg
  : REGISTER WS_COMMA_WS REGISTER WS_COMMA_WS REGISTER
  ;
reg_reg_imm
  : REGISTER WS_COMMA_WS REGISTER WS_COMMA_WS IMM
  ;
REGISTER : 'r' [0-9]+ ;
WS_COMMA_WS : WS* COMMA WS* -> skip ;

ADD : 'add' ;
ADDI : 'addi' ;
NAND : 'nand' ;
LUI : 'lui' ;
SW : 'sw' ;
LW : 'lw' ;
BEQ : 'beq' ;
JALR : 'jalr' ;

IMM : (HEX | DEC) ;
fragment HEX : '0x' [0-9a-fA-F]+ ;
fragment DEC : [0-9]+ ;

COMMA : ',' -> skip ;
WS : [ \t] -> skip ;
NL : '\r'? '\n' -> skip ;
