# Projet diploma

Ce projet a pour but de mettre en place une application décentralisée permettant la gestion de diplômes ainsi que la notation des élèves via l'entreprise qui les accueille en stage de fin d'année.

Ce projet a été réalisé en pair programming par les personnes suivantes :

- CHARDRON Jamison
- SIROT PAulin
- LALLOUE Léone
- SIEG Alexandre

## Smarts contracts

2 contrats sont présents dans le projet, l'un d'eux permet de gérer le token utilisé par le projet et l'autre regroupe toute la logique qui permet de répondre à notre cas d'usage.

Ils sont disponibles dans le dossier `contracts` du projet.

### Fonctionnalités :

```
✅ Création d'un étudiant
✅ Notation de l'étudiant
✅ Attribution d'un diplôme à un étudiant
✅ Vérification d'un diplôme (en échange de 10 tokens)
```

## Application web

Nous avons mis en place un début d'application web pour apprendre à intéragir avec nos smarts contracts. 

Toutes les fonctionnalités du smart contract n'ont pas encore été implémentés mais cela nous permet d'avoir une bonne base pour de futurs projets.

### Fonctionnalités :

```
✅ Création d'un étudiant (certains champs sont remplis par défaut)
✅ Récupération des étudiants
⏳ Vérification d'un diplôme
⏳ Notation d'un étudiant
⏳ Affectation d'un diplôme à un étudiant
```

### Mise en place de l'application web

Téléchargement de NodeJS version 18 ou ultérieure

Clonage du projet en local

Installation des dépendances :
```
npm install
```

Changez les valeurs présentes dans le nuxt.config.ts par les adresses des contrats (à déployer en amont, via remix par exemple (l'application web été testée sur des contrats présents sur la blockchain goerli)) :
```
// nuxt.config.ts
runtimeConfig: {
  public: {
    TOKEN_CONTRACT_ADDRESS: 'L_ADRESSE_DU_CONTRAT_DE_TOKEN',
    DIPLOMA_CONTRACT_ADDRESS: 'L_ADRESSE_DU_CONTRAT_DE_DIPLOME',
  }
}
```

Lancement du serveur web :
```
npm run dev
```

Rendez-vous ensuite sur http://localhost:3000