Month="$1"
day="$2"
year="$3"
if [ $# -ne 3 ]; then
  echo "잘못된 입력입니다. 프로그램을 종료합니다."
  exit 1
fi

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
    day=31;;
    FEBRUARY)
    day=29;;
    MARCH)
    day=31;;
    APRIL)
    day=30;;
    MAY)
    day=31;;
    JUNE)
    day=30;;
    JULY)
    day=31;;
    AUGUST)
    day=31;;
    SEPTEMBER)
    day=30;;
    OCTOBER)
    day=31;;
    NOVEMBER)
    day=30;;
    DECEMBER)
    day=31;;
    *)
  esac
    
else
  echo "$year은 윤년이 아닙니다."
fi

echo "$Month $day $year"

    