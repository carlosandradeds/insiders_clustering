# Programa de fidelidade para um E-Commerce

O projeto consiste em identificar grupos de clientes, identificando os mais valiosos para um programa de fidelidade.

O dados do projeto foram obtidos do Kaggle, do desafio "High Value Customers Identification"

Assim o contexto de negócios é fictício, porém todo o planejamento e desenvolvimento da solução é implementado seguindo todos os passos de um projeto real.

## 1. Problema de negócio
### 1.1 Problema
A Sells All é uma empresa que comercializa variados tipos de produtos. A empresa hoje conta com 5000 clientes e o time de marketing notou comportamentos diferenciados para alguns clientes, com alto valor gasto, alta frequencia de compra, contribuindo de forma significativa no faturamento da empresa.

A equipe começou a ver como uma ótima oportunidade de aumentar o faturamento e então decidiram criar um programa de fidelidade para que estes clientes. Para isso eles precisam de uma forma para identificar o perfil dos clientes valiosos e também de outros grupos de clientes.

Com a identificação dos grupos o time de marketing conseguirá tomar decisões mais acertadas e direcionadas para cada grupo de clientes fazendo com que outros clientes também entrem no grupo.

### 1.2 Objetivo
Agrupar os clientes da base em grupos por perfil de consumo e identificar os clientes mais valiosos.

Além disso, a equipe de marketing sugeriu algumas questões a serem respondidas.

- Quem são as pessoas elegíveis para participar do programa Insiders?
- Quantos clientes farão parte do grupo?
- Quais são as principais características desses clientes?
- Qual a porcentagem de contribuição de faturamento, vinda do Insiders?
- Qual a expectativa de faturamento desse grupo para os próximos meses?
- Quais as condições para uma pessoa ser elegível ao Insiders?
- Quais as condições para uma pessoa ser removida do Insiders?
- Qual a garantia que o programa Insiders é melhor que o restante da base?
- Quais ações do time de marketing pode realizar para aumentar o faturamento?

## 2. Premissas de negócio
O time de marketing precisa visualizar os perfis de cada grupo de clientes dentro de uma ferramenta de Visualização e a escolhida foi o Metabase.

## 3. Planejamento da solução
### 3.1 Produto final
- Um dashboard dentro da ferramenta Metabase, que detalha os perfis de cada grupo de clientes.
-Respostas às questões de negócio.

### 3.2 Ferramentas
Quais ferramentas serão usadas no processo?
- Python 3.9.0;
- Jupyter Notebook;
- Git e Github;
- Coggle Mindmaps;
- Pandas Profiling, Metabase;
- Algoritmos de Clusterização;
- Técnicas de Embedding;
- Crontab e Papermill;
- Serviços AWS: S3 (armazenamento), EC2 (servidor) e RDS (banco de dados).


### 3.3 Planejamento da Solução

Minha estratégia para resolver esse desafio, baseado na metodologia CRISP-DS, é detalhada pelo plano abaixo:

**Solution Planning**
- Planejamento da solução, considerando o contexto de negócio.

**Data Description:**
- Coletar dados na AWS EC2.
- Compreender o significado de cada atributo dos interessados.
- Renomear colunas, compreender dimensões e tipos dos dados.
- Identificar e tratar dados nulos.
- Padronizar tipos de dados.
- Analisar atributos através de estatística descritiva.

**Data Filtering:**
- Filtrar dados de acordo com análise da estatística descritiva.

**Feature Engineering:**
- Alterar a granularidade dos dados passando de nota fiscal emitida para cliente.
- Criar features na granularidade cliente.

**Exploratory Data Analysis I:**
- Realizar uma análise univariada com uso do Pandas Profiling, para:
  - Analisar variáveis com alta variabilidade, candidatas a insumo dos modelos.
  - Analisar outliers inconsistentes, a fim de filtrá-los nos próximos ciclos.
- Realizar uma análise bivariada, identificando visualmente variáveis sem variabilidade.

**Data Preparation:**
- Aplicar transformações nas features, facilitando o aprendizado dos modelos.

**Feature Selection:**
- Selecionar as features com maior variabilidade, visando melhorar a performance dos modelos.  
- Analisar o resultado em conjunto com a análise realizada na EDA.

**Exploratory Data Analysis II:**
- Realizar um estudo do espaço de dados, buscando um espaço mais organizado com embedding.

**Hyperparameter Fine Tuning:**
- Experimentação de modelos de clusterização com diferentes Ks (quantidade de grupos), no espaço de features e no espaço de embedding.
- Fazer um ajuste fino de hiperparâmetros em cada modelo, identificando o melhor conjunto de parâmetros para maximizar sua capacidade de aprendizagem.
- Comparação de performance dos modelos com SS Score em cada espaço.
- Escolher o melhor modelo e número de grupos, considerando performance e facilidade para tomada de decisão para o negócio.
- Realizar análise de silhueta, para verificação da qualidade da clusterização.

