include "reg.inc"

section "random", rom0
; ```
; random_init()
; ```
random_init::
   ld a, "G"
   ld [random_seed+0], a
   ld a, "b"
   ld [random_seed+1], a
   ret

; ```
; random()
; return(value: A)
; destroy(BC, DE)
; ```
random::
   ; seed ^= seed << 7
   ; seed ^= seed >> 9
   ; seed ^= seed << 8
   ld a, [random_seed]
   ld b, a
   ld d, a
   ld a, [random_seed+1]
   ld c, a
   ld e, 0
   srl d
   rr a
   rr e
   xor a, b
   ld b, a
   ld d, a
   ld a, c
   xor a, e
   srl d
   xor a, d
   ld c, a
   xor a, b
   ld [random_seed], a
   ld a, c
   ld [random_seed+1], a
   ret

section "random_ram", wram0
random_seed: ds 2
