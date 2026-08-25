# FLOW - Découpe protège-bras (webapp)

Application 100% statique et autonome (HTML/CSS/JS, aucune base de données, aucun appel
réseau sortant une fois la page chargée). Tout tourne dans le navigateur, comme le fichier
unique livré précédemment, mais servie ici via un vrai lien web pour pouvoir l'ouvrir de
façon fiable dans Safari sur iPad et l'ajouter à l'écran d'accueil comme une icône d'app.

## Ce dépôt

- `Dockerfile` : construit l'image (nginx qui sert les fichiers statiques).
- `docker-compose.yml` : stack prête à l'emploi, publie le port `8080` sur l'hôte par
  défaut (voir le fichier pour l'option "réseau Docker interne" en alternative).
- `index.html`, `manifest.json`, icônes : l'application elle-même.

Le dossier est déjà un dépôt git avec un premier commit sur la branche `main`.

## 1. Pousser ce dépôt sur GitHub

1. Créez un dépôt **vide** sur GitHub (sans README/licence, pour ne pas entrer en conflit
   avec les fichiers déjà présents ici) : https://github.com/new
2. Depuis ce dossier :
   ```
   git remote add origin git@github.com:<votre-compte>/<nom-du-depot>.git
   git push -u origin main
   ```
   (remplacez l'URL par celle de votre dépôt - HTTPS ou SSH selon votre configuration).

## 2. Déployer

### Avec Docker (ligne de commande)

```
docker compose up -d --build
```

Puis pointez votre reverse proxy vers `http://<ip-du-serveur>:8080`. Voir les commentaires
dans `docker-compose.yml` si vous préférez relier le conteneur directement au réseau
Docker de votre reverse proxy plutôt que de publier un port sur l'hôte.

Sans docker-compose :
```
docker build -t flow-cutter .
docker run -d --name flow-cutter --restart unless-stopped -p 8080:80 flow-cutter
```

**Exemple nginx** (proxy classique, pas nginx-proxy) :
```nginx
location / {
    proxy_pass http://flow-cutter:80;   # ou http://<ip>:8080 selon votre setup
    proxy_set_header Host $host;
}
```

**Exemple Traefik** (labels à ajouter sur le service dans `docker-compose.yml`) :
```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.flow-cutter.rule=Host(`decoupe.votredomaine.fr`)"
  - "traefik.http.routers.flow-cutter.tls=true"
  - "traefik.http.routers.flow-cutter.tls.certresolver=<votre-resolver>"
  - "traefik.http.services.flow-cutter.loadbalancer.server.port=80"
```

### Avec Portainer

Deux façons de faire, selon si vous voulez lier le stack à ce dépôt GitHub (mises à jour
en un clic, ou automatiques via webhook) ou juste coller le fichier une fois.

**Option A - Stack depuis le dépôt Git (recommandé)**

1. Portainer → **Stacks** → **Add stack**.
2. Nommez le stack (ex. `flow-cutter`).
3. Onglet **Repository** : collez l'URL du dépôt GitHub créé à l'étape 1. Laissez
   `docker-compose.yml` comme chemin du fichier de compose (c'est déjà le nom par défaut
   que Portainer cherche).
4. Optionnel mais pratique : activez **GitOps updates** pour que Portainer redéploie tout
   seul à chaque push sur la branche `main` (webhook ou vérification périodique, au choix).
5. **Deploy the stack**.

Pour les mises à jour suivantes : poussez vos changements sur GitHub (voir section 3 plus
bas), puis soit attendez le webhook/la vérification automatique, soit cliquez sur **Pull
and redeploy** dans Portainer.

**Option B - Coller le compose directement**

Portainer → **Stacks** → **Add stack** → onglet **Web editor** → collez le contenu de
`docker-compose.yml`. Il faudra alors repasser par cet éditeur à chaque mise à jour
(moins pratique que l'option A, mais ne nécessite pas de builder depuis un dépôt Git).

## 3. Mettre à jour l'application

Quand une nouvelle version est envoyée : remplacez les fichiers changés dans ce dossier,
puis :
```
git add -A && git commit -m "maj" && git push
```
Ensuite redéployez (`docker compose up -d --build`, ou laissez Portainer le faire
automatiquement si le GitOps update est activé). Le fichier ouvert sur l'iPad se met à
jour au chargement suivant de la page (tirer-pour-rafraîchir, ou rouvrir l'app).

## Ajouter l'icône sur l'écran d'accueil de l'iPad

1. Ouvrez l'URL dans Safari (important : Safari, pas une autre app ni un aperçu Fichiers).
2. Appuyez sur l'icône de partage (le carré avec la flèche vers le haut).
3. « Sur l'écran d'accueil ».
4. L'icône FLOW apparaît sur le bureau ; en l'ouvrant, l'app se lance en plein écran, sans
   la barre d'adresse Safari (mode « standalone »).

## Notes techniques

- Aucune base de données, aucun compte, rien à sauvegarder côté serveur : le conteneur est
  entièrement remplaçable/jetable, toute la logique tourne dans le navigateur de l'iPad.
- `paper.js` et `opentype.js` sont intégrés directement dans `index.html` (pas de CDN, pas
  de dépendance réseau externe au chargement).
- Le téléchargement du SVG découpé (bouton « Télécharger ») fonctionne normalement dans ce
  mode webapp classique, contrairement à une page publiée en tant qu'Artifact Claude qui
  bloque ce type de téléchargement : ce n'est pas le cas ici.
