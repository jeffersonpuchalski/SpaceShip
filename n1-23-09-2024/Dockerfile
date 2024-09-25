# Usando a imagem oficial do SQL Server no Linux
FROM mcr.microsoft.com/mssql/server:2022-latest

# Definindo variáveis de ambiente para configuração do SQL Server
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrong!Passw0rd
ENV MSSQL_PID=Express

USER root

# Cria um diretório para o script SQL
RUN mkdir -p /app

# Copia o script SQL para o contêiner
COPY script.sql /app/script.sql

# Expõe a porta padrão do SQL Server
EXPOSE 1433

# Inicializa o SQL Server e executa o script após 15 segundos de espera
CMD /bin/bash -c "/opt/mssql/bin/sqlservr & sleep 15 &&  /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P YourStrong!Passw0rd -C -i /app/script.sql && wait"