head -n 3 data1.csv | sed 's/\t/,/g' > data1.1
tail +2 data2.csv | sed 's/\t/,/g' | sed 's/   /,/g'  > data2.1
sed 's/\t/,/g' data3.csv > data3.1

for x in *.1
do
	cont=1
	backIFS=$IFS
	while IFS='' read -r linea || [[ -n "$linea" ]]
	do
		nombre=${x%%.*}
		letra=${linea:0:1}	
		echo $linea > line.csv
		colrm 1 2 < line.csv | sed 's/,/\n/g' > division.csv		
		for valor in $(cat division.csv)
		do
			echo "$nombre.csv,$cont,$letra,$valor"
		done		
		cont=$((cont + 1))		
	done < $x
	IFS=$backIFS
done

rm *.1
rm division.csv
rm line.csv
