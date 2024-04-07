### Prerequisites

* Windows 11(64GB)
* NVidia video card (RTX3060 12GB)
* WSL2 (32GB and operation confirmed on Ubuntu 20.04)

*Not confirmed in other configurations than those listed above.

### Installing

* Build Docker with the following command
```
chmod +x ./shell/*
docker compose build
```

## Usage

* Access the following after docker compose start shell
```
#If you want to start web-ui...
./shell/webui_start.sh
#Access the following after starting the process
http://localhost:7860

#If you want to start api-server...
./shell/server_start.sh
#Access the following after starting the process
http://localhost:3000
```

* Directory description
#If you need reinitialize then delete → [check].
```
volumes/Data
        └── check #make it when initialize.
```
#The structure of the model files required for voice 
```
volumes/model_assets
    ├── your_model
    │   ├── config.json
    │   ├── your_model_file1.safetensors
    │   ├── your_model_file2.safetensors
    │   ├── ...
    │   └── style_vectors.npy
    └── another_model
        ├── ...
```

## Version

* 2024/04/07 fix:Added libcudnn8,replaced local_dir_use_symlinks,added pretrain

## Acknowledgments

* [Style-Bert-VITS2](https://github.com/litagin02/Style-Bert-VITS2)
* [Style-Bert-VITS2-Editor](https://github.com/litagin02/Style-Bert-VITS2-Editor)
* [nVidia 525 + Cuda 11.8 + Python 3.10 + pyTorch GPU Docker image](https://dev.to/ordigital/nvidia-525-cuda-118-python-310-pytorch-gpu-docker-image-1l4a)
* [stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) 