

# cmake のフラグ
CMAKE_FLAGS = 


# clang があれば使う
ifeq (,$(shell which clang))
WITH_CLANG ?= No
else
WITH_CLANG ?= Yes
endif

# ninja があれば使う
ifeq (,$(shell which ninja))
WITH_NINJA ?= No
else
WITH_NINJA ?= Yes
endif

ifeq ($(WITH_CLANG),Yes)
CMAKE_FLAGS += -C ../clang-cmakeinit.cmake
endif

ifeq ($(WITH_NINJA),Yes)
CMAKE_FLAGS += -GNinja
endif

IMG_FILE = ../../../../../data/images/windowswallpaper/Chrysanthemum_320x240_bayer10.pgm

.PHONY : all
all: build run

$(IMG_FILE):
	$(MAKE) -C ../../../../../data/images/windowswallpaper Chrysanthemum_320x240_bayer10.pgm

.PHONY : build
build:
	mkdir -p build && cd build && cmake $(CMAKE_FLAGS) ..
	cmake --build build -j

.PHONY : clean
clean:
	rm -rf build

.PHONY : distclean
distclean: clean
	rm -f *.fst *.vcd
	rm -f *.ppm *.pgm
	rm -f axi*.txt
	rm -f coverage.dat
	rm -fr annotated


.PHONY : run
run: $(IMG_FILE)
	build/tb_verilator

.PHONY : coverage
coverage:
	verilator_coverage --annotate annotated coverage.dat


