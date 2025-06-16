import mysql.connector
import time

# Coordonnées de référence
latitude_ref = 48.85
longitude_ref = 2.35
start_time = time.time()

# Connexion à la base MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",          # à adapter
    password="root",  # à adapter
    database="TP9"
)

cursor = conn.cursor()

# Requête SQL avec ST_Distance_Sphere
query = f"""
    SELECT 
        produit,
        latitude,
        longitude,
        ST_Distance_Sphere(
            POINT(longitude, latitude),
            -- POINT(2.35, 48.85)
            POINT({longitude_ref}, {latitude_ref})
        ) AS distance_m
    FROM produits
    ORDER BY distance_m ASC
    LIMIT 3;
"""

cursor.execute(query)
results = cursor.fetchall()

# Affichage des résultats
print(f"🧭 Produits les plus proches de ({latitude_ref}, {longitude_ref}) :\n")
for produit, lat, lon, distance in results:
    print(f"- {produit} ({lat}, {lon}) → {distance:.2f} mètres")
print(f"\nTemps d'exécution : {time.time() - start_time:.4f} secondes\n")

# Fermeture des connexions
cursor.close()
conn.close()