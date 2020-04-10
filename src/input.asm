include "reg.inc"

section "input", rom0
; ```
; input()
; return(state: A)
; destroy(B)
; ```
input::
   ld a, $10
   ld [REG_JOYP], a
   ld a, [REG_JOYP]
   ld a, [REG_JOYP]
   and a, $0F
   ld b, a

   ld a, $20
   ld [REG_JOYP], a
   ld a, [REG_JOYP]
   ld a, [REG_JOYP]
   swap a
   and a, $F0
   or b
   ret
