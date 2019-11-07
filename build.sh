#!/bin/sh
echo "###############"
echo "#    LATEST   #"
echo "###############"
docker build -t clairtonluz/codeigniter .

echo "###############"
echo "#  ORACLE-11  #"
echo "###############"
cd oracle-11
docker build -t clairtonluz/codeigniter:oracle-11 .

echo "###############"
echo "#  ORACLE-12  #"
echo "###############"
cd ../oracle-12
docker build -t clairtonluz/codeigniter:oracle-12 .
cd ..