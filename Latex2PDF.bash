
# ----------------------------------------------------
# Script''Latex2PDF''
# ----------------------------------------------------

# Par ''Alban MARTEL''
# Courriel : albanmartel(POINT)developpeur(AT)gmail(POINT)com
# License : GNU GPL
# Ce script permet de générer un pdf à partid de latex.
#
# Depends : 
# texlive-latex-extra : : paquets LaTeX supplémentaires
# texlive-latex3 - TeX Live : paquet factice de transition
#
# Date : 07/09/2015
# version : 0.1
# Mise-à-jour : 
# ----------------------------------------------------

# !/bin/bash
# OUTPUT-COLORING
red=$( tput setaf 1 )
green=$( tput setaf 2 )
NC=$( tput sgr0 )      # or perhaps: tput sgr0
#NC=$( tput setaf 0 )      # or perhaps: tput sgr0


function readchoix(){
  read choix; 
}


function compilationLatex2PDF(){
  pdflatex $1
  pdf2txt -o $2.pdf
  rm $2.log;
  rm $2.aux;
  rm $2.tex.backup; 
  rm $2.synctex.gz
}


function travailDunom(){

  nom=$(echo $1 | sed "s/\(.*\)\(.tex\)/\1/g");
  echo $nom;
}



function main(){
  test=$(ls | grep .tex | wc -l);
  if [[ $test -ge 1 ]]; then 
    tableau=($(ls | grep .tex));
    #echo ${tableau[@]};
    printf "%s\n" "Choisissez une fichier latex pour générer un PDF :";
    for (( i=0 ; i<${#tableau[@]}; i++ )); do
      printf "%s\n" "${green}$(($i + 1 )) "-" ${tableau[$i]}${NC}";
    done
    readchoix;
    travailDunom ${tableau[$(($choix -1 ))]};
    compilationLatex2PDF ${tableau[$(($choix -1 ))]} $nom
  else 
    printf "%s\n" "${red}Dans ce répertoire, il n'y a aucun fichier LATEX utilisable pour générer un fichier PDF${NC}"; 
    exit 100;
  fi
}

main;
exit;
