import math 
import time
import random
import mysql.connector

# générer des données aléatoires puis les insérer dans la base de données
def generate_random_data(num_entries):
    data = []
    for _ in range(num_entries):
        produit = f"Produit_{random.randint(1, 100000)}"
        latitude = random.uniform(-20.0, 20.0)  # Latitude entre -90 et 90
        longitude = random.uniform(-20.0, 20.0)
        data.append((produit, latitude, longitude))
    return data

# insérer les données dans la base de données
def insert_data_to_db(data):
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="TP9"
    )
    cursor = conn.cursor()
    cursor.executemany("INSERT INTO produits (produit, latitude, longitude) VALUES (%s, %s, %s)", data)
    conn.commit()
    cursor.close()
    conn.close()

# fonction principale pour générer et insérer les données
def main():
    num_entries = 100000  # Nombre d'entrées à générer
    start_time = time.time()
    
    data = generate_random_data(num_entries)
    insert_data_to_db(data)
    
    print(f"Inséré {num_entries} entrées dans la base de données en {time.time() - start_time:.4f} secondes.")

main()
main()