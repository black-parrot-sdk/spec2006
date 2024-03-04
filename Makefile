include Makefile.frag

RUNS = $(patsubst %,%.riscv,$(BENCHMARKS))
INPUTS = $(foreach BENCH,$(BENCHMARKS),inputs/$(BENCH))

all:
	$(MAKE) $(RUNS)

inputs:
	$(MAKE) $(INPUTS)

spec2006:
	-git clone git@github.com:black-parrot-sdk/spec2006-private spec2006
#	-git clone https://github.com/black-parrot-sdk/spec2006-private.git spec2006

%.riscv: spec2006
	$(MAKE) -f Makefile.$* $@
	$(MAKE) -f Makefile.$* clean

inputs/%: spec2006
	$(MAKE) -f Makefile.$* $@
	$(MAKE) -f Makefile.$* clean

clean:
	for benchmark in $(BENCHMARKS) ; do \
	rm -rf $$benchmark.riscv; \
	$(MAKE) -f Makefile.$$benchmark clean; \
	done;
