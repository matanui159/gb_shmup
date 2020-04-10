src = $(sort $(wildcard src/*.asm))
obj = $(src:%.asm=bin/%.o)
dep = $(obj:.o=.d)
out = bin/rom.gb
build: $(out)

-include $(dep)
bin/%.o: %.asm
	mkdir -p $(dir $@)
	rgbasm -o $@ $< -M $(@:.o=.d) -i $(dir $<) -Weverything

$(out): $(obj)
	rgblink -o $@ $^ -dtm $(@:.gb=.map)
	rgbfix $@ -vp 0

run: $(out)
	binjgb-debugger $< -p -P 74
	-rm imgui.ini

clean:
	rm -r bin

.PHONY: build run clean
