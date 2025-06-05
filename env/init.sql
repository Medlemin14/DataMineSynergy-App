-- Créer la base de données si elle n'existe pas
CREATE DATABASE IF NOT EXISTS datamine_synergy;

-- Accorder tous les privilèges à l'utilisateur datamine_user pour toutes les adresses IP
GRANT ALL PRIVILEGES ON datamine_synergy.* TO 'datamine_user'@'%' IDENTIFIED BY 'datamine_password';
GRANT ALL PRIVILEGES ON datamine_synergy.* TO 'datamine_user'@'localhost' IDENTIFIED BY 'datamine_password';
GRANT ALL PRIVILEGES ON datamine_synergy.* TO 'datamine_user'@'127.0.0.1' IDENTIFIED BY 'datamine_password';

-- S'assurer que les privilèges sont appliqués immédiatement
FLUSH PRIVILEGES; 