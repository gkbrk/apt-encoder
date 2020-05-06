CXXFLAGS := -Wall -Wextra -Werror -pedantic -std=c++17
CXXFLAGS += -Os -flto -s

apt-encode: apt-encode.cpp Makefile
	$(CXX) $(CXXFLAGS) -o $@ $<

format:
	clang-format -i apt-encode.cpp
.PHONY: format
