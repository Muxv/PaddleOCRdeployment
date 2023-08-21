# PaddleOCRdeployment
Docker deployment of PaddleOCR of OCRv4

English | [简体中文](README_cn.md)

## How to use  


```bash

chmod a+x download_ckpt.sh   

bash download_ckpt.sh   #  Download the models at first

docker build -t paddleocr:gpu .

sudo docker run -dp 8868:8868 --gpus all --name paddle_ocr paddleocr:gpu

docker logs -f paddle_ocr

# if ok
# [2023-**-** **:**:**,***] [    INFO] - Successfully installed ocr_system-1.0.0

```

## How to evaluate
- See [sample](sample_requests.txt)

```bash
curl -H "Content-Type:application/json" -X POST --data "{\"images\": [\"Image Base64(delete 'data:image/jpg;base64,'）\"]}" http://localhost:8868/predict/ocr_system

```
- If Succeed

`{"msg":"","results":[[{"confidence":0.8403433561325073,"text":"约定","text_region":[[345,377],[641,390],[634,540],[339,528]]},{"confidence":0.8131805658340454,"text":"最终相遇","text_region":[[356,532],[624,530],[624,596],[356,598]]}]],"status":"0"}`




## How to shut up

```bash

docker stop paddle_ocr && docker rm paddle_ocr

docker image rm paddleocr:gpu
```


