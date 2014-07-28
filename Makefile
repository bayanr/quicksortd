build_test:
	dmd quicksort.d -unittest

test: build_test
	./quicksort
