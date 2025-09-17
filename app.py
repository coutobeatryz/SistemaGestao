import os
import psycopg2
from dotenv import load_dotenv

# O dotenv é ótimo para desenvolvimento local. No Render, usaremos as variáveis de ambiente da plataforma.
load_dotenv()

def connect():
    """Conecta ao banco de dados usando a DATABASE_URL do ambiente."""
    database_url = os.getenv("DATABASE_URL")

    if not database_url:
        raise Exception("Erro: A variável de ambiente DATABASE_URL não foi definida.")

    try:
        conn = psycopg2.connect(database_url)
        print("Conexão com o banco de dados Supabase bem-sucedida!")
        return conn
    except psycopg2.OperationalError as e:
        print(f"Erro ao conectar ao banco de dados Supabase: {e}")
        return None

# ... (resto das suas funções: add_user, get_products_by_user, etc.) ...

if __name__ == "__main__":
    connection = connect()
    if connection:
        # Coloque aqui a lógica principal que sua aplicação deve executar
        print("Aplicação iniciada e conectada.")

        # Exemplo: buscar produtos do usuário de ID 1
        # get_products_by_user(connection, 1)

        connection.close()
        print("Conexão fechada.")