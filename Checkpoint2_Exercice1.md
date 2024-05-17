# Q.1.1
- L'adresse IP du serveur est en 172.16.10.10/24
- L'adresse IP du client est en 172.16.100.50/24
Les deux machines sont sur un CIDR 24, donc elle ne peuvent communiquer qu'avec des machines étant ayant les 3 mêmes premiers octet.
- Le serveur peut communiquer avec une machine ayant une adresse en 172.16.10.X et le client avec une machine ayant une adresse en 172.16.100.X

Donc on va modifier l'adresse IP de la machine cliente et la passer en 172.16.10.50 : 

![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/ip_client.png?raw=true)

Ensuite on vérifié que le ping fonctionne bien entre les deux machines

### Du client vers le serveur

![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/ping_c_s.png?raw=true)  

### Du serveur vers le client

![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/ping_s_c.png?raw=true)  

On a bien une réponse à chaque fois, c'est bon.

# Q.1.2

Voila le résultat du ping avec le nom du client
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/ping_s_c_nom.png?raw=true)  
On a une réponse au ping demandé et il est effectué sur l'adresse IPV6 qui est l'adresse unicast lien local de la machine client.

# Q.1.3

Pour désactiver l'IPV6, il suffit de le décocher dans la configuration de la carte réseau  
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/client_ipv6_desac.png?raw=true) 

On vérifie ensuite via la commande `IPconfig /all`qu'elle est bien désactivé.  
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/client_ipv6_desac2.png?raw=true)  

On refait un ping depuis le serveur vers la machine client avec son nom

![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/ping_s_c_nom_2.png?raw=true)  
On a bien une réponse au ping, le nom de la machine est bien reconnu car les deux machines sont toujours sur le même plan d'adresse reseau IPV4.
Et il fonctionne correctement, je ne vois pas l'intérêt de remodifier des choses sur le serveur ou le client car cela fonctionne.

# Q.1.4

La DHCP sur le serveur est configuré de cette façon 
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/config_DHCP.png?raw=true)  
On voit que le pool d'adresse mit à disposition va de 172.16.10.1 à 172.16.10.254.  

Sur le client il faut passer l'adressage de la carte réseau en automatique :  
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/client_dhcp.png?raw=true)  

Une fois cela effectué on voit bien que la carte à récuépré une adresse réseau qui correspond bien au pool définit par le serveur. (172.16.10.20)
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/client_dhcp2.png?raw=true)  

# Q.1.5
On peut voir que sur la configuraiton les deux pools d'adresse IP suivante sont excluent :
- 172.16.10.1 à 172.16.10.19
- 172.16.10.241 à 172.16.10.254
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/config_DHCP.png?raw=true)  
C'est pour cette raison que l'adresse récupéré n'est pas la première et donc prend l'adresse 172.16.10.20 qui est donc la première disponnible.
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/client_dhcp2.png?raw=true)

# Q.1.6
Il faut faire une réservaiton par adresse MAC, l'adresse MAC de la carte du PC client est la suivante : 08-00-27-BF-C0-34
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/resa_IP.png?raw=true)  
Bien laissé Both coché.  
On redémarre ensuite le client et on voit qu'il a bien pris la nouvelle adresse IP.
![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/IP_client_resa.png?raw=true)  

# Q.1.7
L'IPV6, permet de se passer de serveur DHCP. Car automatiquement les machines d'un réseau local vont pouvoir se trouver.

# Q.1.8
Dans ce cas précis si on réactive les adresse IPV6, le serveur DHCP ne sera plus utilie.
Par contre on peut garder le serveur DHCP actif et lui configurer un pool d'adresse IPV6, comme on peut le voir ici :

![](https://github.com/Mr-Maglor/checkpoint2/blob/main/img/dhcp_ipv6.png?raw=true)  
