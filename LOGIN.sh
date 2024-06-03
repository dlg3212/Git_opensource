#!/bin/bash

#유저 이름 입력받기
user="$1"

# 인수 갯수 확인
if [ $# -ne 1 ]
then
echo "1개의 인수만 입력해주세요, 프로그램을 종료합니다."
exit 1
fi

#who명령에서 유저 이름만 추출해 login.txt로 저장 (replit에서 who 명령 결과가 안보여서 확인불가)
cut -d" " -f1 "$(who)" > login.txt 

#login.txt에 줄 수가 반복문으로 검사할 횟수
number=$(wc -l login.txt)


#반복문 횟수 세기
count=0

#교수님께서 sleep을 알려주신 이유가 무한 반복문에서 부하를 줄이기 위해서라고 생각해
#무한루프 사용해 보았습니다.

#무한 루프
while true
do
	#파일 검사 시작
	for var in $(cat login.txt)
		do
		#반복문 시작 count 1증가
		(count++)
		#파일에 있는 이름과 입력한 유저이름이 같으면 출력후 종료
		if [ $var = $user ]
		then
			echo "$user 로그인함!"
			exit 2
		#파일을 끝까지 검사했을 때 없다면 검사 for문 종료
		elif [ $((count)) -ge $((number)) ]
		then
			echo "현재 로그인 하지 않았습니다."
			count=0
			break
		fi
		done
	#제 검사 여부 물어보기
	echo "60초후에 다시 검사하시겠습니까? \(Y|N\)"
	echo "잘못된 입력시 프로그램을 종료합니다."
	#Y/N 입력 받기
	read check
	#N이면 프로그램 종료
	if [ $check = "N" ]
	then
		echo "프로그램을 종료합니다."
		exit 3
	#Y이면 60초후 재검사
	elif [ $check = "Y" ]
	then
		echo "60초 대기모드로 들어갑니다."
		echo "강제 종료를 원하시면 ctrl+c를 입력해주세요."
		sleep 60
	#잘못된 입력이면 프로그램 종료
	else
		echo "잘못된 입력입니다. 프로그램을 종료합니다."
		exit 4
	fi
done