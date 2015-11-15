#!/bin/bash

echo "Recherche des températures maximales sur plusieurs jours"
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

FileCsv="StatMax-$Jour-$Mois.csv"
Lieu="http://www.meteofrance.com/climat/meteo-date-passee?lieuId=$CodeCommune&lieuType=VILLE_FRANCE&date=$Jour-$Mois-"

echo "Température maximale de la journée" >> $FileCsv
echo "Année;Max" >> $FileCsv

for i in $(seq $Start $End);
do
	curl "$Lieu$i" | grep maximale\ de\ la\ journée >> $FileCsv
	sed -i -e "s/                                                                    <li>Température maximale de la journée : /$Jour-$Mois-$i;/g" $FileCsv
	sed -i -e "s/°C<\/li>//g" $FileCsv
	sed -i -e "s///" $FileCsv
	sed -i -e "s/ : /;/g" $FileCsv
	sed -i -e "s/\./,/g" $FileCsv
done


