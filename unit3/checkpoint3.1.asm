// XMega65 Kernal Development Template
// Each function of the kernal is a no-args function
// The functions are placed in the SYSCALLS table surrounded by JMP and NOP
  .file [name="checkpoint3.1.bin", type="bin", segments="XMega65Bin"]
.segmentdef XMega65Bin [segments="Syscall, Code, Data, Stack, Zeropage"]
.segmentdef Syscall [start=$8000, max=$81ff]
.segmentdef Code [start=$8200, min=$8200, max=$bdff]
.segmentdef Data [startAfter="Code", min=$8200, max=$bdff]
.segmentdef Stack [min=$be00, max=$beff, fill]
.segmentdef Zeropage [min=$bf00, max=$bfff, fill]
  // Some definitions of addresses and special values that this program uses 
  .label RASTER = $d012
  .label VIC_MEMORY = $d018
  .label SCREEN = $400
  .label BGCOL = $d021
  .label COLS = $d800
  .const BLACK = 0
  .const WHITE = 1
  // To save writing 0x4C and 0xEA all the time, we define them as constants
  .const JMP = $4c
  .const NOP = $ea
.segment Code
main: {
    jsr RESET
    rts
}
RESET: {
    jsr print_to_screen
  b1:
    lda #$36
    cmp RASTER
    beq b2
    lda #$42
    cmp RASTER
    beq b2
    lda #BLACK
    sta BGCOL
    jmp b1
  b2:
    lda #WHITE
    sta BGCOL
    jmp b1
}
// print_to_screen(byte* zeropage(2) message)
print_to_screen: {
    .label sc = 4
    .label message = 2
    lda #$14
    sta VIC_MEMORY
    ldx #' '
    lda #<SCREEN
    sta.z memset.str
    lda #>SCREEN
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    ldx #WHITE
    lda #<COLS
    sta.z memset.str
    lda #>COLS
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    lda #<SCREEN+$28
    sta.z sc
    lda #>SCREEN+$28
    sta.z sc+1
    lda #<MESSAGE
    sta.z message
    lda #>MESSAGE
    sta.z message+1
  b1:
    ldy #0
    lda (message),y
    cmp #0
    bne b2
    rts
  b2:
    ldy #0
    lda (message),y
    sta (sc),y
    inc.z sc
    bne !+
    inc.z sc+1
  !:
    inc.z message
    bne !+
    inc.z message+1
  !:
    jmp b1
}
// Copies the character c (an unsigned char) to the first num characters of the object pointed to by the argument str.
// memset(void* zeropage(4) str, byte register(X) c, word zeropage(2) num)
memset: {
    .label end = 2
    .label dst = 4
    .label num = 2
    .label str = 4
    lda.z num
    bne !+
    lda.z num+1
    beq breturn
  !:
    lda.z end
    clc
    adc.z str
    sta.z end
    lda.z end+1
    adc.z str+1
    sta.z end+1
  b2:
    lda.z dst+1
    cmp.z end+1
    bne b3
    lda.z dst
    cmp.z end
    bne b3
  breturn:
    rts
  b3:
    txa
    ldy #0
    sta (dst),y
    inc.z dst
    bne !+
    inc.z dst+1
  !:
    jmp b2
}
syscall64: {
    jsr exit_hypervisor
    rts
}
exit_hypervisor: {
    //Trigger exit from Hypervisor mode
    lda #1
    sta $d67f
    rts
}
syscall63: {
    jsr exit_hypervisor
    rts
}
syscall62: {
    jsr exit_hypervisor
    rts
}
syscall61: {
    jsr exit_hypervisor
    rts
}
syscall60: {
    jsr exit_hypervisor
    rts
}
syscall59: {
    jsr exit_hypervisor
    rts
}
syscall58: {
    jsr exit_hypervisor
    rts
}
syscall57: {
    jsr exit_hypervisor
    rts
}
syscall56: {
    jsr exit_hypervisor
    rts
}
syscall55: {
    jsr exit_hypervisor
    rts
}
syscall54: {
    jsr exit_hypervisor
    rts
}
syscall53: {
    jsr exit_hypervisor
    rts
}
syscall52: {
    jsr exit_hypervisor
    rts
}
syscall51: {
    jsr exit_hypervisor
    rts
}
syscall50: {
    jsr exit_hypervisor
    rts
}
syscall49: {
    jsr exit_hypervisor
    rts
}
syscall48: {
    jsr exit_hypervisor
    rts
}
syscall47: {
    jsr exit_hypervisor
    rts
}
syscall46: {
    jsr exit_hypervisor
    rts
}
syscall45: {
    jsr exit_hypervisor
    rts
}
syscall44: {
    jsr exit_hypervisor
    rts
}
syscall43: {
    jsr exit_hypervisor
    rts
}
syscall42: {
    jsr exit_hypervisor
    rts
}
syscall41: {
    jsr exit_hypervisor
    rts
}
syscall40: {
    jsr exit_hypervisor
    rts
}
syscall39: {
    jsr exit_hypervisor
    rts
}
syscall38: {
    jsr exit_hypervisor
    rts
}
syscall37: {
    jsr exit_hypervisor
    rts
}
syscall36: {
    jsr exit_hypervisor
    rts
}
syscall35: {
    jsr exit_hypervisor
    rts
}
syscall34: {
    jsr exit_hypervisor
    rts
}
syscall33: {
    jsr exit_hypervisor
    rts
}
syscall32: {
    jsr exit_hypervisor
    rts
}
syscall31: {
    jsr exit_hypervisor
    rts
}
syscall30: {
    jsr exit_hypervisor
    rts
}
syscall29: {
    jsr exit_hypervisor
    rts
}
syscall28: {
    jsr exit_hypervisor
    rts
}
syscall27: {
    jsr exit_hypervisor
    rts
}
syscall26: {
    jsr exit_hypervisor
    rts
}
syscall25: {
    jsr exit_hypervisor
    rts
}
syscall24: {
    jsr exit_hypervisor
    rts
}
syscall23: {
    jsr exit_hypervisor
    rts
}
syscall22: {
    jsr exit_hypervisor
    rts
}
syscall21: {
    jsr exit_hypervisor
    rts
}
syscall20: {
    jsr exit_hypervisor
    rts
}
syscall19: {
    jsr exit_hypervisor
    rts
}
SECUREXIT: {
    jsr exit_hypervisor
    rts
}
SECURENTR: {
    jsr exit_hypervisor
    rts
}
syscall16: {
    jsr exit_hypervisor
    rts
}
syscall15: {
    jsr exit_hypervisor
    rts
}
syscall14: {
    jsr exit_hypervisor
    rts
}
syscall13: {
    jsr exit_hypervisor
    rts
}
syscall12: {
    jsr exit_hypervisor
    rts
}
syscall11: {
    jsr exit_hypervisor
    rts
}
syscall10: {
    jsr exit_hypervisor
    rts
}
syscall9: {
    jsr exit_hypervisor
    rts
}
syscall8: {
    jsr exit_hypervisor
    rts
}
syscall7: {
    jsr exit_hypervisor
    rts
}
syscall6: {
    jsr exit_hypervisor
    rts
}
syscall5: {
    jsr exit_hypervisor
    rts
}
syscall4: {
    jsr exit_hypervisor
    rts
}
syscall3: {
    jsr exit_hypervisor
    rts
}
syscall2: {
    jsr exit_hypervisor
    rts
}
// Here are a couple sample SYSCALL handlers that just display a character on the 
syscall1: {
    jsr exit_hypervisor
    rts
}
undefined_trap: {
    rts
}
CPUKIL: {
    rts
}
VF011WR: {
    rts
}
VF011RD: {
    rts
}
ALTTABKEY: {
    rts
}
RESTORKEY: {
    rts
}
PAGFAULT: {
    rts
}
.segment Data
  // Some text to display
  MESSAGE: .text "peng0163"
  .byte 0
