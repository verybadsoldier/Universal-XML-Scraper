# Universal XML Scraper

Logiciel de Scrape basé sur la base de données [Screenscraper](http://www.screenscraper.fr/).
Vous avez toujours rêvé d'avoir vos descriptifs en français avec de superbe média, c'est maintenant possible ;)
Ce logiciel fonctionne avec un système de profil pour la génération du fichier XML. Il est donc tout à fait possible de se créer son propre profil avec la récupération de ses propres médias ;)
Aujourd'hui les profil existant sont : Recalbox V4, Recalbox V3, Emulationstation et Hyperspin/AttrackMode (en version beta les 2 derniers, ne possédant pas ces systèmes, je n'ai jamais pu les tester ^^)

*Scrape software based on the [Screenscraper](http://www.screenscraper.fr/) database .*
*It can scrape in French, English, German, Spanish and Portuguese (very few data in these 3 last language ^^ but you can participate to the database) with HD Media*
*This software works with a profile system to generate the XML file. It is therefore quite possible to create your own profile with the download of the media of your choice.*
*Today existing profil are: Recalbox V4 V3 Recalbox , Emulationstation ( and Hyperspin / AttrackMode in beta)*

![Interface](https://raw.githubusercontent.com/Universal-Rom-Tools/Universal-XML-Scraper/master/Images/Interface.jpg)

Ce logiciel se veut simple mais puissant et très configurable. Je ne vais pas rentrer dans le détail de toutes les options, seulement 2 :

*Easy to use but with a lots of possible configuration, I only present 2 of the options you can find :*

**l'AutoConfig** : 
Vous lui indiquez le répertoire contenant tous les répertoires de vos différents systèmes (directement sur le PI via le reseau, sur un NAS, une clef USB,...) et il s’occupe tout seul de configurer les chemins et substitution pour le fichier XML. Vous pourrez scraper 1 système sélectionné ou tous d'un coup.

*Simply enter the path where all your system are (Directly on the PI with the network, on a NAS or USB support) and it auto configure all the path for the future XML. You just have to select the system you want (or scrape all of them with 1 clic)*

**Le mode MIX** : 
Vous ne voulez pas vous embêtez à créer des thèmes avec de multiple médias, 1 seule image vous suffit, mais un screenshot tout seul c'est un peu triste. UXS (Universal XML Scraper pour les intimes ;) ) vous permet de faire un mix de média pendant le scrape pour ne générer qu'une seule image. 

*UXS (short name for Universal XML Scraper) can make 1 picture composition with many other.*

![Nes](https://raw.githubusercontent.com/Universal-Rom-Tools/Universal-XML-Scraper/master/Images/Legend%20of%20Zelda%2C%20The%20(Europe)-image.png)![Arcade](https://raw.githubusercontent.com/Universal-Rom-Tools/Universal-XML-Scraper/master/Images/sf2ce-image.png)![Standard 3D Box](http://i.imgur.com/NP5qhzK.png)

Le mode MIX fonctionne aussi à base de thèmes/profils configurable facilement et le [Wiki](https://github.com/Universal-Rom-Tools/Universal-XML-Scraper/wiki) vous explique comment créer le votre facilement.

*The MIX mode work with themes/profils you can make, look at the [Wiki](https://github.com/Universal-Rom-Tools/Universal-XML-Scraper/wiki) (only in french for now sorry)*

--> [LAST VERSION](https://github.com/Universal-Rom-Tools/Universal-XML-Scraper/releases)

[[Tuto] Comment utiliser Universal XML Scraper pour la RECALBOX](https://github.com/Universal-Rom-Tools/Universal-XML-Scraper/wiki/%5BTuto%5D-Comment-utiliser-Universal-XML-Scraper-pour-la-RECALBOX)

**WARNING**

There is a big modification on Screenscraper.
Now you can have data in french, english, but also german, spanish, and portuguese !!!

So there is a modification of Universal XML Scraper to take that in charge ;)

Please Use the very [last version](https://github.com/Universal-Rom-Tools/Universal-XML-Scraper/releases) (after 1.4.0.0)
(If not only 'genre' doesn't work ^^ But I don't know if there are no side effect :p )

__UDF utilisés__  
[Extended Message Box](https://www.autoitscript.com/forum/topic/109096-extended-message-box-bugfix-version-9-aug-15/) par Melba23  
[Hash](https://www.autoitscript.com/forum/topic/95558-crc32-md4-md5-sha1-for-files/) par trancexx  
[MultiLang](https://www.autoitscript.com/forum/topic/118495-multilangau3/) par BrettF  
[Trim](https://www.autoitscript.com/forum/topic/14173-new-string-trim-functions/) par blitzer99  
[XMLDomWrapper](https://www.autoitscript.com/forum/topic/19848-xml-dom-wrapper-com/) par eltorro  
[zip](https://www.autoitscript.com/forum/topic/73425-zipau3-udf-in-pure-autoit/) par torels

__Images__  
L'image moon.png de la borne d'arcade provient du theme [robospin](http://forum.attractmode.org/index.php?topic=700.0) d'attract mode par omegaman
