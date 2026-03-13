# ############################################################
# IMAGEM BASE: Node.js 20-slim
# Escolhida para garantir compatibilidade com dependências 
# nativas e evitar erros de bibliotecas ausentes em runtime.
# ############################################################
FROM node:20-slim

# ESTÁGIO 1: INSTALAÇÃO DE DEPENDÊNCIAS DO SISTEMA
# Instalamos pacotes essenciais para compilação e utilitários de rede/shell.
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    procps \
    make \
    g++ \
    python3 \
    dos2unix \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho padrão dentro do container.
WORKDIR /home/node/app

# PASSO 1: Copia apenas os manifestos de dependências para otimizar o cache de camadas.
COPY package.json yarn.lock* ./

# PASSO 2: Instalação das dependências via Yarn.
# Usamos --frozen-lockfile para garantir que as versões sejam idênticas ao ambiente local.
RUN yarn install --frozen-lockfile

# PASSO 3: Copia o restante do código-fonte para o container.
COPY . .

# PASSO 4: Ajuste de scripts de entrada.
# O dos2unix previne erros de caractere de fim de linha se o dev estiver em Windows.
RUN dos2unix ./entrypoint.sh && \
    chmod +x ./entrypoint.sh

# Expõe a porta padrão do AdonisJS.
EXPOSE 3333

# O Entrypoint orquestra o wait-for-it do banco e o início do serviço.
ENTRYPOINT ["./entrypoint.sh"]