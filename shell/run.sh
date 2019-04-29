#!/bin/bash

FILE_OUTPUT="run318.csv"
TSPFILE="--tsplibfile tsp/lin318.tsp"
OPTIMUM="--optimum 42029"
ANTNUM="-m 300"
OTHEROPT="--time 86400. --rho 0.1 --q0 0.9 "

#Initialize the Log File.

for method in "as" "eas" "ras" "mmas" "bwas" "acs" "levyflight" "contribution";
do
	mkdir -p ./result/${method}/
	rm -f ./result/${method}/${FILE_OUTPUT}
	for i in {1..100}
	do
		if [ "${method}" == "levyflight" ]
		then
			./acotsp --quiet ${TSPFILE} ${OPTIMUM} ${ANTNUM} ${OTHEROPT} --as -L 0.8,3 2>> ./result/${method}/${FILE_OUTPUT}
		elif [ "${method}" == "contribution" ]
		then
			./acotsp --quiet ${TSPFILE} ${OPTIMUM} ${ANTNUM} ${OTHEROPT} --as -C 2 2>> ./result/${method}/${FILE_OUTPUT}
		else
			./acotsp --quiet ${TSPFILE} ${OPTIMUM} ${ANTNUM} ${OTHEROPT} --${method} 2>> ./result/${method}/${FILE_OUTPUT}
		fi
	done
done

