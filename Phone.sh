#!/bin/bash

name="$1"
number="$2"

check=$(echo $number | wc -c)

case $number in
  [0-9]*)
  echo "숫자입니다."
  ;;
  *)
  echo "숫자가 아닙니다"
esac

if [ $check -eq 12 ]
then
first=$(echo $number | cut -c1-3)
second=$(echo $number | cut -c4-7)
last=$(echo $number | cut -c8-12)
elif [ $check -eq 11 ]
then
first=$(echo $number | cut -c1-3)
second=$(echo $number | cut -c4-7)
last=$(echo $number | cut -c8-11)
elif [ $check -eq 10 ]
then
first=$(echo $number | cut -c1-2)
second=$(echo $number | cut -c3-6)
last=$(echo $number | cut -c7-10)
fi

case $first in
  [0-9]\{1,3\}|[0-9]\{1,2\})
  ;;
  *)
  echo "숫자를 입력해주세요."
  exit 5
esac
case $second in
  [0-9]\{1,4\}|[0-9]\{1,3\})
  ;;
  *)
  echo "숫자를 입력해주세요."
  exit 5
esac

case $last in
  [0-9]\{1,4\})
  echo "숫자";;
  *)
  echo "숫자를 입력해주세요"
  exit 5
esac

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
  region="경기";;
  033)
  region="강원";;
  010)
  region="핸드폰";;
  *)
  region="인식 X"
esac

if [ ! -s Phone.txt ]
then
  echo "$name $number" >> Phone.txt
  echo "등록되었습니다."
else
  for var in $(cat Phone.txt | cut -d" " -f1)
  do
    if [ $name = $var ]
    then
      same=1
      for Phone in $(cat Phone.txt | cut -d" " -f2)
      do
        if [ $number = $Phone ]
        then
          same=2
          count=1
          break
        else
          count=2
        fi    
      done
      else 
        same=1
    fi
  done
fi


if [ $((count)) -eq 1 ] || [ $((same)) -eq 2 ]
then
echo "이미 등록되어 있습니다."
exit 1
elif [ $((count)) -eq 2 ] || [ $((same)) -eq 1 ]
then
echo "$name $first-$second-$last $region" >> Phone.txt
echo "등록되었습니다."
sort < Phone.txt > temp
cat temp > Phone.txt
fi
