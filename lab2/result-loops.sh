#!/bin/bash
# Разбор аргументов
while getopts "n:" opt; do
  case $opt in
    n) number="$OPTARG" ;;
    *) echo "Использование: $0 -n <число>"; exit 1 ;;
  esac
done
# Проверка ввода
if ! [[ "$number" =~ ^[0-9]+$ ]] || [ "$number" -lt 1 ]; then
  echo "Ошибка: Введите положительное целое число." > /home/lab2/results/result_loops.txt
  exit 1
fi
# Вычисление последовательности Фибоначчи
a=0
b=1
fibonacci="$a $b"
while true; do
  next=$((a + b))
  if [ "$next" -gt "$number" ]; then
    break
  fi
  fibonacci="$fibonacci $next"
  a=$b
  b=$next
done
# Запись в файл
echo "Последовательность Фибоначчи до $number: $fibonacci" > /home/lab2/results/result_loops.txt
echo "Результат сохранен в /home/lab2/results/result_loops.txt"
