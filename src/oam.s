include "reg.inc"

section "oam", rom0
; ```
; oam_init()
; ```
oam_init::
   ld bc, oam_hram
   ld de, oam_hram.end
   ld hl, oam_dma
   call mem_copy

   ld hl, oam_data
   ld bc, oam_data.end
   ld d, 0
   jp mem_fill

; ```
; oam_update()
; ```
oam_update::
   ld hl, oam_halt
   ld [hl], 0
.loop:
   halt
   bit 0, [hl]
   jr z, .loop
   ret

oam_vblank:
   push af
   ld a, high(oam_data)
   call oam_dma
   ld a, 1
   ld [oam_halt], a
   pop af
   reti

; ```
; oam_create(id: L, x: B, y: C, tile: D)
; destroy(HL)
; ```
oam_create::
   ld h, high(oam_data)
   ld [hl], c
   inc l
   ld [hl], b
   inc l
   ld [hl], d
   ret

; ```
; oam_create2(id: L, x: B, y: E, tile: D)
; destroy(A, BC, D, HL)
; ```
oam_create2::
   ld c, e
   call oam_create
   inc l
   inc l

   inc d
   ld a, e
   add a, $08
   ld c, a
   call oam_create
   inc l
   inc l

   inc d
   ld a, b
   add a, $08
   ld b, a
   ld c, e
   call oam_create
   inc l
   inc l

   inc d
   ld a, e
   add a, $08
   ld c, a
   jp oam_create

; ```
; oam_destroy(id0: C)
; destroy(A, B)
; ```
; TODO: improve, make destroy2
oam_destroy::
   ld b, high(oam_data)
   ld a, 0
   ld [bc], a
   ret

; ```
; oam_get(id: L)
; return(x: B, y: C)
; destroy(HL)
; ```
oam_get::
   ld h, high(oam_data)
   ld c, [hl]
   inc l
   ld b, [hl]
   ret

; ```
; oam_set(id: L, x: B, y: C)
; destroy(HL)
; ```
oam_set::
   ld h, high(oam_data)
   ld [hl], c
   inc l
   ld [hl], b
   ret

; ```
; oam_set2(id: L, x: B, y: D)
; destroy(A, BC, HL)
; ```
oam_set2::
   ld c, d
   call oam_set
   inc l
   inc l
   inc l

   ld a, d
   add a, $08
   ld c, a
   call oam_set
   inc l
   inc l
   inc l

   ld a, b
   add a, $08
   ld b, a
   ld c, d
   call oam_set
   inc l
   inc l
   inc l

   ld a, d
   add a, $08
   ld c, a
   jp oam_set

oam_hram:
   ld [REG_DMA], a
   ld a, 32
   dec a
   jp nz, oam_dma.loop
   ret
.end:

section "oam_vblank", rom0[$0040]
   jp oam_vblank

section "oam_ram", wram0, align[8]
oam_data: ds 160
.end:
oam_halt: db

section "oam_hram", hram
oam_dma:
   ds 4
.loop:
   ds 5
