.PHONY: test bench clean

test:
	mojo test tests/

bench:
	mojo run benchmarks/bench_distance.mojo
	mojo run benchmarks/bench_search.mojo

run:
	mojo run main.mojo

clean:
	rm -f index.ffvx
