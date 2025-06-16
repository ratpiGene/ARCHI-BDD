import mysql.connector
import math
import time

def haversine(lat1, lon1, lat2, lon2):
    R = 6371000  # rayon de la Terre en mètres
    phi1 = math.radians(lat1)
    phi2 = math.radians(lat2)
    delta_phi = math.radians(lat2 - lat1)
    delta_lambda = math.radians(lon2 - lon1)

    a = math.sin(delta_phi / 2) ** 2 + \
        math.cos(phi1) * math.cos(phi2) * math.sin(delta_lambda / 2) ** 2

    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

    return R * c

# Coordonnées de référence
latitude_ref = 48.85
longitude_ref = 2.35
start_time = time.time()

# Connexion à la BDD
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="TP9"
)
cursor = conn.cursor()

# Récupère tous les produits
cursor.execute("SELECT produit, latitude, longitude FROM produits")
rows = cursor.fetchall()

# Calcule les distances
distances = []
for produit, lat, lon in rows:
    distance = haversine(latitude_ref, longitude_ref, lat, lon)
    distances.append((produit, lat, lon, distance))

# Trie par distance et prend les 3 plus proches
distances.sort(key=lambda x: x[3])
top3 = distances[:3]

# Affichage
print(f"\n🔍 Résultat avec calcul Haversine depuis ({latitude_ref}, {longitude_ref}):\n")
for produit, lat, lon, distance in top3:
    print(f"- {produit} ({lat}, {lon}) → {distance:.2f} mètres")

print(f"\nTemps d'exécution : {time.time() - start_time:.4f} secondes\n")

# Ferme la connexion
cursor.close()
conn.close()
