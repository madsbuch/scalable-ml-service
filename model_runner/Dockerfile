FROM python:3


ADD / /
RUN pip install torch==1.8.1+cpu torchvision==0.9.1+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install pika numpy matplotlib
CMD [ "python", "./model_runner.py" ]
