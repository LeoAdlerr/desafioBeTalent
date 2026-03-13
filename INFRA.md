<div class="infra-doc">
    <h2>🏗️ Decisões de Infraestrutura e Containerização</h2>
    <p class="context-note">
        Esta seção detalha a estratégia de ambiente utilizada para garantir que o sistema seja resiliente, portável e idêntico em qualquer host (Podman ou Docker).
    </p>
    <div class="decision-card">
        <h4>1. Escolha da Imagem Base: <span class="tag-tech">node:20-slim</span></h4>
        <p>
            Diferente de imagens baseadas em <i>Alpine</i>, a variante <strong>Slim (Debian)</strong> foi selecionada por oferecer um equilíbrio ideal entre tamanho de imagem e estabilidade.
        </p>
        <ul>
            <li><strong>Motivo:</strong> Prevenção de erros de <i>Shared Libraries</i> (libc) comuns em drivers de banco de dados e ferramentas de automação (como Puppeteer ou compiladores nativos).</li>
            <li><strong>Impacto:</strong> <span class="impact-positive">Zero downtime em debug de ambiente</span>, garantindo que todas as dependências do TypeORM e AdonisJS funcionem "out-of-the-box".</li>
        </ul>
    </div>
    <div class="decision-card">
        <h4>2. Gerenciamento de Dependências: <span class="tag-tech">Yarn</span></h4>
        <p>
            Utilizamos o <strong>Yarn</strong> com a flag <code>--frozen-lockfile</code> para o processo de build.
        </p>
        <ul>
            <li><strong>Motivo:</strong> Maior velocidade no processo de instalação através de caching eficiente e garantia de determinismo (instalação da versão exata contida no lockfile).</li>
        </ul>
    </div>
    <div class="decision-card">
        <h4>3. Estratégia de Layering (Otimização de Build)</h4>
        <p>
            O <code>Containerfile</code> foi estruturado para copiar o <code>package.json</code> e o <code>yarn.lock</code> <strong>antes</strong> do restante do código-fonte.
        </p>
        <ul>
            <li><strong>Motivo:</strong> Aproveitamento do cache de camadas do motor de containers. Se não houver mudança de dependências, o container não refaz o download dos pacotes, acelerando o ciclo de desenvolvimento e deploy.</li>
        </ul>
    </div>
    <div class="decision-card">
        <h4>4. Compatibilidade e Entrypoint</h4>
        <p>
            Implementação do utilitário <span class="tag-tech">dos2unix</span> no processo de build.
        </p>
        <ul>
            <li><strong>Motivo:</strong> Garantir que scripts de inicialização (<code>.sh</code>) funcionem perfeitamente mesmo que o código tenha sido baixado em ambiente Windows (ajuste automático de CRLF para LF).</li>
            <li><strong>Entrypoint:</strong> O uso de um script de entrada permite orquestrar a saúde do banco de dados antes da subida da API.</li>
        </ul>
    </div>
    <div class="decision-card">
        <h4>5. Portabilidade <span class="tag-tech">Podman-to-Docker</span></h4>
        <p>
            Toda a infraestrutura foi desenvolvida em <strong>Podman</strong>, mas configurada com sintaxe 100% compatível com <strong>Docker Compose</strong>.
        </p>
        <ul>
            <li><strong>Motivo:</strong> Flexibilidade total para o avaliador, permitindo o uso de <code>podman-compose</code> ou <code>docker-compose</code> sem necessidade de refatoração de rede ou volumes.</li>
        </ul>
    </div>
</div>

