# 使用基于yum的Python镜像作为基础镜像
FROM python:3.10

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 安装项目依赖
RUN python3 -m pip install --user pipx
RUN python -m pipx ensurepath


# 创建一个新的脚本文件
RUN echo '#!/bin/bash\npython -m pipx ensurepath\npipx install nb-cli' > setup.sh

# 赋予脚本文件执行权限
RUN chmod +x setup.sh

# 在容器启动时运行脚本文件
CMD ["./setup.sh"]

RUN pip install --no-cache-dir -r requirements.txt

# 暴露项目的端口（如果有需要）
EXPOSE 8888

# 定义启动命令
CMD ["nb", "run"]
