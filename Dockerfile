FROM python:3.10

# Définir le répertoire de travail
WORKDIR /app

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev \
    python3-gdal \
    netcat-openbsd \
    poppler-utils \
    tesseract-ocr \
    libreoffice \
    pandoc \
    default-mysql-client \
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

# Installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du projet
COPY . .

# Rendre le script entrypoint.sh exécutable
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Exposer le port
EXPOSE 8000

# Utiliser le script comme point d'entrée
CMD ["./entrypoint.sh"] 