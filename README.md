<header>
    <h1>💳 Sistema de Pagamentos Multi-Gateway</h1>
    <p>Engenharia de Software de Alta Performance | BeTalent Challenge</p>
    <div class="badge">Nível de Entrega: 2 para vaga de Júnior</div>
</header>

<section>
    <h2>👨‍💻 Perfil & Metodologia Aumentada</h2>
    <p>
        Sou <strong>Leonardo Adler</strong>, Analista de Sistemas I na Universal Armazéns Gerais. Minha atuação foca no <strong>rigor acadêmico</strong> (Mestrado em Ciência da Computação na UNIFESP e FATEC) aliado à eficiência da <strong>IA Generativa</strong> como multiplicador de produtividade.
    </p>
    <div class="methodology-box">
        <h4>🛠 Estratégia de Desenvolvimento</h4>
        <p>
            Utilizo o <strong>Google Gemini</strong> para acelerar o desenvolvimento de boilerplates e rotinas comuns. Como arquiteto, realizo o refinamento crítico, garantindo padrões <strong>S.O.L.I.D</strong>, <strong>Clean Architecture</strong> e a integridade do modelo de dados através do <strong>TypeORM</strong>.
        </p>
    </div>
</section>

<section>
    <h2>🚀 Validação Automatizada (E2E & TDD)</h2>
    <div class="e2e-box">
        <strong>Estratégia de Teste:</strong> Para garantir a integridade do desafio sem necessidade de intervenção manual, a aplicação conta com uma suíte de <strong>testes End-to-End (E2E)</strong>. Estes testes simulam caminhos críticos do usuário, validando desde o login até o failover entre gateways e reembolsos.
    </div>
    <p>A prova de conceito é executada via automação, garantindo que todos os requisitos de rotas e lógica de negócio foram atendidos rigorosamente.</p>
</section>

<section>
    <h2>📋 Requisitos do Sistema & Funcionalidades</h2>
    <div class="requirements-grid">
        <div>
            <h3>Rotas Públicas</h3>
            <ul class="req-list">
                <li>Realizar o login</li>
                <li>Realizar compra (Cálculo via Backend)</li>
            </ul>
            <h3>Rotas Privadas (Roles/RBAC)</h3>
            <ul class="req-list">
                <li>Ativar/desativar gateway</li>
                <li>Alterar prioridade de gateway</li>
                <li>CRUD de Usuários & Produtos</li>
                <li>Listagem e Detalhe de Clientes/Compras</li>
                <li>Reembolso (Chargeback) via Gateway</li>
            </ul>
        </div>
        <div>
            <h3>Requisitos Técnicos</h3>
            <ul class="req-list">
                <li>MySQL como Banco de Dados</li>
                <li>TypeORM (Fidelidade ao Modelo de Dados)</li>
                <li>Respostas padronizadas em JSON</li>
                <li>Validação rigorosa de dados (VineJS)</li>
                <li>Docker/Podman Compose (Full Stack)</li>
                <li>Gerenciador de pacotes: <strong>Yarn</strong></li>
            </ul>
        </div>
    </div>
</section>

<section>
    <h2>🏗️ Workflow de Infraestrutura</h2>
    <div class="workflow-step">
        <h5>1. Infra-First (Podman/Docker)</h5>
        <p>Ecossistema containerizado integrando Banco, API e Mocks. Ambiente 100% portável e reproduzível com um único comando.</p>
    </div>
    <div class="workflow-step">
        <h5>2. Database-First (Database Technologist Perspective)</h5>
        <p>Modelagem relacional normalizada, focada em integridade financeira e histórico de transações, servindo como a "única fonte da verdade".</p>
    </div>
    <div class="workflow-step">
        <h5>3. Application Core (AdonisJS + TypeORM)</h5>
        <p>Backend modular utilizando TypeORM para mapeamento preciso e gerenciamento de transações complexas.</p>
    </div>
</section>

<section>
    <h2>🛠️ Como Executar</h2>
    <pre><code># 1. Clonar o repositório
git clone https://github.com/LeoAdlerr/betalent-challenge.git
cd betalent-challenge

# 2. Subir o ecossistema completo (DB + App + Mocks)

podman-compose up -d

# 3. Preparar o banco e rodar a validação automática

yarn install
yarn run migrate
yarn run test # Executa os testes E2E que validam o app</code></pre>
</section>

<div class="footer-text">
    <p>Leonardo Adler | leonardoadlersilva@gmail.com</p>
    <p><i>"O banco de dados é o alicerce; o teste automatizado é a prova da sua solidez."</i></p>
</div>
