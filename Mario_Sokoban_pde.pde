PImage menu, instructions, bravo,
      caisse,caisse_ok, mur, objectif, 
      mario_bas, mario_haut, mario_droite, mario_gauche;  //on déclare une variable de type PImage pour chaque image
      
PrintWriter output;

int tailleBloc = 34, nbBlocsLargeur = 12, nbBlocsHauteur = 12,
    largeurFenetre = tailleBloc * nbBlocsLargeur,
    hauteurFenetre = tailleBloc * nbBlocsHauteur, //variables pour la taille de la fenêtre et le nombre de blocs
    menu_ = 1, jouer_ = 0, editeur = 0,  //variables (booléens) pour savoir si on se trouve dans le menu, dans le jeu ou dans l'éditeur de niveau
    marioActuel = 1,  //direction de mario (haut/bas/gauche/droite)
    objectifsRestants = 0, gagne = 0,  //si il reste des objectifs dans le niveau (sert pour savoir si on a gagné)
    nLevel = 0,  //numero du niveau qu'on charge
    i, j;  //variables pour les boucles

int niveau[][] = new int[nbBlocsLargeur+1][nbBlocsHauteur];   //tableau qui va contenir tous les niveaux

String[] fichier;  //chaine de caractères qui stocke le contenu de "level.txt"

void setup()  {
 
 size(408,408);  //taille de la fenêtre
 
 menu = loadImage("menu.jpg");
 instructions = loadImage("instructions.jpg");
 bravo = loadImage("bravo.jpg");
 caisse = loadImage("caisse.jpg");
 caisse_ok = loadImage("caisse_ok.jpg");
 mur = loadImage("mur.jpg");
 objectif = loadImage("objectif.png");
 mario_bas = loadImage("mario_bas.gif");
 mario_haut = loadImage("mario_haut.gif");
 mario_droite = loadImage("mario_droite.gif");
 mario_gauche = loadImage("mario_gauche.gif");  //on charge les images en mémoire
  
 fichier = loadStrings("level1.txt");  //on récupere le contenu du fichier texte
 niveau = load(niveau, nLevel, fichier);  //on appelle la fonction qui charge le niveau
    
 image(menu, 0, 0);  //on affiche l'image du menu en fond
 
}


void draw()  {
  
  
  if (jouer_ == 1)  {  //si on est en train de jouer
  
    background(255);  //on efface l'écran
    objectifsRestants = 0;  //on réinitialise la variable
    
    for (i = 0; i < nbBlocsLargeur; i++)  {
    
      for (j = 0; j < nbBlocsHauteur; j++)  {  //boucle qui parcours le niveau
     
         if(niveau[i][j] == 4)  {  //quand on a trouvé Mario
            niveau[12][0] = i;
            niveau[12][1] = j;  //on stocke ses positions
            niveau[i][j] = 0;  //la case où il se trouve est maintenant vide
        }  //fin if
    }
  }  //fin boucle
  
    
    for (i = 0; i < nbBlocsLargeur; i++)  {
    
      for (j = 0; j < nbBlocsHauteur; j++)  {  //boucle qui parcours le niveau
      
        switch(niveau[i][j])  {  //pour chaque case du tableau on affiche l'élément du décor correspondant
          
            case 1:
                image(mur, i * tailleBloc, j * tailleBloc);
                break;
            case 2:
                image(caisse, i * tailleBloc, j * tailleBloc);
                break;
            case 3:
               image(objectif, i * tailleBloc, j * tailleBloc);
               objectifsRestants = 1;  //il reste au moins un objectif, on met donc la variable à 1
                break;
            case 5:
               image(caisse_ok, i * tailleBloc, j * tailleBloc);
               break;
           }  //fin switch
      }
    }  //fin boucle
    
    if (objectifsRestants == 0)  {  //si il n'y a plus d'objectifs on a gagné
      
      image(bravo, width / 2 - 123, height / 2 - 46);  //on affiche donc un message
      gagne = 1;  //variable qui détermine si on a gagné
  }
  
  switch( marioActuel)  {  //on cherche dans quelle direction Mario regarde, et on affiche la bonne image en conséquence
     
     case 0:
        image(mario_haut, niveau[12][0] * tailleBloc, niveau[12][1] * tailleBloc);
        break;
     case 1:
        image(mario_bas, niveau[12][0] * tailleBloc, niveau[12][1] * tailleBloc);
        break; 
     case 2:
        image(mario_gauche, niveau[12][0] * tailleBloc, niveau[12][1] * tailleBloc);
        break; 
     case 3:
        image(mario_droite, niveau[12][0] * tailleBloc, niveau[12][1] * tailleBloc);
        break;
      
      
    }
    
  }  //fin if (jouer_)
  
  
}


