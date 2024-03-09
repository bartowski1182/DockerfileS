# cuda devel image for base, best build compatibility
FROM ubuntu:22.04

# Update base image and install dependencies
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 pip gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev

# RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

RUN pip3 install huggingface_hub transformers sentencepiece

RUN python3 -m pip install --upgrade pip

ARG branch
ARG CACHEBUST=1

# Pulling latest mergkit branch

RUN git clone https://github.com/arcee-ai/mergekit.git --branch $branch \
    && cd mergekit \
    && pip3 install -e .

WORKDIR /mergekit

COPY mergekit_moe_config.yml /mergekit/mergekit_moe_config.yml
