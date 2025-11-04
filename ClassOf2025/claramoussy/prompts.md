# Prompt Log — Folding Seat Metro System  
*(Documentation of Model Development Process in SysML v2)*

---

## Introduction

This document records all the main prompts used during the creation of both the **concept model** and the **proof of concept (POC)** for the *Folding Seat Metro System*.  
It provides a trace of the modeling process, the reasoning behind design decisions, and how the system evolved through structured SysML v2 modeling.  
The prompts reflect a progressive understanding of the relationship between mechanical design, logical control, and user interaction.

---

## 1. Concept Model Development

### Prompt Chat — Concept Model

> J’aimerais créer un concept model pour une chaise dépliante.  

> Alors le principe de mon système, c’est que c’est un métro.  
> Dans le métro, j’ai un wagon.  
> Dans le wagon, je retrouve un usager et ma chaise dépliante. 

> Ma chaise dépliante est composée d’une poignée avec un bouton pour déplier la chaise,  
> ainsi que d’un bras télescopique avec un siège sur lequel se trouve un bouton pour replier le siège.  

> Il y a aussi des capteurs dans le wagon qui permettent de détecter si le métro est bondé ou pas.  
> La chaise peut se déplier seulement si le métro n’est pas bondé et que l’utilisateur appuie sur le bouton.  
> Si le métro devient bondé, la chaise se replie toute seule.  
> Et aussi, si elle est inoccupée pendant plus de 30 secondes, elle se replie toute seule.  
> Donc dans le siège, il y a un capteur de présence.  
> Si au bout de 30 secondes, il n’y a personne, elle se replie.  

> Mon bras télescopique est relié au plafond.  
> Ensuite, mon bras télescopique est relié au siège. 

> Les boutons sont encastrés.  

> L’utilisateur, lui, est juste présent dans le wagon.  

> Il y a des flux d’informations entre les capteurs et j’aimerais qu’il y ait un contrôleur auquel on donne toutes les informations.  

> Le contrôleur reçoit les informations de tous les capteurs présents dans le système.  
> Il reçoit le niveau de foule depuis le capteur de foule, l’état du capteur de présence du siège et les informations de temps provenant du timer.  
> C’est lui qui décide si la chaise peut se déployer ou si elle doit se replier.  
> S’il reçoit l’information que le métro est bondé, il bloque le déploiement du siège et envoie la commande pour qu’il se replie automatiquement.  
> S’il n’y a pas de foule et que l’utilisateur appuie sur le bouton, alors il envoie la commande pour déployer le siège.  
> Le contrôleur gère aussi la logique du temps :  
> si le siège est inoccupé pendant plus de 30 secondes, il envoie une commande de repliement automatique.  
> C’est donc le contrôleur qui prend les décisions à partir des signaux qu’il reçoit.  
> Il compare les entrées provenant du capteur de foule, du capteur de présence et de la demande utilisateur,  
> et il produit en sortie les ordres logiques qui pilotent le siège.  

> Il est placé dans le wagon, au même niveau hiérarchique que le siège, le capteur de foule et l’utilisateur.  

> Il ne contrôle pas mécaniquement le siège mais prend uniquement les décisions logiques selon les conditions définies.  

> Le comportement de la chaise dépend entièrement des décisions du contrôleur,  
> qui envoie des signaux comme `allowDeployment`, `crowdOverride` et `idleTimeout` selon la situation.  

> Pour le siège, il y a dedans le bras télescopique, le siège (composé du capteur et du bouton de repliement) et la poignée (composée de la poignée et du bouton de déploiement).  

> Je veux que tout soit dans le même code et bien lié, avec une structure hiérarchique claire et les connexions entre chaque port visibles dans le modèle.  

> Je veux aussi que les flux d’informations soient affichés pour visualiser les échanges entre les composants.  

> Peux-tu ajouter une annotation sur les flèches pour dire les types de flux ?  

> Peux-tu ajouter de la doc pour expliquer le modèle ?


---

## 2. Proof of Concept (POC) Development

### Prompt Chat — POC

> Je veux créer un POC en SysML v2 pour le siège pliable du métro qui se base sur le concept model précédent.  

> Peux-tu me faire un tableau comparatif pour chaque composants du siège en me proposant 3 possibilités basées sur tes recherches de produits existants.  

> Mets-moi les pour, les contre et le choix final en fonction des liaisons que j’avais décrites plus haut entre les composants.  

> Je veux qu’il soit centré uniquement sur la partie mécanique et sur le comportement mécanique du siège, avec les liaisons mécaniques entre les composants et les actions de déploiement et de repliement.  

> Je veux que les choix des composants soient faits pour respecter un assemblage correct avec les liaisons mécaniques choisies précédemment.  

> Peux-tu me faire un modèle SysML pour que je puisse visualiser le POC ?  

> Je veux que le code soit simple, clair et structuré afin d’être compréhensible par tout le monde.  

> La part principale doit être le siège `FoldingSeat` et elle doit contenir une part `ceilingMount`, une part `handle`, une part `telescopicArm`, une part `seatUnit`, une part `seatTimer`.  

> Peut-on faire apparaître les liaisons entre les parts sur le modèle ?  

> Pour finir peux-tu nommer les liaisons s’il te plaît ?  

> Peux-tu ajouter la documentation pour le choix des composants et leur utilité dans le système ?  

> Ajoute de la documentation pour expliquer s’il te plaît.

---


