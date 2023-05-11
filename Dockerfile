# 使用基于yum的Python镜像作为基础镜像
FROM python:3.10

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 安装项目依赖
RUN python3 -m pip install --user pipx
RUN python -m pipx ensurepath
RUN pipx install nb-cli
RUN pip install --no-cache-dir -r requirements.txt

# 暴露项目的端口（如果有需要）
EXPOSE 8888

# 定义启动命令
CMD ["nb", "run"]
