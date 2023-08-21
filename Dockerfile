# Version: 2.0.0
FROM registry.baidubce.com/paddlepaddle/paddle:2.4.2-gpu-cuda11.2-cudnn8.2-trt8.0

RUN pip install --upgrade pip -i https://mirror.baidu.com/pypi/simple

RUN pip install paddlehub==2.3.1 -i https://mirror.baidu.com/pypi/simple

RUN pip install paddleocr -i https://mirror.baidu.com/pypi/simple

# Default 2.6.0 not work
RUN pip install paddlenlp==2.5.2 -i https://mirror.baidu.com/pypi/simple

# Or git clone and copy
# COPY PaddleOCR /PaddleOCR 

RUN git clone https://github.com/PaddlePaddle/PaddleOCR.git /PaddleOCR

WORKDIR /PaddleOCR

# Use custom ocr_system
COPY ocr_system /PaddleOCR/deploy/hubserving/ocr_system



RUN mkdir -p /OCR_SYSTEM/inference/
# Download orc detect model(light version). if you want to change normal version, you can change ch_ppocr_mobile_v2.0_det_infer to ch_ppocr_server_v2.0_det_infer, also remember change det_model_dir in deploy/hubserving/ocr_system/params.py）
# ADD https://paddleocr.bj.bcebos.com/PP-OCRv4/chinese/ch_PP-OCRv4_det_server_infer.tar /PaddleOCR/inference/
COPY ckpt/ch_PP-OCRv4_det_server_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_PP-OCRv4_det_server_infer.tar -C /PaddleOCR/inference/

# Download direction classifier(light version). If you want to change normal version, you can change ch_ppocr_mobile_v2.0_cls_infer to ch_ppocr_mobile_v2.0_cls_infer, also remember change cls_model_dir in deploy/hubserving/ocr_system/params.py）
# ADD https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_mobile_v2.0_cls_slim_infer.tar  /PaddleOCR/inference/
COPY ckpt/ch_ppocr_mobile_v2.0_cls_slim_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_ppocr_mobile_v2.0_cls_slim_infer.tar -C /PaddleOCR/inference/

# Download orc recognition model(light version). If you want to change normal version, you can change ch_ppocr_mobile_v2.0_rec_infer to ch_ppocr_server_v2.0_rec_infer, also remember change rec_model_dir in deploy/hubserving/ocr_system/params.py）
# ADD https://paddleocr.bj.bcebos.com/PP-OCRv4/chinese/ch_PP-OCRv4_rec_server_infer.tar /PaddleOCR/inference/
COPY ckpt/ch_PP-OCRv4_rec_server_infer.tar /PaddleOCR/inference/
RUN tar xf /PaddleOCR/inference/ch_PP-OCRv4_rec_server_infer.tar -C /PaddleOCR/inference/

EXPOSE 8868

ENV CUDA_VISIBLE_DEVICES=0

CMD ["/bin/bash","-c","hub install deploy/hubserving/ocr_system/ && hub serving start -m ocr_system -c deploy/hubserving/ocr_system/config.json"]