// XMega65 Kernal Development Template
// Each function of the kernal is a no-args function
// The functions are placed in the SYSCALLS table surrounded by JMP and NOP
  .file [name="checkpoint2.1.bin", type="bin", segments="XMega65Bin"]
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
    .label sc = 4
    .label msg = 2
    // Initialize screen memory, and select correct font
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
    sta.z msg
    lda #>MESSAGE
    sta.z msg+1
  // The messag to display
  // A simple copy routine to copy the string
  b1:
    ldy #0
    lda (msg),y
    cmp #0
    bne b2
  b3:
    lda #$36
    cmp RASTER
    beq b4
    lda #$42
    cmp RASTER
    beq b4
    lda #BLACK
    sta BGCOL
    jmp b3
  b4:
    lda #WHITE
    sta BGCOL
    jmp b3
  b2:
    ldy #0
    lda (msg),y
    sta (sc),y
    inc.z sc
    bne !+
    inc.z sc+1
  !:
    inc.z msg
    bne !+
    inc.z msg+1
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
syscall2: {
    lda #'<'
    sta SCREEN+$4e
    rts
}
// Here are a couple sample SYSCALL handlers that just display a character on the 
syscall1: {
    lda #'>'
    sta SCREEN+$4f
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
  //In this example we had only two SYSCALLs defined, so rather than having
  //another 62 lines, we can just ask KickC to make the TRAP table begin
  //at the next multiple of $100, i.e., at $8100.
  .align $100
SYSCALL_RESET:
  .byte JMP
  .word main
  .byte NOP