**Machine Learning Modeling:**
- Rodar o algoritmo escolhido com parâmetros e o número de K escolhidos, no espaço de dados escolhido.
- Confirmar performance com SS Score.

**Convert Model Performance to Business Values:**
- Criar planilha de perfil de cada grupo de clientes.
- Plotar resultados traduzindo ao time de negócios.

**Exploratory Data Analysis III:**
- Criar mindmap de hipóteses de negócio.
- Criar, priorizar e validar hipóteses.
- Responder as questões de negócio ao time de marketing.

**Deploy Modelo to Production:**
- Inserir dados no banco de dados AWS RDS.
- Planejar deploy, desenhando arquitetura da infra.
- Construir e testar a infra localmente.
- Construir e testar a infra em nuvem na AWS.
- Construir e validar o dashboard no Metabase.


O desenho da arquitetura se encontra a seguir:

<img src="https://github.com/carlosandradeds/insiders_clustering/tree/main/data/img/diagramaclusteringfinal.jpg?raw=true" alt="diagramaclusteringfinal" title="Planejamento de Infraestrutura Local e em Cloud" align="center" height="600" class="center"/>


## 4. Os principais Insights gerados

**H1 - Os clientes do cluster Loyals têm uma média de produtos únicos comprados acima de 10% do total de compras.**

Verdadeiro: 50% do volume de produtos únicos veio do cluster Loyals.

* Insight de negócio: Aplicar estratégias de marketing para oferecer produtos similares para os demais clusters, tomando como base os comprados pelos Loyals, visando reduzir a distância entre ambos neste quesito.

**H2 - Os clientes do cluster Loyals apresentam um número médio de devoluções 10% abaixo da média da base total de clientes.**

Falso: o cluster Insider tem um número médio de devoluções 256% maior que a média da base total de clientes.

* Insight de negócio: Dado o número de devoluções bem acima do esperado, realizar levantamento detalhado de custos de logística reversa com área responsável, avaliando o impacto negativo frente as demais características positivas do Loyals.

**H3 - A receita mediana do cluster Loyals é 10% maior que a receita mediana de todos os clusters.**

Verdadeiro: a receita mediana do cluster Loyals é 155% (1.5x) maior do que a receita mediana de todos os clusters.

* Insight de negócio: Destinar time dedicado da área de marketing para cuidar do relacionamento com os Loyals, dada representatividade do faturamento dentro da empresa, em relação ao negócio.

# 5. Modelos de Machine Learning aplicados
Foram testados 4 modelos de clusterização: K-Means, GMM, Hierarchical Clustering, DBScan

Os 4 modelos foram testados e análisadas as métricas para até 25 grupos de clientes, mas em termos práticos só seriam interessantes até 12 grupos de clientes facilitando a criação de estratégias.

Os modelos foram testados utilizando o espaço original de features e também um espaço de embedding.

Foram testados também diferentes espaços de embedding como: PCA, UMAP, t-SNE e um embedding baseado em árvores com Random Forest.

# 6. Perfomance do modelo de Machine Learning
Para avaliar a perfomance dos modelos foi utilizada a métrica Silhouete Score, visto que ela é aplicável a todos os modelos de clusterização testados.

Os modelos K-Means e GMM apresentaram bons resultados e os dois poderiam ser implementados, então foi escolhido o K-Means para o modelo final.

# 7. Resultado de Negócio
As questões de negócio foram respondidas (As mesmas se encontram no notebook do ciclo 08)

Referente a resultados financeiros, partimos do fato de que a receita mediana do cluster Insiders é (1.5x) maior do que a receita mediana de todos os clusters, como já exposto.

Com a premissa que o time de marketing da Sells All, através do projeto, aumentará em 10% o número de Insiders no próximo ano, teremos em 10% da base um aumento mediano de faturamento de 1.5x.

O número de clientes Insiders no último ano (373 dias) é: 1786.
O número de clientes Insiders esperado para o próximo ano é de: 1965.
Teremos portanto 179 novos clientes.

Assumindo a mesma mediana de faturamento por Insider, a expectativa de incremento de faturamento é de $280665.

O detalhamento dos cálculos também encontra-se no Jupyter Notebook, no ciclo 8.

A seguir o Dashboard gerado no Metabase:

<img src="https://github.com/carlosandradeds/insiders_clustering/tree/main/data/img/dashboardfinal.png?raw=true" alt="dashboardfinal" title="Planejamento de Infraestrutura Local e em Cloud" align="center" height="600" class="center"/>


# 8. Conclusões
Com base nos resultados de negócio, conclui-se que o objetivo do projeto foi atingido.

Com a solução de dados entregue, a Sells All possui agora um programa de fidelidade robusto e lucrativo.

Ações de marketing direcionadas para os demais grupos de clientes também poderão ser realizadas, aumentando ainda mais o alcance do trabalho desenvolvido.


# 9. Melhorias futuras
- Criar mais features a partir das já existentes, buscando gerar mais insumos para o aprendizado dos modelos.
- Utilizar uma ferramenta para gerenciamento de ambiente virtual mais eficiente.
