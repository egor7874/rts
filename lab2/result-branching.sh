#!/bin/bash
while getopts "n:" opt; do
  case $opt in
    n) number="$OPTARG" ;;
    *) echo "Использование: $0 -n <число>"; exit 1 ;;
  esac
done
# Проверка ввода
if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
  echo "Ошибка: Введите целое число." > /home/lab2/results/result_branching.txt
  exit 1
fi
# Проверка делимости
if (( number % 3 == 0 && number % 5 == 0 )); then
  result="Число $number делится на 3 и 5."
elif (( number % 3 == 0 )); then
  result="Число $number делится на 3."
elif (( number % 5 == 0 )); then
  result="Число $number делится на 5."
else
  result="Число $number не делится на 3 и 5."
fi
# Запись в файл
echo "$result" > /home/lab2/results/result_branching.txt
echo "Результат сохранен в /home/lab2/results/result_branching.txt"
