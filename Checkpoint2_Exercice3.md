# Q.3.1
Le materiel sur est un Switch, il permet aux ordinateurs étant sur les mêmes adresses réseaux de communiquer ensemble.
# Q.3.2
C'est un routeur, il permet aux ordineur qui sont sur les mêmes adresse réseaux que lui via R2 d'accéder aux équipements qui sont sur le réseau 172.16.5.0/24.
Il sert donc de passerelle.
# Q.3.3
Ce sont les noms des deux interface du Routeur.
- F0/0 est en fast-ethernet
- G1/0 est en giga-ethernet
# Q.3.4
cela représente son CIDR qui est de 16 et donc il a un masque de sous-réseaus de 255.255.0.0.
# Q.3.5
Cela ne repésente rien car cette adresse ne peut être mise en tant que passerelle car son adresse de réseau est la suivante 10.11.0.0/16 et non 10.10.0.0/16.
# Q.3.6

| | PC1 | PC2 | PC5|  
|--|--|-|---|
| Adresse réseaux | 10.10.0.0/16| 10.11.0.0/16 | 10.10.0.0/15|  
| 1er Adresse dispo.| 10.10.0.1/16 | 10.11.0.1/16 | 10.10.0.1/15|  
| Dernière adress. dipo.| 10.10.255.254/16| 10.11.255.254/16| 10.11.255.254/15|  
| Adresse de broadcast | 10.10.255.255/16 | 10.11.255.255/16 | 10.11.255.255/15|  

# Q.3.7
Donc PC1 / PC3 / PC4 peuvent communiquer entre eux car il sont sur le même réseaux.  
PC2 ne peut communiquer qu'avec PC5 (grâce à sont CIDR 15)  
Et PC5 peut communiquer avec tout le monde.  
# Q.3.8
Seul PC1/PC3/PC4/PC5 pourront atteindre le réseau 172.16.5.0/24 car ils sont sur le même réseaux que le Routeur B.  
# Q.3.9
Il n'y aucune incidence, c'est un switch il s'arrange automatiquement pour redrigé les commuinication vers les bons ports.  
# Q.3.10
On peut rajouter un Serveur DHCP général qui s'occupera de redistribuer automatiqment les adresse IPs  
# Q.3.11
C'est l'adresse suivante : 00:50:79:66:68:00 c'est donc PC1  
# Q.3.12
Oui cela a fonctionné on a un bien un "reply" sur le Paquet 6 à destinaiton du PC4  .
# Q.3.13
Request correspont au PC1,  Adresse IP: 10.10.4.1; Adresse MAC: 00:50:79:66:68:00.  
Reply correspond au PC4,  Adresse IP: 10.10.4.2; Adresse MAC: 00:50:79:66:68:03.  
# Q.3.14
C'est le protocol ARP, il permet d'associer une adresse IPV4 à une adresse MAC lors d'échange entre machines dans un réseau Local.
# Q.3.15
A avec son rôle de Switch à permit à PC1 et PC4 de communiquer ensemble
B est un routeur mais il n'est pas intervenu car pas besoin de faire du routage entre les deux PC.
# Q.3.16
C'est PC3 qui lance la communicaiton son adresse est 10.10.80.3
# Q.3.17
C'est le protocole ICMP, il est utilisé pour controler les potentielles erreur de transmission entre des équipements sur un réseau IP.
Il renvoie vers la machine sources les messages associés aux erreurs de transmission.
# Q.3.18
Non cela a echoué car PC3 a essayé de communiquer avec PC2 et tout les deux ne sont pas sur le même réseaux donc cela ne peut pas fonctionner.
La communicaiton a essayer de passer par son adresse de passerelle 10.10.255.254 mais cela ne peut fonctionner car PC2 n'est pas sur le même réseau que le router B.
# Q.3.19
Le paquet 2 explique que la destination n'est pas joignable depuis la passerelle 10.10.255.254
# Q.3.20
Le Switch A mit en relaton PC3 et le routeur B via l'adresse de passerelle de PC3 qui ensuite a essayer de joindre PC2 mais n'étant pas sur le même réseau que lui et ne faisant pas parti de sa table de routage, B ne peut pas joindre PC2.  
B renvoit donc une erreur à PC3.
# Q.3.21
Source : 
- IP : 10.10.4.2
- Nom : PC4
Destination :
- IP : 172.16.5.253
- Nom : Equipement sur le réseau 172.16.5.0/24
# Q.3.22
Source :
- MAC : CA:01:DA:D2:00:1C
- Port G1/0 du Routeur B
Destination :
- MAC : CA:03:9E:EF:00:38
- Port G2/0 du Routeur R2
On peut en déuire que B et R2 font bien leur travail de routage en transférant la requête de PC4 vers l"équipemet 172.16.5.253 via leur table de routage 
# Q.3.23
Entre B ou R2 car les adresse MAC source et destination sont celle de leur port de communicaiton utilisé pour transmettre la communication
