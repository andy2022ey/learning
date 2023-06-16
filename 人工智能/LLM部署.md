# baichuan-7B

1. 下载模型文件
cd /root/project
git lfs install
git clone https://huggingface.co/baichuan-inc/baichuan-7B
总大小为14G,下载解压后约27G，下载时间取决于下载网速。100M带宽下约10分钟

2. 使用python代码执行推理测试
```python
from transformers import AutoModelForCausalLM, AutoTokenizer
#./baichuan-7B 此为上一个步骤通过git clone下来的模型文件所在目录
tokenizer = AutoTokenizer.from_pretrained("./baichuan-7B", trust_remote_code=True)
model = AutoModelForCausalLM.from_pretrained("./baichuan-7B", device_map="auto", trust_remote_code=True)
inputs = tokenizer('登鹳雀楼->王之涣\n夜雨寄北->', return_tensors='pt')
#cuda:0 代表使用第一张显卡，可以根据实际情况改为其他显卡编号
inputs = inputs.to('cuda:0')
pred = model.generate(**inputs, max_new_tokens=64)
print(tokenizer.decode(pred.cpu()[0], skip_special_tokens=True))
```

创建测试环境并验证推理代码：
```python 
# 确保test.py和baichuan-7B文件在/root/project目录下
cd /root/project
# 创建一个新的python环境
conda create -n baichuan python=3.10
# 切换到创建好的python环境
conda activate baichuan
# 安装依赖包
pip install torch
pip install transformers
pip install sentencepiece
pip install accelerate
# 执行测试代码
python test.py
```

3. 使用text generation webui启动网页版推理测试（待完善）
运行以下命令克隆text-generation-webui并按要求安装必要的依赖
```bash
# 如果服务器无法访问github.com可以使用kgithub.com替换github.com，其余地址不变
git clone https://github.com/oobabooga/text-generation-webui
cd text-generation-webui
pip install -r requirements.txt
```
4. 提供API方式部署
当前百川发布的版本还只是一个基础训练的版本，并没有做sft训练，无法实现问答效果。等待其开源后再尝试.
```python
from fastapi import FastAPI, Request
from transformers import AutoModelForCausalLM, AutoTokenizer
import uvicorn, json, datetime
import torch
from sse_starlette.sse import EventSourceResponse

DEVICE = "cuda"
DEVICE_ID = "0"
CUDA_DEVICE = f"{DEVICE}:{DEVICE_ID}" if DEVICE_ID else DEVICE


def torch_gc():
    if torch.cuda.is_available():
        with torch.cuda.device(CUDA_DEVICE):
            torch.cuda.empty_cache()
            torch.cuda.ipc_collect()


app = FastAPI()


@app.post("/")
async def create_item(request: Request):
    global model, tokenizer
    json_post_raw = await request.json()
    json_post = json.dumps(json_post_raw)
    json_post_list = json.loads(json_post)
    prompt = json_post_list.get('prompt')
    history = json_post_list.get('history')
    max_length = json_post_list.get('max_length')
    top_p = json_post_list.get('top_p')
    temperature = json_post_list.get('temperature')
    now = datetime.datetime.now()
    time = now.strftime("%Y-%m-%d %H:%M:%S")
    print("[" + time + "]" + "接收到请求:" + prompt)
    inputs = tokenizer(prompt, return_tensors='pt')
    inputs = inputs.to('cuda')
    pred = model.generate(**inputs, max_new_tokens=200, do_sample=True, top_k=3, top_p=0.9, temperature=0.8,
                          repetition_penalty=1.1, length_penalty=1.1)
    response = tokenizer.decode(pred.cpu()[0], skip_special_tokens=True)

    now = datetime.datetime.now()
    time = now.strftime("%Y-%m-%d %H:%M:%S")
    answer = {
        "response": response,
        "history": history,
        "status": 200,
        "time": time
    }
    log = "[" + time + "] " + '"prompt:"' + prompt + '", response:"' + repr(response) + '"'
    print(log)
    torch_gc()
    return answer



if __name__ == '__main__':
     # ./baichuan-7B 此为上一个步骤通过git clone下来的模型文件所在目录
    tokenizer = AutoTokenizer.from_pretrained("../baichuan-7B", trust_remote_code=True)
    model = AutoModelForCausalLM.from_pretrained("../baichuan-7B", device_map="auto", trust_remote_code=True)
    uvicorn.run(app, host='0.0.0.0', port=8000, workers=1)
```

5. 基于私有数据本地训练(待完善)