.segment Syscall
  //Now we can have a nice table of up to 64 SYSCALL handlers expressed
  //in a fairly readable and easy format.
  //Each line is an instance of the struct Syscall from above, with the JMP
  //opcode value, the address of the handler routine and the NOP opcode value.
SYSCALLS:
  .byte JMP
  .word syscall1
  .byte NOP
  .byte JMP
  .word syscall2
  .byte NOP
  .byte JMP
  .word syscall3
  .byte NOP
  .byte JMP
  .word syscall4
  .byte NOP
  .byte JMP
  .word syscall5
  .byte NOP
  .byte JMP
  .word syscall6
  .byte NOP
  .byte JMP
  .word syscall7
  .byte NOP
  .byte JMP
  .word syscall8
  .byte NOP
  .byte JMP
  .word syscall9
  .byte NOP
  .byte JMP
  .word syscall10
  .byte NOP
  .byte JMP
  .word syscall11
  .byte NOP
  .byte JMP
  .word syscall12
  .byte NOP
  .byte JMP
  .word syscall13
  .byte NOP
  .byte JMP
  .word syscall14
  .byte NOP
  .byte JMP
  .word syscall15
  .byte NOP
  .byte JMP
  .word syscall16
  .byte NOP
  .byte JMP
  .word SECURENTR
  .byte NOP
  .byte JMP
  .word SECUREXIT
  .byte NOP
  .byte JMP
  .word syscall19
  .byte NOP
  .byte JMP
  .word syscall20
  .byte NOP
  .byte JMP
  .word syscall21
  .byte NOP
  .byte JMP
  .word syscall22
  .byte NOP
  .byte JMP
  .word syscall23
  .byte NOP
  .byte JMP
  .word syscall24
  .byte NOP
  .byte JMP
  .word syscall25
  .byte NOP
  .byte JMP
  .word syscall26
  .byte NOP
  .byte JMP
  .word syscall27
  .byte NOP
  .byte JMP
  .word syscall28
  .byte NOP
  .byte JMP
  .word syscall29
  .byte NOP
  .byte JMP
  .word syscall30
  .byte NOP
  .byte JMP
  .word syscall31
  .byte NOP
  .byte JMP
  .word syscall32
  .byte NOP
  .byte JMP
  .word syscall33
  .byte NOP
  .byte JMP
  .word syscall34
  .byte NOP
  .byte JMP
  .word syscall35
  .byte NOP
  .byte JMP
  .word syscall36
  .byte NOP
  .byte JMP
  .word syscall37
  .byte NOP
  .byte JMP
  .word syscall38
  .byte NOP
  .byte JMP
  .word syscall39
  .byte NOP
  .byte JMP
  .word syscall40
  .byte NOP
  .byte JMP
  .word syscall41
  .byte NOP
  .byte JMP
  .word syscall42
  .byte NOP
  .byte JMP
  .word syscall43
  .byte NOP
  .byte JMP
  .word syscall44
  .byte NOP
  .byte JMP
  .word syscall45
  .byte NOP
  .byte JMP
  .word syscall46
  .byte NOP
  .byte JMP
  .word syscall47
  .byte NOP
  .byte JMP
  .word syscall48
  .byte NOP
  .byte JMP
  .word syscall49
  .byte NOP
  .byte JMP
  .word syscall50
  .byte NOP
  .byte JMP
  .word syscall51
  .byte NOP
  .byte JMP
  .word syscall52
  .byte NOP
  .byte JMP
  .word syscall53
  .byte NOP
  .byte JMP
  .word syscall54
  .byte NOP
  .byte JMP
  .word syscall55
  .byte NOP
  .byte JMP
  .word syscall56
  .byte NOP
  .byte JMP
  .word syscall57
  .byte NOP
  .byte JMP
  .word syscall58
  .byte NOP
  .byte JMP
  .word syscall59
  .byte NOP
  .byte JMP
  .word syscall60
  .byte NOP
  .byte JMP
  .word syscall61
  .byte NOP
  .byte JMP
  .word syscall62
  .byte NOP
  .byte JMP
  .word syscall63
  .byte NOP
  .byte JMP
  .word syscall64
  .byte NOP
  //In this example we had only two SYSCALLs defined, so rather than having
  //another 62 lines, we can just ask KickC to make the TRAP table begin
  //at the next multiple of $100, i.e., at $8100.
  .align $100
SYSCALL_RESET:
  .byte JMP
  .word RESET
  .byte NOP
  .byte JMP
  .word PAGFAULT
  .byte NOP
  .byte JMP
  .word RESTORKEY
  .byte NOP
  .byte JMP
  .word ALTTABKEY
  .byte NOP
  .byte JMP
  .word VF011RD
  .byte NOP
  .byte JMP
  .word VF011WR
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word CPUKIL
  .byte NOP
