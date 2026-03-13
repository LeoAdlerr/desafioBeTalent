<section class="decision-card">
    <h4>🏗️ Camada de Persistência: Integração TypeORM</h4>
    <p>
        Embora o AdonisJS possua o Lucid como ORM padrão, optamos pela implementação do <strong>TypeORM</strong> para sustentar nossa estratégia <i>Database-First</i>.
    </p>
    <div class="tech-note" style="background: #fff5f5; border-left-color: #e74c3c;">
        <strong>Justificativa Técnica:</strong> O TypeORM, seguindo o padrão <i>Data Mapper</i>, permite um desacoplamento maior entre a lógica de negócio e o esquema do banco de dados. Como Tecnólogo em BD, esta escolha garante que a aplicação respeite integralmente a integridade referencial definida no DDL, sem "efeitos colaterais" de automações do ORM.
    </div>
    <ul>
        <li><strong>Sincronização Desativada:</strong> A flag <code>synchronize: false</code> é mandatória para garantir que o banco de dados seja a única fonte da verdade (Single Source of Truth).</li>
        <li><strong>Reflect-Metadata:</strong> Utilizado para habilitar o suporte a Decorators do TypeScript, garantindo um código limpo e tipagem forte.</li>
    </ul>
</section>
<section class="decision-card">
    <h4>🏛️ Arquitetura do Projeto (MVC + Clean Layering)</h4>
    <p>
        A organização do código foi planejada para garantir alta coesão e baixo acoplamento, facilitando a testabilidade (TDD) e a manutenção.
    </p>
    <table>
        <thead>
            <tr>
                <th>Diretório</th>
                <th>Responsabilidade</th>
                <th>Padrão / Ferramenta</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>app/entities/</code></td>
                <td>Mapeamento objeto-relacional fiel ao banco de dados.</td>
                <td>TypeORM (Data Mapper)</td>
            </tr>
            <tr>
                <td><code>app/controllers/</code></td>
                <td>Orquestração de requisições e respostas HTTP.</td>
                <td>MVC (Controller)</td>
            </tr>
            <tr>
                <td><code>app/services/</code></td>
                <td>Regras de negócio, cálculos e lógica de failover.</td>
                <td>Service Layer</td>
            </tr>
            <tr>
                <td><code>app/validators/</code></td>
                <td>Sanitização e validação rigorosa de dados.</td>
                <td>VineJS</td>
            </tr>
            <tr>
                <td><code>app/contracts/</code></td>
                <td>Contratos (Interfaces) para Gateways de pagamento.</td>
                <td>SOLID (ISP/DIP)</td>
            </tr>
        </tbody>
    </table>
    <div class="tech-note" style="background: #fdf6e3; border-left-color: #b58900;">
        <strong>Nota de Design:</strong> Ao separar <i>Services</i> de <i>Controllers</i>, garantimos que a lógica de pagamento possa ser testada isoladamente (Unit Tests) sem depender do ciclo de vida do HTTP.
    </div>
</section>
<section class="decision-card">
    <h4>💾 Mapeamento de Entidade: Gateway</h4>
    <p>
        A entidade <code>Gateway</code> é o pilar do sistema de failover.
    </p>
    <ul>
        <li><strong>Campos Mapeados:</strong> Reflete as colunas do DDL, incluindo a <code>priority</code> que determina a ordem de execução do pagamento.</li>
        <li><strong>Decorators:</strong> Utilizamos <code>@Entity</code> e <code>@Column</code> para vincular a classe TypeScript ao schema MySQL sem redundância de código.</li>
    </ul>
</section>
<section class="decision-card">
    <h4>🚀 Ponto de Entrada: bin/server.ts</h4>
    <p>
        O arquivo <code>server.ts</code> atua como o motor de inicialização do ecossistema AdonisJS, utilizando a classe <code>Ignitor</code>.
    </p>
    <ul>
        <li><strong>Ignitor Pattern:</strong> Diferente de inicializações manuais, o Ignitor gerencia o carregamento assíncrono de todos os <i>Service Providers</i>, garantindo que o TypeORM (futuramente integrado via Provider) e as rotas estejam disponíveis antes da abertura da porta TCP.</li>
        <li><strong>Tratamento de Erros:</strong> Implementa o <code>prettyPrintError</code> em ambiente de desenvolvimento, facilitando o troubleshooting durante o processo de build no container.</li>
        <li><strong>ESM Native:</strong> Totalmente compatível com os módulos ECMAScript, aproveitando o desempenho e os padrões modernos do Node.js 20+.</li>
    </ul>
    <div class="tech-note" style="background: #e1f5fe; border-left-color: #0288d1;">
        <strong>Conceito de Engenharia:</strong> Este arquivo separa a configuração da aplicação (config/*) da sua execução, permitindo que o servidor seja iniciado de forma limpa pelo <code>yarn dev</code>.
    </div>
</section>