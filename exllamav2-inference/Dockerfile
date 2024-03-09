# cuda devel image for base, best build compatibility
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04 as builder

# Update base image and install dependencies
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 pip gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

RUN pip3 install torch==2.2.* --index-url https://download.pytorch.org/whl/cu121

ARG CACHEBUST=2

RUN pip3 install huggingface_hub transformers sentencepiece

RUN pip3 install flash-attn --no-build-isolation

ARG version

RUN git clone https://github.com/turboderp/exllamav2 # --branch $version

WORKDIR /exllamav2

RUN pip3 install -r requirements.txt

ENV CUDA_HOME='/usr/local/cuda-12.1'
ENV PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

ARG TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST:-8.6+PTX}"

RUN pip3 install setuptools

RUN pip3 install . -v

ENV CUDA_DOCKER_ARCH=all

CMD ["python3", "test_inference.py"]
