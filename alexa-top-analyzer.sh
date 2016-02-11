FILE=$1

NUMBER_OF_COLUMNS="$(wc -l $FILE | awk -F' ' '{print $1}')"
NUMBER_OF_ROWS=$NUMBER_OF_COLUMNS
YVALUES=($(cat $FILE | cut -d"," -f2 ))

#for ((j=0; j < NUMBER_OF_ROWS; j++))
#do
#	echo "${YVALUES[$j]}"
#done

MMIN="$(cat $FILE | cut -d"," -f2 | sort -n | head -1)"
MMAX="$(cat $FILE | cut -d"," -f2 | sort -nr | head -1)"

STEPSIZE=$(( (MMAX - MMIN) / NUMBER_OF_ROWS ))

echo "Your Alexa Top worst rank: "$MMAX
echo "Your Alexa Top best rank: "$MMIN
echo ""


for (( i=0; i <= $NUMBER_OF_ROWS; i++ )) #y-axis
do
	VALUE=$(( MMAX - STEPSIZE * ($NUMBER_OF_ROWS - $i) ))

	CUR=$(( $NUMBER_OF_ROWS - 1 - $i ))
	if [[ $CUR -lt 0 ]];
		then
			printf "%-11s" $VALUE" ~~~~ "
	else
		printf "%-11s" $VALUE"      "
	fi

	for ((j=0; j <= $NUMBER_OF_COLUMNS; j++)) #x-axis
	do
		STEPS=$(( (${YVALUES[$j]} - MMIN ) * NUMBER_OF_ROWS / (MMAX - MMIN) ))

		if [[ $STEPS -lt $i ]]; 
		then
			echo -n ".*."
		else
			echo -n "   "
		fi
	done
	echo ""
done

TMP=${#MMAX}

for (( j = 0; j < 3; j++ )); 
do
	for (( i=0; i <= $TMP; i++  ))
	do
		echo -n " "
	done
	printf "%-$((10-$TMP))s"  "~~~~ "
	for (( i=0; i <= $NUMBER_OF_COLUMNS; i++ ))
	do
		echo -n ".*."
	done
	echo ""
done

echo ""
