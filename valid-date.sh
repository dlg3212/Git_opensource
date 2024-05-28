Month="$1"
day="$2"
year="$3"

case $Month in
  1|jan|january|JAN)
    Month=JANUARY;;
  2|feb|february|FEB)
    Month=FEBRUARY;;
  3|mar|march|MAR)
    Month=MARCH;;
  4|apr|april|APR)
    Month=APRIL;;
  5|may|MAY)
    Month=MAY;;
  6|jun|june|JUN) 
    Month=JUNE;;
  7|jul|july|JUL)
    Month=JULY;;
  8|aug|august|AUG)
    Month=AUGUST;;
  9|sep|september|SEP)
    Month=SEPTEMBER;;
  10|oct|october|OCT)
    Month=OCTOBER;;
  11|nov|november|NOV)
    Month=NOVEMBER;;
  12|dec|december|DEC)
    Month=DECEMBER;;
  *)
    echo "달을 잘못 입력하셨습니다. 프로그램을 종료합니다."
    exit 1
esac

if [ $((year%4)) -ne 0 ] && [ $((year%100)) -ne 0 ]; then
  echo "$year은 윤년이 아닙니다."
elif [ $((year%400)) -eq 0 ]; then
  echo "$year은 윤년입니다."
  case $Month in
    JANUARY)
    date=31;;
    FEBRUARY)
    date=29;;
    MARCH)
    date=31;;
    APRIL)
    date=30;;
    MAY)
    date=31;;
    JUNE)
    date=30;;
    JULY)
    date=31;;
    AUGUST)
    date=31;;
    SEPTEMBER)
    date=30;;
    OCTOBER)
    date=31;;
    NOVEMBER)
    date=30;;
    DECEMBER)
    date=31;;
    *)
  esac
    
else
  echo "$year은 윤년이 아닙니다."
fi

if [ $# -ne 3 ]; then
  echo "입력값 오류"
  exit 1
elif [ ${day} -gt ${date} ] || [ ${day} -lt 0 ]; then
  echo "입력값 오류"  
fi

echo "$Month $day $year"
