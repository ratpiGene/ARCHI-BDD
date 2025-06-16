CREATE DATABASE IF NOT EXISTS TP9;
USE TP9;

DROP TABLE PRODUITS;

CREATE TABLE IF NOT EXISTS PRODUITS (
	ID INT PRIMARY KEY auto_increment not null,
    PRODUIT NVARCHAR(255) not null,
    LATITUDE DOUBLE(10,4) not null,
    LONGITUDE DOUBLE(10,4) not null
);

INSERT INTO PRODUITS (PRODUIT, LATITUDE, LONGITUDE) VALUES
('Café du Coin', 48.8566, 2.3522),     -- Paris
('Boulangerie du Port', 43.2965, 5.3698), -- Marseille
('Épicerie Verte', 45.7640, 4.8357),    -- Lyon
('Librairie Soleil', 50.6292, 3.0573),  -- Lille
('TechZone', 44.8378, -0.5792),         -- Bordeaux
('Fleuriste Marguerite', 43.7102, 7.2620), -- Nice
('Boutique Alpina', 45.8992, 6.1294),   -- Annecy
('Marché Provençal', 43.9493, 4.8055),  -- Avignon
('Atelier du Nord', 51.0500, 2.3700),   -- Dunkerque
('BioMarket', 47.2184, -1.5536),        -- Nantes
('Organic Market NYC', 40.7128, -74.0060),    -- New York
('Tech Supplies LA', 34.0522, -118.2437),     -- Los Angeles
('Chicago Fresh', 41.8781, -87.6298),         -- Chicago
('Seattle Coffee Roasters', 47.6062, -122.3321), -- Seattle
('Austin Electronics', 30.2672, -97.7431),    -- Austin
('Miami Tropic Store', 25.7617, -80.1918),    -- Miami
('Denver Mountain Gear', 39.7392, -104.9903), -- Denver
('Boston Bookstore', 42.3601, -71.0589),      -- Boston
('Phoenix Garden Supplies', 33.4484, -112.0740), -- Phoenix
('San Francisco Artisan', 37.7749, -122.4194);   -- San Francisco

SELECT 
    PRODUIT,
    LATITUDE,
    LONGITUDE,
    ROUND(ST_Distance_Sphere(
        POINT(LONGITUDE, LATITUDE),
        POINT(2.35, 48.85) -- coordonnées données	
    ), 2) AS distance_en_m
FROM PRODUITS
ORDER BY distance_en_m ASC
LIMIT 3;

-- Creations d'indexs
CREATE INDEX idx_geo ON tp9.produits(LATITUDE, LONGITUDE);
-- voir d'autres indexs

-- Bonus : trouver les produits les plus éloignés
SELECT 
    produit,
    latitude,
    longitude,
    ST_Distance_Sphere(
        POINT(longitude, latitude),
        POINT(2.35, 48.85)
    ) AS distance_m
FROM produits
ORDER BY distance_m DESC
LIMIT 1; -- top 1


