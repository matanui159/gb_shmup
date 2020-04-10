section "mem",rom0
; ```
; mem_copy(start: BC, end: DE, dest: HL)
; destroy(A, BC, HL)
; ```
mem_copy::
   ld a, [bc]
   inc bc
   ld [hl+], a
   ld a, c
   cp a, e
   jr nz, mem_copy
   ld a, b
   cp a, d
   jr nz, mem_copy
   ret

; ```
; mem_fill(start: HL, end: BC, value: D)
; destroy(A, HL)
; ```
mem_fill::
   ld [hl], d
   inc hl
   ld a, l
   cp a, c
   jr nz, mem_fill
   ld a, h
   cp a, b
   jr nz, mem_fill
   ret
