#! /bin/bash

#PJM --rsc-list "node=1"
#PJM --mpi "max-proc-per-node=48"
#PJM -g hp200139
#PJM --rsc-list "elapse=00:40:00"
#PJM -m b,e
#PJM --mail-list "fukami.satoshi760@mail.kyutech.jp"
#PJM -j
#PJM -s
#PJM -x PJM_LLIO_GFSCACHE=/vol0002

cd arbor
rm -rf build
mkdir build
cd build

. /vol0004/apps/oss/spack/share/spack/setup-env.sh
spack load /nencizh # gcc@12.2.0
spack load fujitsu-mpi%gcc@12.2.0

which gcc
which g++
which mpicc
which mpicxx

export CC=`which mpicc`
export CXX=`which mpicxx`

cmake .. \
  -DARB_WITH_MPI=ON \
  -DARB_VECTORIZE=ON \
  -DARB_ARCH=native \


echo 'start make'
make -j 20
echo 'end make'

echo 'start make tests'
make -j 20 tests
echo 'end make tests'

echo 'start make examples'
make -j 20 examples
echo 'end make examples'

echo 'start unit test'
./bin/unit
echo 'end unit test'
