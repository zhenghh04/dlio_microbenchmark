#Makefile
#!/bin/sh

CC=mpicc 
CXX=mpicxx 

HDF5_DIR=$(HDF5_ROOT)
INCLUDES=-I$(HDF5_DIR)/include -fPIC 

CFLAGS=$(INCLUDES) $(DEBUG) -g -O2

CXXFLAGS=$(INCLUDES) $(DEBUG) -g -O2


%.o : %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

%.o : %.c
	$(CC) $(CFLAGS) -o $@ -c $<

