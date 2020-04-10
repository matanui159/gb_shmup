section "tilemap", rom0
; ```
; tiles_init()
; ```
tiles_init::
   ld bc, tile_data
   ld de, tile_data.end
   ld hl, $8000
   jp mem_copy

tile_data:
   ds $10
   include "res/background.inc"
   include "res/player.inc"
.end:
