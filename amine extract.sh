#!/bin/bash

## files contains the location of all Report.TXT (output from ChemStation).
## */*/* refers to multiple runs, (i.e. two levels of sub-directories).
## If you only have one run, remove one level.
files=$(ls -la */*/* | grep Report.TXT | awk '{print $9}')

## Header for the .csv output
echo "Sample name, Location, Date, Time, Octopamine, Dopamine, Tyramine, Serotonin" > report.csv

## Extract the sample name (make sure this is meaningful), and quantity of Octopamine, Dopamine, Tyramine, and Serotonin. This has to match the names given in ChemStation, and it is case-sensitive.
for file in $files
do
	sample=$(cat "$file")
	name=$(echo "$sample"| grep "Sample Name:"| sed 's/Sample Name: //' | sed 's/\(.*\)./\1/')
	oct=$(echo "$sample" | grep "Octopamine" | awk '{print $6}')
	dop=$(echo "$sample" | grep "Dopamine"   | awk '{print $6}')
	tyr=$(echo "$sample" | grep "Tyramine"   | awk '{print $6}')
	ser=$(echo "$sample" | grep "Serotonin"  | awk '{print $6}')
	output=$(echo "$name,$oct,$dop,$tyr,$ser" | tr -d "\n")
	echo "$output" >> report.csv
done


## Add the lines below to the loop above to get injection location and date/time of your injections.
## Don't forget to add $loc,$date, and $time the output line.

#	loc=$(echo "$sample" | grep "Location" | awk '{print $8}' | sed 's/\(.*\)./\1/')
#	date=$(echo "$sample" | grep "Date" | awk '{print $4}')
#	time=$(echo "$sample" | grep "Date" | awk '{print $5}')
