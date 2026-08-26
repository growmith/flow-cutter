# Polices fournies avec l'application

Les 119 fichiers de ce dossier proviennent de **Google Fonts** et sont distribués sous
**SIL Open Font License 1.1**, qui autorise explicitement la redistribution, l'intégration
dans un logiciel et l'usage commercial. Texte complet : https://openfontlicense.org

## Traitement appliqué

Chaque fichier a été converti au format TrueType puis réduit (sous-ensemble) au jeu de
caractères utile à l'application : ASCII imprimable, Latin-1 (accents français), œ/Œ, Ÿ,
guillemets, tirets cadratins, €, °. Aucune modification n'a été apportée au dessin des
caractères, seul le nombre de glyphes embarqués a été réduit, ce que la licence autorise.

Le poids passe ainsi d'environ 40 Mo à 7,3 Mo, avec une médiane de 38 Ko par police.

Les polices sont chargées **à la demande** : ouvrir la liste ne télécharge que les aperçus
visibles à l'écran, et le fichier complet n'est récupéré qu'au moment où la police est
réellement utilisée pour tracer du texte.

## Polices écartées

`Rubik Pixels` et `Rubik 80s Fade` ont été retirées du lot : composées de milliers de
petites formes, elles pèsent 1,8 Mo et 1,1 Mo une fois réduites, et produiraient un nombre
de tracés vectoriels difficilement exploitable en gravure laser. Le rendu pixellisé reste
couvert par `Silkscreen`, `Press Start 2P` et `VT323`.

## Catégories

| Catégorie | Nombre | Exemples |
|---|---|---|
| Gras et affiche | 25 | Anton, Bebas Neue, Archivo Black, Bungee |
| Peinture, marqueur, tag | 27 | Permanent Marker, Rubik Wet Paint, Sedgwick Ave |
| Manuscrites | 25 | Caveat, Pacifico, Great Vibes, Alex Brush |
| Carrées et techno | 22 | Orbitron, Audiowide, Michroma, Press Start 2P |
| Décoratives | 20 | Abril Fatface, Creepster, Monoton, Bungee Shade |

La liste exacte, avec le nom de fichier de chacune, figure dans `index.html` (tableau
`BUNDLED_FONTS`).
