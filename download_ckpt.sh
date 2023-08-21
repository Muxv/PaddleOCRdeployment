#!/bin/bash

mkdir -p ckpt

download_and_extract() {
  file_url=$1
  file_path=$2
  if [ ! -f $file_path ]; then
    wget $file_url -O $file_path
  else
    echo "File $file_path already exists. Skipping download."
  fi
}

download_and_extract "https://paddleocr.bj.bcebos.com/PP-OCRv4/chinese/ch_PP-OCRv4_det_server_infer.tar" "./ckpt/ch_PP-OCRv4_det_server_infer.tar"
download_and_extract "https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_mobile_v2.0_cls_slim_infer.tar" "./ckpt/ch_ppocr_mobile_v2.0_cls_slim_infer.tar"
download_and_extract "https://paddleocr.bj.bcebos.com/PP-OCRv4/chinese/ch_PP-OCRv4_rec_server_infer.tar" "./ckpt/ch_PP-OCRv4_rec_server_infer.tar"