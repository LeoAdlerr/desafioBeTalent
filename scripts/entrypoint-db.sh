#!/bin/bash
set -e

echo "--- INICIANDO ENTRYPOINT DO BANCO DE DADOS ---"

# Inicia o MySQL original em background
docker-entrypoint.sh "$@" &
MYSQL_PID=$!

echo "Aguardando disponibilidade do MySQL..."
until mysqladmin ping -h localhost -u root -p"$MYSQL_ROOT_PASSWORD" --silent; do
    echo -n "."
    sleep 1
done
echo "MySQL pronto!"

# Verificação de Existência de Dados
# Buscamos a tabela 'gateways' que é o coração do desafio
CHECK_TABLE=$(mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" -s -N -e "SELECT COUNT(*) FROM information_schema.TABLES WHERE table_schema = '$MYSQL_DATABASE' AND table_name = 'gateways';")

if [ "$CHECK_TABLE" -gt 0 ]; then
    echo "Base de dados já estruturada. Pulando inicialização."
else
    echo "Banco vazio detectado! Executando init.sql..."
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /docker-entrypoint-initdb.d/init.sql
    echo "Dados iniciais populados com sucesso."
fi

# Mantém o processo do MySQL em primeiro plano
wait $MYSQL_PID