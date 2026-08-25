FROM nginx:alpine

# Application 100% statique (HTML/CSS/JS auto-suffisant, aucune dependance externe,
# aucune base de donnees, aucun appel reseau sortant) : nginx sert simplement les
# fichiers tels quels, avec une seule regle de cache (cf default.conf).
COPY index.html /usr/share/nginx/html/index.html
COPY manifest.json /usr/share/nginx/html/manifest.json
COPY apple-touch-icon.png /usr/share/nginx/html/apple-touch-icon.png
COPY icon-192.png /usr/share/nginx/html/icon-192.png
COPY icon-512.png /usr/share/nginx/html/icon-512.png
COPY favicon-32.png /usr/share/nginx/html/favicon-32.png

# Configuration nginx : empeche les navigateurs de servir un index.html perime
# apres un deploiement (cf commentaires dans le fichier).
COPY default.conf /etc/nginx/conf.d/default.conf

# Polices fournies avec l'application (SIL Open Font License, cf fonts/LICENSES.md).
COPY fonts/ /usr/share/nginx/html/fonts/

EXPOSE 80
