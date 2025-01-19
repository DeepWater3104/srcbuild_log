#! /bin/bash

#PJM --rsc-list "node=1"
#PJM --mpi "max-proc-per-node=48"
#PJM -g hp200139
#PJM --rsc-list "elapse=00:40:00"
#PJM -m b,e
#PJM --mail-list "fukami.satoshi760@mail.kyutech.jp"
#PJM -j
#PJM -s

#module load Python3-CN

#. ../../spack/share/spack/setup-env.sh
. /vol0004/apps/oss/spack/share/spack/setup-env.sh
spack load /nencizh # gcc@12.2.0
spack load fujitsu-mpi%gcc@12.2.0
spack load /fhakchp # python@3.8.12%fj@4.7.0
spack load /dgmiy5n # py-numpy@1.25.2%fj@4.10.0
spack load /kndrnlz # py-setuptools@68.0.0%fj4.10.0
spack load /37xmpin #py-pip@23.0%fj@4.10.0
spack load /fl35w2u # py-jinja2
spack load /esj6scy # py-pyyaml

export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH

spack find --loaded # see the list of loaded modules

pip list

which mpicc mpicxx

cmake .. \
  -DNRN_ENABLE_CORENEURON=ON \
  -DCORENRN_ENABLE_GPU=OFF \
  -DNRN_ENABLE_INTERVIEWS=OFF \
  -DNRN_ENABLE_RX3D=OFF \
  -DCMAKE_INSTALL_PREFIX=../../install \
  -DMPI_C_COMPILER=mpicc \
  -DMPI_CXX_COMPILER=mpicxx

cmake --build . --parallel 8
cmake --build . --target install
#make -j
