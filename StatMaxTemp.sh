#!/bin/bash

FileCsv="StatMax-08-11.csv"
Lieu="http://www.meteofrance.com/climat/meteo-date-passee?lieuId=243400&lieuType=VILLE_FRANCE&date=08-11-"

echo "Température maximale de la journée" >> $FileCsv
echo "Année;Max" >> $FileCsv

for i in $(seq 2010 2014);
do
	#echo "08-11-$i" >> $FileCsv 
	curl "$Lieu$i" | grep maximale\ de\ la\ journée >> $FileCsv
	sed -i -e "s/                                                                    <li>Température maximale de la journée : /08-11-$i;/g" $FileCsv
	sed -i -e "s/°C<\/li>//g" $FileCsv
	sed -i -e "s///" $FileCsv
	sed -i -e "s/ : /;/g" $FileCsv
	sed -i -e "s/\./,/g" $FileCsv
done


