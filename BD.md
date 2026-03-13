<div class="db-container">
    <h2 class="section-title">🗄️ Arquitetura de Dados: Estratégia Database-First</h2>
    <div class="tech-note">
        <strong>Visão do Especialista:</strong> Esta modelagem foi concebida sob rigorosa observância da 3ª Forma Normal (3NF). Implementamos o conceito de <strong>Snapshots de Preço</strong> na tabela associativa para garantir a auditabilidade financeira — um requisito crítico em sistemas de pagamento onde o preço de um produto no catálogo pode oscilar sem alterar o histórico de transações já efetuadas.
    </div>

<h3> MER</h3>

```mermaid
erDiagram
    USERS {
        int id PK
        string email UK
        string password
        enum role
        timestamp created_at
        timestamp updated_at
    }

    CLIENTS {
        int id PK
        string name
        string email UK
        timestamp created_at
    }

    GATEWAYS {
        int id PK
        string name
        int priority
        boolean is_active
        string api_url
        timestamp created_at
    }

    PRODUCTS {
        int id PK
        string name
        int amount
        boolean is_active
        timestamp created_at
    }

    TRANSACTIONS {
        char(36) id PK
        int client_id FK
        int gateway_id FK
        int amount
        char(4) card_last_numbers
        enum status
        string external_id
        timestamp created_at
    }

    TRANSACTION_PRODUCTS {
        char(36) transaction_id PK, FK
        int product_id PK, FK
        int quantity
        int price_at_time
    }

    CLIENTS ||--o{ TRANSACTIONS : "faz"
    GATEWAYS ||--o{ TRANSACTIONS : "processa"
    TRANSACTIONS ||--o{ TRANSACTION_PRODUCTS : "contém"
    PRODUCTS ||--o{ TRANSACTION_PRODUCTS : "incluído em"
```
<h3 class="section-title">1. Tabela: <code>users</code></h3>
    <p>Armazena credenciais administrativas e níveis de acesso (RBAC).</p>
    <table>
        <thead>
            <tr><th>Coluna</th><th>Tipo</th><th>Restrições</th><th>Descrição</th></tr>
        </thead>
        <tbody>
            <tr><td>id</td><td>INT</td><td><span class="pk-tag">PK</span>, AUTO_INC</td><td>Identificador único do usuário.</td></tr>
            <tr><td>email</td><td>VARCHAR(255)</td><td>NOT NULL, UNIQUE</td><td>E-mail de login.</td></tr>
            <tr><td>password</td><td>VARCHAR(255)</td><td>NOT NULL</td><td>Hash da senha (BCrypt recomendado).</td></tr>
            <tr><td>role</td><td>ENUM</td><td>DEFAULT 'USER'</td><td>Papéis: ADMIN, MANAGER, FINANCE, USER.</td></tr>
            <tr><td>created_at</td><td>TIMESTAMP</td><td>CURRENT_TIMESTAMP</td><td>Data de criação do registro.</td></tr>
        </tbody>
    </table>
    <h3 class="section-title">2. Tabela: <code>gateways</code></h3>
    <p>Configuração dinâmica para o motor de failover.</p>
    <table>
        <thead>
            <tr><th>Coluna</th><th>Tipo</th><th>Restrições</th><th>Descrição</th></tr>
        </thead>
        <tbody>
            <tr><td>id</td><td>INT</td><td><span class="pk-tag">PK</span></td><td>Identificador do gateway.</td></tr>
            <tr><td>name</td><td>VARCHAR(100)</td><td>NOT NULL</td><td>Nome ex: 'Gateway 1', 'PagSeguro'.</td></tr>
            <tr><td>priority</td><td>INT</td><td>NOT NULL</td><td>Ordem de tentativa (menor valor = maior prioridade).</td></tr>
            <tr><td>is_active</td><td>BOOLEAN</td><td>DEFAULT TRUE</td><td>Flag de disponibilidade no motor de busca.</td></tr>
            <tr><td>api_url</td><td>VARCHAR(255)</td><td>NOT NULL</td><td>Endpoint base da API do gateway.</td></tr>
        </tbody>
    </table>
    <h3 class="section-title">3. Tabela: <code>transactions</code></h3>
    <p>Registro mestre de cada intenção de compra processada.</p>
    <table>
        <thead>
            <tr><th>Coluna</th><th>Tipo</th><th>Restrições</th><th>Descrição</th></tr>
        </thead>
        <tbody>
            <tr><td>id</td><td>CHAR(36)</td><td><span class="pk-tag">PK</span></td><td>UUID v4 para evitar <i>ID Enumeration attacks</i>.</td></tr>
            <tr><td>client_id</td><td>INT</td><td><span class="fk-tag">FK</span></td><td>Relacionamento com a tabela <code>clients</code>.</td></tr>
            <tr><td>gateway_id</td><td>INT</td><td><span class="fk-tag">FK</span>, NULLABLE</td><td>Gateway que processou o sucesso.</td></tr>
            <tr><td>amount</td><td>INT</td><td>NOT NULL</td><td>Valor total em centavos (Inteiro).</td></tr>
            <tr><td>status</td><td>ENUM</td><td>DEFAULT 'pending'</td><td>Status: pending, paid, refunded, failed.</td></tr>
            <tr><td>external_id</td><td>VARCHAR(255)</td><td>NULLABLE</td><td>ID retornado pelo sistema de terceiro.</td></tr>
        </tbody>
    </table>
    <h3 class="section-title">4. Tabela Associativa: <code>transaction_products</code></h3>
    <p>Detalhamento dos itens da compra (Suporte a Nível 3).</p>
    <table>
        <thead>
            <tr><th>Coluna</th><th>Tipo</th><th>Restrições</th><th>Descrição</th></tr>
        </thead>
        <tbody>
            <tr><td>transaction_id</td><td>CHAR(36)</td><td><span class="pk-tag">PK</span>, <span class="fk-tag">FK</span></td><td>Vínculo com a transação pai.</td></tr>
            <tr><td>product_id</td><td>INT</td><td><span class="pk-tag">PK</span>, <span class="fk-tag">FK</span></td><td>Vínculo com o catálogo.</td></tr>
            <tr><td>quantity</td><td>INT</td><td>NOT NULL</td><td>Quantidade comprada do SKU.</td></tr>
            <tr><td>price_at_time</td><td>INT</td><td>NOT NULL</td><td>Preço unitário no exato momento da venda.</td></tr>
        </tbody>
    </table>
</div>
