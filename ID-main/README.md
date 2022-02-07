
### Explications

## Architecture

* Le dossier [capteurs](https://github.com/RemiDelz/ID/tree/main/capteurs) contient le code arduino qui gère les capteurs. Toutes les secondes, il écrit sur le Serial les derniers données enregistrées. 
* Le script python [arduino_com](https://github.com/RemiDelz/ID/blob/main/arduino_com.py) vient lire le canal de communication est récupère les valeurs des capteurs dans le but de les envoyer sur un serveur au fromat JSON. 
* Le dossier [Interface](https://github.com/RemiDelz/ID/tree/main/Interface) contient le code processing permettant d'afficher une jolie interface. Sur cette dernière l'on viendrait sélectionner un slot en cliquant sur la salle, et cela viendrait récupérer les infos du serveurs pour les affichers dans le rectangle de droite.  

## Autres

* Le dossier [autres](https://github.com/RemiDelz/ID/tree/main/autres) contient les reflexions et schémas faient au cours du développement du projet. Il contient nottament un ensemble de code arduino pour executer et tester les capteurs individuellement.
