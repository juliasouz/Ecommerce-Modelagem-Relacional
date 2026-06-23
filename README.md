# Plataforma de E-commerce
 
## Sobre o Projeto
Este repositório contém o desenho e a documentação do modelo lógico transacional (OLTP) para o back-end de um E-commerce. O objetivo principal deste projeto é estruturar a fundação dos dados de vendas, clientes e logística, garantindo alta governança na entrada da informação e evitando anomalias que possam prejudicar o consumo analítico posterior.
 
## Modelagem e Governança de Dados
O modelo foi construído utilizando boas práticas de normalização e integridade referencial, contemplando as seguintes regras de negócio:
 
* **Gestão de Clientes (PF e PJ):** Implementação de exclusividade mútua na tabela `Cliente` através de *Check Constraints*, garantindo que CPFs e CNPJs não se misturem e mantendo a base higienizada desde a origem.
* **Isolamento de Domínios:** Separação das informações de `Forma_Pagamento` e `Entrega` da tabela principal de `Pedidos`. Isso permite que o cliente tenha múltiplas formas de pagamento cadastradas e que os pacotes logísticos tenham rastreamento granular.
* **Controle de Produtos e Fornecedores:** Estrutura escalável para permitir múltiplos parceiros/terceiros vendendo na mesma plataforma.
 
## Arquivos do Repositório
* [Modelo Físico em SQL](/Ecommerce.sql): Script DDL com a criação das tabelas, chaves primárias/estrangeiras e constraints.
* [Documentação da Arquitetura](/Documentacao_Arquitetura_Ecommerce.pdf): Relatório técnico detalhando o dicionário de dados e as narrativas de negócio.
* [Diagrama](/E-commerce.pdf): Imagem do diagrama de Entidade-Relacionamento.
<img width="1999" height="1062" alt="image" src="https://github.com/user-attachments/assets/c8f3ca82-8b79-4d5f-8850-e2a209e14e51" />

## Próximos Passos
A estrutura transacional desenhada aqui atua como o primeiro passo de uma arquitetura de dados mais robusta. As próximas etapas envolvem:
1. **Pipelines de ETL:** Construção de fluxos para extração e transformação destes dados transacionais.
2. **Modelagem Dimensional:** Conversão desta estrutura para um *Star Schema*, facilitando o entendimento da jornada de compra.
3. **Data Storytelling:** Criação de dashboards consumindo as métricas de qualidade para exibir o comportamento real do negócio.
 
## Stack Tecnológica Envolvida
* Modelagem de Banco de Dados Relacional
* SQL (Constraints, Índices, DDL)
* Arquitetura de Sistemas
