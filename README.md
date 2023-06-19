# Deep Learning I/O microbenchmark 

This benchmark depends on HDF5:

```bash
export HDF5_ROOT=PATH_TO_INSTALL_HDF5
git clone https://github.com/HDFGroup/hdf5.git
cd hdf5
./autogen.sh
CC=mpicc CXX=mpicxx ./configure --enable-parallel --enable-symbols=yes --prefix=$HDF5_ROOT/ --enable-build-mode=debug --enable-shared --enable-parallel --enable-threadsafe --enable-unsupported --enable-map-api
make -j 8
make install
```


## Parallel read
* **prepare_dataset.cpp** this is to prepare the dataset for the parallel read benchark.

```bash
mpirun -np 4 ./prepare_dataset --num_images 8192 --sz 224 --output images.h5
```

This will generate a hdf5 file, images.h5, which contains 8192 samples. Each 224x224x3 (image-base dataset)

* **read_cache.cpp is the benchmark code for evaluating the parallel read performance. This will read the samples batch by batch from the shared file
  * --input: HDF5 file [Default: images.h5]
  * --dataset: the name of the dataset in the HDF5 file [Default: dataset]
  * --num_epochs [Default: 2]: Number of epochs (at each epoch/iteration, we sweep through the dataset)
  * --num_batches [Default: 16]: Number of batches to read per epoch
  * --batch_size [Default: 32]: Number of samples per batch
  * --shuffle: Whether to shuffle the samples at the beginning of each epoch.
  * --local_storage [Default: ./]: The path of the local storage.

