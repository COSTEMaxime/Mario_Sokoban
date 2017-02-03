/*  VIDE = 0  MUR  = 1  CAISSE  = 2  OBJECTIF  = 3  MARIO = 4  CAISSE_OK = 5
HAUT = 0  BAS  = 1  GAUCHE  = 2  DROITE  = 3  */

int[][] deplacerCaisse(int premiereCase, int secondeCase, int[][] niveau, int x1, int x2, int y1, int y2)  {
  
  if( premiereCase == 2 || premiereCase == 5)  {  //si la case sur laquelle on veut aller est une caisse
    if( secondeCase == 3)  //si on va déplacer la caisse sur un objectif
      secondeCase = 5;  //il y a une caisse rouge sur la seconde caisse (objectif validé)
    else
      secondeCase = 2;  //il y a une caisse sur la seconde case
    
    if( premiereCase == 5)  //si la caisse était sur un objectif
      premiereCase = 3;  //on affiche un objectif à la place
    else
      premiereCase = 0;  //sinon on affiche rien
    
    niveau[x1][y1] = premiereCase;  //on modifie les 52 cases dans notre niveau
    niveau[x2][y2] = secondeCase;
  }
  
  return niveau;  //on renvoie le nouveau niveau
}


int[][] deplacerJoueur(int[][] niveau , int xpos, int ypos, int marioActuel)  {  //test pour savoir si on peut se déplacer sur la prochaine case

  switch( marioActuel)  {  //switch pour connaître la direction de Mario
    
   case 0:  //si on veut aller vers le haut
      if( ypos - 1 < 0)  {break;}  //si on va sortir de l'écran on sort de la fonction
      if( niveau[xpos][ypos-1] == 1)  {break;}  //si il y a un mur on sort aussi
      if((niveau[xpos][ypos-1] == 2 || niveau[xpos][ypos-1] == 5)  &&  //si on veut se déplacer sur une case où il y a une caisse,
         (ypos - 2 < 0 || niveau[xpos][ypos-2] == 1  || niveau[xpos][ypos-2] == 2 || niveau[xpos][ypos-2] == 5))  //on regarde si la case sur laquelle on va pousser la caisse est pas un mur ou est en dehors de la carte
         {break;}  //si c'est le cas on on sort aussi
  
    //arrivé ici le déplacement est possible, on vérifie donc si il faut déplacer une caisse (si la caisse se trouve sur la carte)
    if( ypos - 1 > 0)  {niveau = deplacerCaisse(niveau[xpos][ypos-1], niveau[xpos][ypos-2], niveau, xpos, xpos, ypos-1, ypos-2);}
    
    
    niveau[12][1] -= 1;  //on modifie la position du personnage
    break;  //on sort du switch
    
    
   case 1:  //si on veut aller vers le bas
      if( ypos + 1 > 11)  {break;}
      if( niveau[xpos][ypos+1] == 1)  {break;}
      if((niveau[xpos][ypos+1] == 2 || niveau[xpos][ypos+1] == 5)  &&
         (ypos + 2 > 11 || niveau[xpos][ypos+2] == 1  || niveau[xpos][ypos+2] == 2 || niveau[xpos][ypos+2] == 5))
         {break;}
    if( ypos + 1 < 11)  {niveau = deplacerCaisse(niveau[xpos][ypos+1], niveau[xpos][ypos+2], niveau, xpos, xpos, ypos+1, ypos+2);}
    niveau[12][1] += 1;
    break;
    
   case 2:  //si on veut aller vers la gauche
      if( xpos - 1 < 0)  {break;}
      if( niveau[xpos-1][ypos] == 1)  {break;}
      if((niveau[xpos-1][ypos] == 2 || niveau[xpos-1][ypos] == 5)  &&
         (xpos - 2 < 0 || niveau[xpos-2][ypos] == 1  || niveau[xpos-2][ypos] == 2 || niveau[xpos-2][ypos] == 5))
         {break;}
    if( xpos - 1 > 0)  {niveau = deplacerCaisse(niveau[xpos-1][ypos], niveau[xpos-2][ypos], niveau, xpos-1, xpos-2, ypos, ypos);}
    niveau[12][0] -= 1;
    break;
    
    case 3:  //si on veut aller vers la droite
      if( xpos + 1 > 11)  {break;}
      if( niveau[xpos+1][ypos] == 1)  {break;}
      if((niveau[xpos+1][ypos] == 2 || niveau[xpos+1][ypos] == 5)  &&
         (xpos + 2 > 11 || niveau[xpos+2][ypos] == 1  || niveau[xpos+2][ypos] == 2 || niveau[xpos+2][ypos] == 5))
         {break;}
    if( xpos + 1 < 11)  {niveau = deplacerCaisse(niveau[xpos+1][ypos], niveau[xpos+2][ypos], niveau, xpos+1, xpos+2, ypos, ypos);}
    niveau[12][0] += 1;
    break;
  }

  return niveau;  
}








