FROM nginx:alpine

# Application 100% statique (HTML/CSS/JS auto-suffisant, aucune dependance externe,
# aucune base de donnees, aucun appel reseau sortant) : nginx sert simplement les
# fichiers tels quels. Aucune configuration nginx particuliere n'est necessaire.
COPY index.html /usr/share/nginx/html/index.html
COPY manifest.json /usr/share/nginx/html/manifest.json
COPY apple-touch-icon.png /usr/share/nginx/html/apple-touch-icon.png
COPY icon-192.png /usr/share/nginx/html/icon-192.png
COPY icon-512.png /usr/share/nginx/html/icon-512.png
COPY favicon-32.png /usr/share/nginx/html/favicon-32.png

EXPOSE 80
