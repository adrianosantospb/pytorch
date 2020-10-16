#GPU version
export PATH=/usr/local/cuda-10.1/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
export CUDA_BIN_PATH=/usr/local/cuda
export CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.1

# Clone, checkout specific commit and build for GPU with CUDA support
git clone https://github.com/pytorch/pytorch.git &&\
    cd pytorch && \
    git submodule update --init --recursive  &&\
    pip3 install pyyaml==3.13 &&\
    pip3 install -r requirements.txt &&\
    USE_OPENCV=1 \
    USE_CUDA=1 \
    USE_NNPACK=1 \
    BUILD_TORCH=ON \
    CMAKE_PREFIX_PATH="/usr/bin/" \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:$LD_LIBRARY_PATH \
    CUDA_BIN_PATH=/usr/local/cuda/bin \
    CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda/ \
    CUDNN_LIB_DIR=/usr/local/cuda/lib64 \
    CUDA_HOST_COMPILER=cc \
    CC=cc \
    CXX=c++ \
    TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1+PTX" \
    TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    #ccmake build
    python3 setup.py bdist_wheel USE_OPENCV=1 USE_CUDA=1 BUILD_TORCH=ON

# Install the Python wheel (includes LibTorch)
#pip3 install dist/*.whl
cd ..
# Clean up resources
rm -fr pytorch