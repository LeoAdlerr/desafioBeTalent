<header>
    <h1>💳 Sistema de Pagamentos Multi-Gateway</h1>
    <p>Engenharia de Software de Alta Performance | BeTalent Challenge</p>
    <div class="badge">Nível de Entrega: 2.5 (Híbrido Pleno)</div>
</header>

<section>
    <h2>👨‍💻 Perfil & Engenharia Aumentada por IA</h2>
    <p>
        Sou <strong>Leonardo Adler</strong>, Analista de Sistemas I na Universal Armazéns Gerais. Minha atuação une o <strong>rigor acadêmico</strong> (Mestrado em Ciência da Computação na UNIFESP e Formação em Banco de Dados na FATEC) à eficiência da <strong>IA Generativa</strong>.
    </p>
    <div class="methodology-box">
        <h4>🛠 Metodologia de Desenvolvimento</h4>
        <p>
            Utilizo o <strong>Google Gemini</strong> como multiplicador de produtividade, atuando como <strong>Arquiteto e Revisor Crítico</strong>. A IA acelera o "trabalho de pedreiro" (boilerplates e rotinas), enquanto meu foco recai sobre a integridade do modelo, padrões <strong>S.O.L.I.D</strong> e <strong>Clean Architecture</strong>.
        </p>
    </div>
</section>

<section>
    <h2>🏗️ Workflow de Execução do Projeto</h2>
    <p>O desenvolvimento segue uma ordem rigorosa para garantir paridade de ambiente e fidelidade de dados:</p>
    <div class="workflow-step">
        <h5>1. Infraestrutura First (Podman/Docker)</h5>
        <p>Configuração do ecossistema via <code>podman-compose</code>, garantindo que o banco MySQL, a aplicação Node.js e os mocks dos Gateways coexistam em rede isolada. Toda a infra é 100% traduzível para Docker Desktop ao final do processo.</p>
    </div>
    <div class="workflow-step">
        <h5>2. Modelagem Database-First</h5>
        <p>Como Tecnólogo em Banco de Dados, a modelagem é o coração da solução. A estrutura de dados foi desenhada para o <strong>Nível 2</strong>, priorizando integridade referencial e performance antes da escrita de qualquer linha de lógica de negócio.</p>
    </div>
    <div class="workflow-step">
        <h5>3. Construção do App (AdonisJS + TypeORM)</h5>
        <p>Implementação seguindo o padrão MVC, mas com uma escolha técnica específica: o uso de <strong>TypeORM</strong> em vez do Lucid. Esta escolha visa a maior fidelidade possível ao modelo de dados através de um Data Mapper robusto, facilitando o gerenciamento de transações financeiras.</p>
    </div>
</section>

<section>
    <h2>🎯 Estratégia do Desafio</h2>
    <div class="grid">
        <div class="level-card active">
            <h4>Nível 2 (Base)</h4>
            <p><strong>Implementado:</strong> Cálculo de valor no Backend, Gateways com autenticação e modelagem relacional completa.</p>
        </div>
        <div class="level-card">
            <h4>Diferenciais Nível 3</h4>
            <p><span class="highlight">Bônus:</span> Implementação de <strong>TDD</strong>, ambiente containerizado completo e lógica de <strong>Roles (RBAC)</strong> integrada ao processo de checkout.</p>
        </div>
    </div>
</section>

<section>
    <h2>🛠️ Stack Técnica</h2>
    <ul>
        <li><strong>Framework:</strong> AdonisJS 6 (Node.js)</li>
        <li><strong>ORM:</strong> TypeORM (Preferência técnica para fidelidade ao modelo de dados)</li>
        <li><strong>Banco de Dados:</strong> MySQL 8.0</li>
        <li><strong>Containerização:</strong> Podman (Desenvolvimento) / Docker (Entrega final)</li>
    </ul>

    <h3>Como subir o ambiente</h3>
    <pre><code># Clonar repositório
git clone <https://github.com/LeoAdlerr/betalent-challenge.git>

# Subir toda a infra (DB + App + Mocks)

podman-compose up -d

# Acompanhar logs

podman-compose logs -f</code></pre>
</section>

<div class="footer-text">
    <p>Leonardo Adler | leonardoadlersilva@gmail.com</p>
    <p><i>"O banco de dados é o alicerce; o código é apenas o reflexo da sua integridade."</i></p>
</div>
