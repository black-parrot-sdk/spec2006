include Makefile.frag

RUNS = $(patsubst %,%.riscv,$(BENCHMARKS))

all:
	$(MAKE) $(RUNS)

spec2006:
	git clone git@github.com:black-parrot-sdk/spec2006-private spec2006

%.riscv: spec2006
	$(MAKE) -f Makefile.$* $@
	$(MAKE) -f Makefile.$* clean

clean:
	for benchmark in $(BENCHMARKS) ; do \
	rm -rf $$benchmark.riscv; \
	$(MAKE) -f Makefile.$$benchmark clean; \
	done;
