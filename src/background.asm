include "reg.inc"

section "background", rom0
; ```
; background_init()
; ```
background_init::
   ld a, $01
TILE = $9800
rept 18
   ld [TILE], a
TILE = TILE + $20
endr

   ld h, high(background_scx)
   ld l, $00
.loop:
   call random
   ld [hl], a
   inc l
   jr nz, .loop

   ld a, $08
   ld [REG_STAT], a
   ret

; ```
; background_update()
; ```
background_update::
   ld h, high(background_scx)
   call random
   ld l, a
   call random
   ld [hl], a
   ld a, [background_scx]
   ld [REG_SCX], a
   ret

section "background_stat", rom0[$0048]
   push af
   push bc
   ld b, high(background_scx)
   ld a, [REG_LY]
   inc a
   ld c, a
   ld a, [bc]
   ld [REG_SCX], a
   pop bc
   pop af
   reti

section "background_ram", wram0, align[8]
background_scx: ds 256
