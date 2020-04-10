section "player", rom0

; ```
; player_init()
; ```
player_init::
   ld l, $00
   ld b, 80
   ld e, 128
   ld d, $02
   call oam_create2
   ret

; ```
; player_update()
; ```
player_update::
   ld l, $00
   call oam_get
   ld d, b
   call input
   ld e, a
   ld a, d

   bit 4, e
   jr nz, .right
   inc a
   cp a, 148
   jr c, .right
   ld a, 148
.right:

   bit 5, e
   jr nz, .left
   dec a
   cp a, 12
   jr nc, .left
   ld a, 12
.left:

   ld l, $00
   ld b, a
   ld d, c
   jp oam_set2
