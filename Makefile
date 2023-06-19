#Makefile
#!/bin/sh
include ./make.inc
CFLAGS += -I$(HDF5_ROOT)/include 
all: read_cache prepare_dataset 



LIBS += ./debug.o -L$(HDF5_ROOT)/lib -lhdf5 
all: prepare_dataset read_cache 

prepare_dataset: prepare_dataset.o debug.o 
	$(CXX) $(CXXFLAGS) -o $@ prepare_dataset.o debug.o -L$(HDF5_ROOT)/lib -lhdf5 

read_cache: read_cache.o debug.o utils.o
	$(CXX) $(CXXFLAGS) -o $@ read_cache.o debug.o utils.o $(LIBS) 

clean:
	rm -rf $(TARGET) *.o parallel_file.h5* read_cache *.btr prepare_dataset mpi_profile.* core