<section class="decision-card">
    <h4>⚙️ Orquestração de Inicialização (Entrypoints)</h4>
    <p>
        Para garantir que a aplicação seja "autolimpante" e resiliente, implementamos scripts de <strong>Entrypoint</strong> que gerenciam o ciclo de vida dos containers:
    </p>
    <ul>
        <li>
            <strong>entrypoint-app.sh:</strong> 
            Implementa o <i>Fail-Fast</i>. A API não inicia se os testes unitários/integração falharem ou se o banco de dados estiver inacessível. Garante que o <strong>TypeORM</strong> esteja em sincronia com o schema MySQL antes do tráfego de rede ser liberado.
        </li>
        <li>
            <strong>entrypoint-db.sh:</strong> 
            Realiza o <i>Bootstrap</i> inteligente dos dados. Verifica a existência da tabela <code>gateways</code>; caso ausente, popula o banco com as configurações de prioridade e produtos necessárias para o Nível 2.
        </li>
        <li>
            <strong>wait-for-it.sh:</strong> 
            Utilitário de sincronização TCP que previne erros de conexão durante o <i>cold start</i> do ecossistema de containers.
        </li>
    </ul>
    <p class="impact-positive">
        Resultado: Um ambiente 100% autônomo onde um <code>podman-compose up</code> entrega um sistema validado e pronto para uso.
    </p>
</section>
<section class="decision-card">
    <h4>🎼 Orquestração de Microserviços (Docker Compose)</h4>
    <p>
        O arquivo <code>docker-compose.yml</code> atua como o manifesto de infraestrutura, garantindo que o ecossistema BeTalent seja reproduzível e isolado.
    </p>
    <ul>
        <li><strong>Rede Isolada (Bridge):</strong> Todos os containers residem na <code>betalent-net</code>, permitindo que a API acesse o banco via hostname <code>db</code> e os gateways via <code>gateways_mock</code>, eliminando IPs "hardcoded".</li>
        <li><strong>Gerenciamento de Dependências:</strong> Utilizamos <code>depends_on</code> com condições de saúde para garantir que a API só tente realizar o boot após o banco e os mocks estarem operacionais.</li>
        <li><strong>Persistência de Dados:</strong> O volume nomeado <code>db_data</code> assegura que as transações e clientes cadastrados não sejam perdidos entre reinicializações dos containers.</li>
        <li><strong>Ambiente de Desenvolvimento Ativo:</strong> O mapeamento de volumes no serviço <code>app</code> permite o <i>Hot Reloading</i>; qualquer alteração no código fonte é refletida instantaneamente sem necessidade de novo build da imagem.</li>
    </ul>
</section>

<section class="decision-card" style="border-left-color: #e67e22;">
    <h4>🔄 Pivot de Engenharia: Inicialização do Banco</h4>
    <p>
        <strong>Problema Identificado:</strong> O uso de <i>Entrypoints</i> customizados em background no MySQL 8.0 gera condições de corrida (Race Conditions) pelo arquivo de lock do socket unix durante o estágio de <code>Temporary Server</code>.
    </p>
    <ul>
        <li><strong>Decisão:</strong> Substituição do script <code>entrypoint-db.sh</code> pelo mecanismo nativo <code>/docker-entrypoint-initdb.d/</code> da imagem oficial.</li>
        <li><strong>Vantagem:</strong> Maior confiabilidade no processo de <i>bootstrap</i> dos dados e conformidade com o comportamento padrão da imagem oficial, garantindo que o DDL/DML seja executado apenas uma única vez na criação do volume.</li>
        <li><strong>Validação:</strong> A integridade é garantida pela orquestração do <code>wait-for-it.sh</code> no lado do Backend, que aguarda a disponibilidade real da porta 3306 antes de iniciar a aplicação.</li>
    </ul>
</section>
<section class="decision-card">
    <h4>📦 Gestão de Scripts e Ciclo de Vida</h4>
    <p>
        O <code>package.json</code> foi configurado para unificar o fluxo de trabalho entre o ambiente local e o containerizado.
    </p>
    <ul>
        <li><strong>start:dev:</strong> Atalho customizado para o <code>node ace serve --watch</code>, permitindo que o desenvolvedor utilize um comando padronizado enquanto o AdonisJS Assembler monitora alterações nos arquivos.</li>
        <li><strong>TypeORM CLI:</strong> Configurado para rodar via <code>node --loader ts-node/esm</code>, garantindo compatibilidade com os módulos ECMAScript (ESM) nativos do AdonisJS 6.</li>
        <li><strong>Fidelidade de Versões:</strong> O uso do Yarn garante que a árvore de dependências seja idêntica em todas as instâncias da <i>Podman Machine</i>.</li>
    </ul>
</section>