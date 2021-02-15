CXXFLAGS := -Wall -Wextra -pedantic -std=c++17
CXXFLAGS += -Os -flto -s

all: apt-encode

apt-encode: apt-encode.cpp Makefile
	$(CXX) $(CXXFLAGS) -o $@ $<

format:
	clang-format -i apt-encode.cpp
.PHONY: format

clean:
	rm -f apt-encode
.PHONY: clean
