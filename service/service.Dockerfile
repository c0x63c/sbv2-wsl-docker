FROM nvidia/cuda:12.1.0-base-ubuntu22.04

ENV PYTHONUNBUFFERED=1 

# system
# python3
RUN apt update -y -q && DEBIAN_FRONTEND=noninteractive apt install -y -q --no-install-recommends \
    git python3.10 pip libgl1-mesa-dev ffmpeg libcudnn8=8.8.1.3-1+cuda11.8 \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

# git
RUN git clone https://github.com/litagin02/Style-Bert-VITS2.git /sbv2
WORKDIR /sbv2

# requirements pytorch
RUN pip3 install torch==2.1.2 torchvision==0.16.2 torchaudio==2.1.2 --index-url https://download.pytorch.org/whl/cu118 \
    && pip3 install -r requirements.txt

# shell
COPY ./service/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
