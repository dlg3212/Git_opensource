#!/bin/bash

name="$1"
number="$2"

check=$(echo $number | wc -c)

# 입력 이름  확인 
if [ -z $name ]
then
echo "이름을 입력해주세요. 프로그램을 종료합니다."
echo "오류코드 $?"
exit 1
fi

# 입력 번호 확인
case $number in
  [0-9]*)
  ;;
  *)
  echo "숫자가 아닙니다. 프로그램을 종료합니다."
  exit 2
  echo "오류코드 $?"
esac

#전화번호에 - 있는지 확인 ex)010-0000-0000
String_check=$(echo $number | grep "-")

# - 포함되어 있다면 지역번호 확인을 위해 앞 3자리만 자르기
if [ ! -z $String_check ]
then 
  first=$(echo $number | cut -c1-3)
  include=1

# - 포함되어 있지 않다면 길이 수에 맞게 3 4 4 or 3 3 4 or 2 3 4 로 자르기
# ex) 010-0000-0000 or 042-000-0000 or 02-000-0000
elif [ $check -eq 12 ]
then
  first=$(echo $number | cut -c1-3)
  second=$(echo $number | cut -c4-7)
  last=$(echo $number | cut -c8-11)
elif [ $check -eq 11 ]
then
  first=$(echo $number | cut -c1-3)
  second=$(echo $number | cut -c4-6)
  last=$(echo $number | cut -c7-10)
elif [ $check -eq 10 ]
then
  first=$(echo $number | cut -c1-2)
  second=$(echo $number | cut -c3-5)
  last=$(echo $number | cut -c6-9)

# 번호의 길이가 맞지 않다면 프로그램 종료
else
  echo "번호의 길이가 유효하지 않습니다."
  echo "오류코드 $?"
  exit 2
fi

# 지역번호 확인
case $first in
  02)
  region="서울";;
  051)
  region="부산";;
  053)
  region="대구";;
  032)
  region="인천";;
  062)
  region="광주";;
  042)
  region="대전";;
  044)
  region="세종";;
  031)
  region="경기도";;
  033)
  region="강원도";;
  010)
  region="핸드폰";;
  *)
  # 번호의 길이는 맞으나 지역번호가 맞지 않다면 인식 X로 표기
  region="인식 X"
esac

# 만약 등록된 정보가 아무것도 없다면 바로 저장
if [ ! -s Phone.txt ]
then
  if [ $((include)) -eq 1 ]

  # 번호에 - 포함되어 있다면 그대로 저장
  then
    echo "$name $number $region" >> Phone.txt
  else # 아닐 경우 위에서 자른 값으로 - 연결해서 저장
    echo "$name $first-$second-$last $region" >> Phone.txt
  fi
  echo "등록되었습니다."
else # 등록되어 있을 경우 등록된 정보랑 비교
  for var in $(cat Phone.txt | cut -d" " -f1)
  do
    if [ $name = $var ]
    then
      same=1
      for Phone in $(cat Phone.txt | cut -d" " -f2)
      do
        if [ "$first-$second-$last" = $Phone ] || [ $number = $Phone ]
        then #만약 이름과 전화번호가 같다면 등록하지 않기 위해 same과 count 값 변경
          same=2
          count=1
          break
          #반복문 나가기
        else # 아니면 등록을 위해 count 값 변경
          count=2
        fi    
      done
    else # 만약 이름이 같지 않다면 등록하기 위해 same 값 변경
      same=1
    fi
  done
fi

# 등록되어 있다면 등록하지 않음
if [ $((count)) -eq 1 ] || [ $((same)) -eq 2 ]
then
  echo "이미 등록되어 있습니다. 프로그램을 종료합니다."
  exit 3
# 등록되어 있지 않다면 등록
elif [ $((count)) -eq 2 ] || [ $((same)) -eq 1 ]
then
  # - 가 포함되어 있다면 number값 그대로 저장 
  if [ $((include)) -eq 1 ]
  then
    echo "$name $number $region" >> Phone.txt
  else
  # 아닐 경우 위에서 자른 값을 - 연결해서 저장 
    echo "$name $first-$second-$last $region" >> Phone.txt
  fi
  echo "등록되었습니다."
  # 등록 완료후 정렬
  sort < Phone.txt > temp
  cat temp > Phone.txt
fi
