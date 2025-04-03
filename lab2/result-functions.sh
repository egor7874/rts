#!/bin/bash
# Разбор аргументов
while getopts "n:" opt; do
  case $opt in
    n) number="$OPTARG" ;;
    *) echo "Использование: $0 -n <число>"; exit 1 ;;
  esac
done
# Проверка ввода
if ! [[ "$number" =~ ^[0-9]+$ ]] || [ "$number" -lt 2 ]; then
  echo "Ошибка: Введите целое число больше 1." > /home/lab2/results/result_functions.txt
  exit 1
fi
# Функция проверки простого числа
is_prime() {
  local num=$1
  for ((i = 2; i * i <= num; i++)); do
    if ((num % i == 0)); then
      echo "Число $num не является простым."
      return
    fi
  done
  echo "Число $num является простым."
}
# Проверка числа и запись в файл
result=$(is_prime "$number")
echo "$result" > /home/lab2/results/result_functions.txt
echo "Результат сохранен в /home/lab2/results/result_functions.txt"
