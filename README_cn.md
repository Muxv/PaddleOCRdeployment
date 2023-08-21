# PaddleOCRdeployment
OCRv4 版本的PaddleOCR 部署方案

[English](README.md) | 简体中文

## 如何使用


```bash

chmod a+x download_ckpt.sh   

bash download_ckpt.sh # 提前下载好需要的模型

docker build -t paddleocr:gpu .   # build

sudo docker run -dp 8868:8868 --gpus all --name paddle_ocr paddleocr:gpu

docker logs -f paddle_ocr

# if ok
# [2023-**-** **:**:**,***] [    INFO] - Successfully installed ocr_system-1.0.0

```

## 如何使用服务

- 参考 [sample](sample_requests.txt)
```bash
curl -H "Content-Type:application/json" -X POST --data "{\"images\": [\"填入图片Base64编码(delete 'data:image/jpg;base64,'）\"]}" http://localhost:8868/predict/ocr_system

```
- 如果成功

`{"msg":"","results":[[{"confidence":0.8403433561325073,"text":"约定","text_region":[[345,377],[641,390],[634,540],[339,528]]},{"confidence":0.8131805658340454,"text":"最终相遇","text_region":[[356,532],[624,530],[624,596],[356,598]]}]],"status":"0"}`



## 如何关闭

```bash

docker stop paddle_ocr && docker rm paddle_ocr && docker image rm paddleocr:gpu
```

