Month="$1"
day="$2"
year="$3"

if [ $# -ne 3 ]; then
echo "입력값 오류"
exit 1
fi

case $Month in
  1|jan|january|JAN|Jan|jAN|jAn|jaN|JANUARY|January)
    Month=Jan;;
  2|feb|february|FEB|Feb|fEB|feB|fEb|FEBRUARY|February)
    Month=Feb;;
  3|mar|march|MAR|Mar|mAR|maR|mAr|MARTH|March)
    Month=Mar;;
  4|apr|april|APR|Apr|aPR|apR|aPr|APRIL|April)
    Month=Apr;;
  5|may|MAY|May|mAY|maY|mAy)
    Month=May;;
  6|jun|june|JUN|Jun|jUN|juN|jUn|JUNE|June) 
    Month=Jun;;
  7|jul|july|JUL|Jul|jUL|juL|jUl|JULY|July)
    Month=Jul;;
  8|aug|august|AUG|Aug|aUG|auG|aUg|AUGUST|August)
    Month=Aug;;
  9|sep|september|SEP|Sep|sEP|seP|sEp|SEPTEMBER|September)
    Month=Sep;;
  10|oct|october|OCT|Oct|oCT|ocT|oCt|OCTOBER|October)
    Month=Oct;;
  11|nov|november|NOV|Nov|nOV|noV|nOv|NOVEMBER|November)
    Month=Nov;;
  12|dec|december|DEC|Dec|dEC|deC|dEc|DECEMBER|December)
    Month=Dec;;
  *)
    echo "달을 잘못 입력하셨습니다."
    exit 2

esac

case $Month in
  Jan)
  date=31;;
  Feb)
  date=28;;
  Mar)
  date=31;;
  Apr)
  date=30;;
  May)
  date=31;;
  Jun)
  date=30;;
  Jul)
  date=31;;
  Aug)
  date=31;;
  Sep)
  date=30;;
  Oct)
  date=31;;
  Nov)
  date=30;;
  Dec)
  date=31;;
  *)
esac

if [ $((year%4)) -ne 0 ]; then
  leap_year="$year년은 윤년이 아닙니다."
elif [ $((year%400)) -eq 0 ]; then
  leap_year="$year년은 윤년이므로 FEB는 29일까지 있습니다."
  if [ $Month = Feb ]; then
  date=29
  fi
elif [ $((year%100)) -eq 0 ]; then
  leap_year="$year년은 윤년이 아닙니다."
else
   leap_year="$year년은 윤년이므로 FEB는 29일까지 있습니다."
fi

if [ $((day)) -gt $((date)) ]; then
  echo "입력하신 날짜가 그 달의 마지막 날 보다 큽니다."
  echo "입력 날짜: $day는 유효하지 않습니다."
  exit 3
elif [ $((day)) -lt 1 ]; then
  echo "입력하신 날짜가 1보다 작습니다."
  echo "입력 날짜: $day는 유효하지 않습니다."
  exit 4
fi


echo "$leap_year"
echo "$Month $day $year"
