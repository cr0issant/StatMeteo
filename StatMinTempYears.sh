#!/bin/bash

echo "Recherche des températures maximales d'un jour de l'année sur plusieurs années"
echo 'Code commune ?'
read CodeCommune
CodeCommune+='0'
echo 'Jour ?'
read Jour
echo 'Mois ?'
read Mois
echo 'Année de départ ? ( Minimum 1965 )'
read Start
echo 'Année de fin ?'
read End

FileCsv="StatMin-$Jour-$Mois.csv"
Lieu="http://www.meteofrance.com/climat/meteo-date-passee?lieuId=$CodeCommune&lieuType=VILLE_FRANCE&date=$Jour-$Mois-"

echo "Température minimale de la journée" >> $FileCsv
echo "Année;Max" >> $FileCsv

for i in $(seq $Start $End);
do
	#echo "$Jour-$Mois-$i" >> $FileCsv 
	curl "$Lieu$i" | grep minimale\ de\ la\ journée >> $FileCsv
	sed -i -e "s/                                                                    <li>Température minimale de la journée : /$Jour-$Mois-$i;/g" $FileCsv
	sed -i -e "s/°C<\/li>//g" $FileCsv
	sed -i -e "s///" $FileCsv
	sed -i -e "s/ : /;/g" $FileCsv
	sed -i -e "s/\./,/g" $FileCsv
done


