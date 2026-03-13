#!/bin/sh
set -e

echo "--- INICIANDO ENTRYPOINT DO BACKEND (BeTalent) ---"

# 1. Aguardar o Banco de Dados
DB_HOST=${DB_HOST:-db}
echo " Aguardando MySQL em ${DB_HOST}:3306..."
./wait-for-it.sh ${DB_HOST}:3306 --timeout=60 --strict -- echo "MySQL está online!"

# 2. Sincronização do Banco de Dados (TypeORM)
# aqui garantimos que o schema do TypeORM reflita o banco
echo "Sincronizando Schema via TypeORM..."
yarn typeorm schema:sync 

# 3. Pipeline de Qualidade (TDD)
echo "🧪 Executando Suíte de Testes (Integridade do Sistema)..."
yarn test
echo "Todos os testes passaram!"

# 4. Inicialização do Servidor
if [ "$NODE_ENV" = "production" ]; then
    echo "Modo Produção: Compilando e iniciando..."
    yarn build
    exec node build/server.js
else
    echo "Modo Desenvolvimento: Iniciando AdonisJS..."
    exec node ace serve --watch
fi