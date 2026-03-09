<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BeTalent Challenge - Leonardo Adler</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6; color: #333; max-width: 900px; margin: 0 auto; padding: 20px; background-color: #f4f7f6; }
        header { border-bottom: 3px solid #007bff; padding-bottom: 20px; margin-bottom: 30px; }
        h1 { color: #007bff; margin-bottom: 5px; }
        h2 { color: #2c3e50; border-left: 5px solid #007bff; padding-left: 10px; margin-top: 30px; }
        h3 { color: #34495e; }
        code { background: #e9ecef; padding: 2px 5px; border-radius: 4px; font-family: 'Courier New', Courier, monospace; }
        pre { background: #2d3436; color: #dfe6e9; padding: 15px; border-radius: 8px; overflow-x: auto; }
        .badge { display: inline-block; background: #007bff; color: white; padding: 5px 12px; border-radius: 20px; font-size: 0.9em; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; background: white; }
        table th, table td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        table th { background-color: #007bff; color: white; }
        .profile-box { background: #fff; border: 1px solid #ddd; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        a { color: #007bff; text-decoration: none; }
        a:hover { text-decoration: underline; }
        hr { border: 0; border-top: 1px solid #ddd; margin: 30px 0; }
    </style>
</head>
<body>

<header>
    <h1>💳 Sistema Gerenciador de Pagamentos Multi-Gateway</h1>
    <p>Projeto desenvolvido para o <strong>Processo Seletivo BeTalent</strong></p>
    <span class="badge">Nível 2 Implementado</span>
</header>

<section class="profile-box">
    <h2>👨‍💻 Sobre o Desenvolvedor</h2>
    <p>Atualmente atuo como <strong>Analista de Sistemas I na Universal Armazéns Gerais e Alfandegados</strong>. Minha trajetória é focada na transição para o desenvolvimento Backend, unindo rigor acadêmico e prática de mercado.</p>
    <ul>
        <li><strong>Formação:</strong> Tecnólogo em Banco de Dados pela <strong>FATEC São José dos Campos</strong>.</li>
        <li><strong>Especialização:</strong> Aluno especial de Mestrado na <strong>UNIFESP</strong>.</li>
        <li><strong>Portfólio:</strong> <a href="https://github.com/LeoAdlerr/PortfolioApis" target="_blank">github.com/LeoAdlerr/PortfolioApis</a></li>
    </ul>
</section>

<section>
    <h2>🎯 O Desafio: Foco Nível 2</h2>
    <p>Como um Desenvolvedor Júnior com sólida base em dados, optei por entregar o <strong>Nível 2</strong> com excelência técnica, garantindo uma API resiliente e modular.</p>
    
    <h3>Destaques da Implementação:</h3>
    <ul>
        <li><strong>Cálculo Server-side:</strong> Valor total (Preço × Quantidade) processado integralmente no backend via AdonisJS.</li>
        <li><strong>Lógica de Failover:</strong> Tentativa automática entre gateways baseada em prioridade dinâmica.</li>
        <li><strong>Segurança:</strong> Tratamento de dados sensíveis e autenticação robusta para Gateways externos.</li>
    </ul>
</section>

<section>
    <h2>🛠️ Stack Tecnológica</h2>
    <ul>
        <li><strong>Backend:</strong> AdonisJS 6 (Node.js + TypeScript)</li>
        <li><strong>ORM:</strong> Lucid (Active Record)</li>
        <li><strong>Banco de Dados:</strong> MySQL 8.0</li>
        <li><strong>Containerização:</strong> Podman / Docker Compose</li>
    </ul>
</section>

<section>
    <h2>🚀 Como Executar</h2>
    <p>Certifique-se de ter o <strong>Podman</strong> ou <strong>Docker</strong> instalado.</p>
    
    <pre><code># 1. Clonar repositório
git clone https://github.com/LeoAdlerr/betalent-challenge.git

# 2. Subir infraestrutura (DB + Gateway Mocks)
podman-compose up -d

# 3. Instalar dependências e rodar migrations
npm install
node ace migration:run
npm run dev</code></pre>
</section>

<section>
    <h2>🛣️ Principais Endpoints</h2>
    <table>
        <thead>
            <tr>
                <th>Rota</th>
                <th>Método</th>
                <th>Descrição</th>
                <th>Acesso</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>/login</code></td>
                <td>POST</td>
                <td>Autenticação administrativa</td>
                <td>Público</td>
            </tr>
            <tr>
                <td><code>/compra</code></td>
                <td>POST</td>
                <td>Processamento de pagamento</td>
                <td>Público</td>
            </tr>
            <tr>
                <td><code>/gateways</code></td>
                <td>PATCH</td>
                <td>Gestão de prioridades</td>
                <td>Admin</td>
            </tr>
            <tr>
                <td><code>/compras</code></td>
                <td>GET</td>
                <td>Listagem de transações</td>
                <td>Privado</td>
            </tr>
        </tbody>
    </table>
</section>

<hr>

<footer>
    <p style="text-align: center; font-size: 0.9em; color: #777;">
        Desenvolvido com foco em qualidade e integridade de dados por Leonardo Adler.
    </p>
</footer>

</body>
</html>