void keyPressed()  {  //si on appuie sur une touche
  
 if (key == '1'  && menu_ == 1)  {  //si on est dans le menu est que la touche est 1
   menu_ = 0;  //alors nous ne sommes plus dans le menu
   jouer_ = 1;  //mais dans le jeu

 }
 if (key == '2'  && menu_ == 1)  {  //pareil mais pour l'éditeur de niveau
   menu_ = 0;
 }
 
 if (keyCode == UP && jouer_ == 1)  {  //si on est dans le jeu et qu'on appuie sur le fleche du haut
   marioActuel = 0;  //alors le personnage regarde en haut
   niveau = deplacerJoueur(niveau, niveau[12][0], niveau[12][1], 0);  //on déplace le personnage sur la carte
 }
 
 if (keyCode == DOWN && jouer_ == 1)  {  //pareil avec les fleches de bas/gauche/droite
   marioActuel = 1;
   niveau = deplacerJoueur(niveau, niveau[12][0], niveau[12][1], 1);
 }
 
 if (keyCode == LEFT && jouer_ == 1)  {
   marioActuel = 2;
   niveau = deplacerJoueur(niveau, niveau[12][0], niveau[12][1], 2);
 }
 
 if (keyCode == RIGHT && jouer_ == 1)  {
   marioActuel = 3;
   niveau = deplacerJoueur(niveau, niveau[12][0], niveau[12][1], 3);
 }
 
 if ((key == 'R' || key == 'r') && jouer_ == 1)  {  //quand on est en jeu et qu'on appuie sur la touche 'r'
   
   niveau = load(niveau, nLevel, fichier);  //on recharge le niveau
   marioActuel = 1;  //on redéfinie la direction dans laquelle mario regarde
 }
 
 if ((key == 'M' || key == 'm'))  {  //quand on appuie sur la touche 'm'
   
   editeur = 0;  //on est plus dans l'éditeur de niveau
   jouer_ = 0;  //on n'est plus dans le "jeu"
   menu_ = 1;  //on est dans le "menu"
   image(menu, 0, 0);  //on affiche l'image du menu
 }
 
 if (gagne == 1)  {  //si on a gagné et qu'on appuie sur une touche
    
    nLevel ++;  //on incrémente d'un le numéro du niveau
    niveau = load(niveau, nLevel, fichier);  //on charge le nouveau niveau
    gagne = 0;  //on n'est plus dans le cas où on a gagné
    
    if( nLevel > fichier.length)  {  //si on est arrivés à la fin de tous les niveaux
      
     nLevel = 0;  //on se place au niveau 0
        
     menu_ = 1;  //on retourne au menu
     jouer_ = 0;  //on n'est plus dans le "jeu"
     
     resetLevel(niveau);  //on reset les niveaux
     niveau = load(niveau, nLevel, fichier);  //on charge le niveau 0
     
     image(menu, 0, 0);  //on affiche l'image du menu
    }
 
 }
 
 if (keyCode == ESC)  {  //si on appuie sur echap
  
  exit();   //on quitte le programme
 }
  
}