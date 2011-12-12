#!/bin/bash
files=$(ls -la */*/* | grep Report.TXT | awk '{print $9}')
echo "Sample name, Location, Date, Time, Octopamine, Dopamine, Tyramine, Serotonin" > report.csv

for file in $files
do
	sample=$(cat "$file")
	name=$(echo "$sample"| grep "Sample Name:"| sed 's/Sample Name: //' | sed 's/\(.*\)./\1/')
	loc=$(echo "$sample" | grep "Location" | awk '{print $8}' | sed 's/\(.*\)./\1/')
	date=$(echo "$sample" | grep "Date" | awk '{print $4}')
	time=$(echo "$sample" | grep "Date" | awk '{print $5}')
	oct=$(echo "$sample" | grep "Octopamine" | awk '{print $6}')
	dop=$(echo "$sample" | grep "Dopamine"   | awk '{print $6}')
	tyr=$(echo "$sample" | grep "Tyramine"   | awk '{print $6}')
	ser=$(echo "$sample" | grep "Serotonin"  | awk '{print $6}')
	output=$(echo "$name,$loc,$date,$time,$oct,$dop,$tyr,$ser" | tr -d "\n")
	echo "$output" >> report.csv
done
