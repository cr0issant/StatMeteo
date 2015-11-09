#!/bin/bash

echo "Récupération des températures maximales d'une période"
echo 'Code commune ?'
read CodeCommune
CodeCommune+='0'

echo '- 1er jour -'
echo 'Jour ?'
read JourStart
echo 'Mois ?'
read MoisStart
echo 'Année ? ( Minimum 1965 )'
read YearStart
Start='$JourStart-$MoisStart-$YearStart'

echo '- Dernier jour -'
echo 'Jour ? ( Format : 05, 14 )'
read JourEnd
echo 'Mois ?'
read MoisEnd
echo 'Année ? ( Minimum 1965 )'
read YearEnd


FileCsv="StatMaxLaps.csv"
Lieu="http://www.meteofrance.com/climat/meteo-date-passee?lieuId=$CodeCommune&lieuType=VILLE_FRANCE&date="

echo "Température maximale de la journée" >> $FileCsv
echo "Année;Max" >> $FileCsv

#for i in $(seq $Start $End);
while [ $Start != $End ]
do
	#echo "$Jour-$Mois-$i" >> $FileCsv 
	curl "$End" | grep maximale\ de\ la\ journée >> $FileCsv
	sed -i -e "s/                                                                    <li>Température maximale de la journée : /$Jour-$Mois-$i;/g" $FileCsv
	sed -i -e "s/°C<\/li>//g" $FileCsv
	sed -i -e "s/
	sed -i -e "s/ : /;/g" $FileCsv
	sed -i -e "s/\./,/g" $FileCsv
done

