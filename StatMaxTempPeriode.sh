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
Start="$JourStart-$MoisStart-$YearStart"

echo '- Dernier jour -'
echo 'Jour ? ( Format : 05, 14 )'
read JourEnd
echo 'Mois ?'
read MoisEnd
echo 'Année ? ( Minimum 1965 )'
read YearEnd
End="$JourEnd-$MoisEnd-$YearEnd"

#echo "$Start"
#echo "$End"

FileCsv="StatMaxLaps.csv"
Lieu="http://www.meteofrance.com/climat/meteo-date-passee?lieuId=$CodeCommune&lieuType=VILLE_FRANCE&date="

echo "Température maximale de la journée" >> $FileCsv
echo "Année;Max" >> $FileCsv

#for i in $(seq $Start $End);
while [ $Start != $End ]
do
	if [ $JourStart = 32 ]
	then
		((MoisStart++))
		JourStart=0
	fi

	if [ $MoisStart = 13 ]
	then
		((YearStart++))
		MoisStart=0
	fi
	Start="$JourStart-$MoisStart-$YearStart"
	((JourStart++))

	#echo "$Jour-$Mois-$i" >> $FileCsv 
	curl "$Lieu$Start" | grep maximale\ de\ la\ journée >> $FileCsv
	echo "$Lieu$Start"
	sed -i -e "s/                                                                    <li>Température maximale de la journée : /$Start;/g" $FileCsv
	sed -i -e "s/°C<\/li>//g" $FileCsv
	sed -i -e "s///" $FileCsv
	sed -i -e "s/ : /;/g" $FileCsv
	sed -i -e "s/\./,/g" $FileCsv
done
	

