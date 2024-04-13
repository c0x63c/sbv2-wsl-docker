### Description
* Style-Bert-VITS2のWSL2向けdocker compose(GPU対応)です.
* 特徴としては,volumes配下のフォルダはdocker内でシンボリックリンクとして扱われる為,ローカルのファイルをdocker内にいちいちコピーする必要はありません.
* shellにより,WEB-UIとエディタとAPIの起動を切り替えられます.

### Prerequisites

* Windows 11(64GB)
* NVidia video card (RTX3060 12GB)
* WSL2 (32GB and operation confirmed on Ubuntu 20.04)

*上記以外の構成では未確認.

### Installing

* 以下のコマンドでDockerをビルド.
```
chmod +x ./shell/*
docker compose build
```

## Usage

* Installing実行後に以下を実行.
```
#WEB-UIを使用して起動したい場合...
./shell/web-ui.sh
#docker compose 起動シェル後に以下にアクセス.
http://localhost:7860

#エディタを使用して起動したい場合...
./shell/editor.sh
#docker compose 起動シェル後に以下にアクセス.
http://localhost:3000

#APIを使用して起動したい場合...
./shell/fastapi.sh
#docker compose 起動シェル後に以下にアクセス.
http://localhost:5000
```

* ディレクトリ概要.
```
#もし初期化処理を実行したいのであればこれを削除 → [check].
volumes/Data
        └── check #実行時に起動するshellの初期化処理で作成されます.

#音声合成に必要なモデルファイルたちの構造は以下の通りです.
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

* 2024/04/13 fix:editor起動時のブラウザ起動オプションを削除, dockerfileの名称を変更

## Acknowledgments

* [Style-Bert-VITS2](https://github.com/litagin02/Style-Bert-VITS2)
* [Style-Bert-VITS2-Editor](https://github.com/litagin02/Style-Bert-VITS2-Editor)
* [nVidia 525 + Cuda 11.8 + Python 3.10 + pyTorch GPU Docker image](https://dev.to/ordigital/nvidia-525-cuda-118-python-310-pytorch-gpu-docker-image-1l4a)
* [stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) 