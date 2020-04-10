include "reg.inc"

section "header", rom0[$0100]
   nop
   jp main
   ds $4C

section "main", rom0
main:
   xor a, a
   ld [REG_LCDC], a
   ld a, $93
   ld [REG_BGP], a
   ld [REG_OBP0], a
   ld a, $03
   ld [REG_IE], a

   call random_init
   call tiles_init
   call oam_init
   call background_init
   call player_init

   ld a, $93
   ld [REG_LCDC], a
   xor a, a
   ld [REG_IF], a
   ei

.loop:
   call oam_update
   call background_update
   call player_update
   jr .loop
