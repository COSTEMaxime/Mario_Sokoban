int[][] load(int[][] niveau, int f, String[] fichier)  {
  
int i = 0, j = 0;

String fichier_[] = split(fichier[f], " ");  //on créé un tableau qui stocke le niveau

  for (i = 0; i < nbBlocsLargeur; i++)  {
    for (j = 0; j < nbBlocsHauteur; j++)  {  //boucle pour parcourir le niveau
      
       switch(int(fichier_[(i * nbBlocsLargeur) + j]))  {  //on switch la valeur qui se trouve dans le tableau
         
         case 0:
                niveau[j][i] = 0;
                break;
            case 1:
                niveau[j][i] = 1;
                break;
            case 2:
                niveau[j][i] = 2;
                break;
            case 3:
                niveau[j][i] = 3;
                break;
            case 4:
                niveau[j][i] = 4;
                break;
       }
    }
  }

  
  return niveau;
}



int[][] resetLevel(int[][] niveau)  {
  
  int i, j;
  
    for (i = 0; i < nbBlocsLargeur + 1; i++)  {  
      for (j = 0; j < nbBlocsLargeur; j++)  {
        niveau[i][j] = 0;  //on reset la valeur dans le tableau
      }
    }
  
  
  
 return niveau; 
}

void saveLevel(int[][] niveau)  {
  
  output = createWriter("level_.txt");
  
  int i = 0, j = 0;
  
  for (i = 0; i < nbBlocsLargeur; i++)  {
    
    for (j = 0; j < nbBlocsHauteur; j++)  {
      
       output.print(niveau[i][j] + " ");
      
    }
  }
  
  output.print("\n");
  output.flush();
  output.close();
}