#installation
PREFIX=/usr

# Change to whatever your C++ compiler is
CC=g++

# Compile settings
CFLAGS=-c -Wall
LFLAGS=-lm

# Source files
SOURCES=src/JSON.cpp src/JSONValue.cpp src/demo/nix-main.cpp src/demo/example.cpp src/demo/testcases.cpp
HEADERS=src/JSON.h src/JSONValue.h
OBJECTS=$(SOURCES:src/%.cpp=obj/%.o)

# Output
EXECUTABLE=JSONDemo
LIBRARY=lib/SimpleJSON.a

all:	$(SOURCES) $(EXECUTABLE) $(LIBRARY)

$(LIBRARY): $(OBJECTS)
	ar -q $(LIBRARY) obj/JSON.o obj/JSONValue.o

$(EXECUTABLE):	$(OBJECTS) 
		$(CC) $(LFLAGS) $(OBJECTS) -o $@

obj/%.o:	src/%.cpp 
		$(CC) $(CFLAGS) $^ -o $@

clean:
		rm -f $(OBJECTS) $(EXECUTABLE)

install: all
	mv $(LIBRARY) $(PREFIX)/lib/json.a
	mkdir $(PREFIX)/include/json
	cp src/JSONValue.h src/JSON.h $(PREFIX)/include/json
