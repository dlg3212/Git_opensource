#!/bin/bash

user="$1"

if [ $# -ne 1 ]
then
echo "1개의 인수만 입력해주세요, 프로그램을 종료합니다."
exit 1
fi

String=$(who)


for var in $check
do
echo "$check"
if [ $var = $user ]
then
	echo "$user 로그인함!"
	break
fi
done
 

