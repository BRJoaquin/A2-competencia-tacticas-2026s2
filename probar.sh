#!/bin/bash
#
# Compila y prueba un ejercicio de la competencia.
#
#   ./probar.sh 3        prueba el ejercicio 3
#   ./probar.sh todos    prueba todos y muestra cuantos estan resueltos
#
# Un ejercicio esta resuelto solo si este script muestra ACEPTADO.

cd "$(dirname "$0")" || exit 1

LIMITE_POR_DEFECTO=10 # segundos por archivo de prueba
PROHIBIDOS='vector|algorithm|list|forward_list|deque|queue|stack|map|set|unordered_map|unordered_set|array|bits/stdc\+\+\.h'
BUILD=./build

if [ -t 1 ]; then
  ROJO=$'\033[31m'; VERDE=$'\033[32m'; AMARILLO=$'\033[33m'; NEGRITA=$'\033[1m'; FIN=$'\033[0m'
else
  ROJO=""; VERDE=""; AMARILLO=""; NEGRITA=""; FIN=""
fi

uso() {
  echo "Uso: ./probar.sh <numero de ejercicio>   (ejemplo: ./probar.sh 1)"
  echo "     ./probar.sh todos"
  echo
  echo "Ejercicios disponibles:"
  for dir in ejercicios/*/; do
    echo "  $(basename "$dir")"
  done
}

# Corre un comando con un tope de tiempo (funciona en Linux, WSL y Mac).
# Devuelve 124 si llego al tope.
correrConLimite() {
  local segundos=$1
  shift
  if command -v timeout >/dev/null 2>&1; then
    timeout -k 1 "$segundos" "$@"
  elif command -v gtimeout >/dev/null 2>&1; then
    gtimeout -k 1 "$segundos" "$@"
  else
    perl -e 'alarm shift; exec @ARGV' "$segundos" "$@"
    local codigo=$?
    [ $codigo -eq 142 ] && return 124
    return $codigo
  fi
}

# Saca \r, espacios al final de cada linea y lineas vacias, para comparar.
normalizar() {
  tr -d '\r' < "$1" | sed -e 's/[[:space:]]*$//' | grep -v '^$'
}

mostrarArchivo() {
  local titulo=$1 archivo=$2
  echo "${NEGRITA}--- $titulo ---${FIN}"
  if [ "$(wc -c < "$archivo")" -le 1500 ]; then
    cat "$archivo"
    echo
  else
    echo "(es muy grande para mostrarlo, mirar el archivo: $archivo)"
  fi
}

# Prueba un ejercicio. Devuelve 0 si fue ACEPTADO.
probarEjercicio() {
  local numero=$1
  local dir="" candidato
  for candidato in ejercicios/"$numero"-*/; do
    [ -d "$candidato" ] && dir=$candidato && break
  done
  if [ -z "$dir" ]; then
    echo "${ROJO}No existe el ejercicio '$numero'.${FIN}"
    uso
    return 2
  fi
  dir=${dir%/}
  local nombre
  nombre=$(basename "$dir")
  local fuente="$dir/main.cpp"
  local ejecutable="$BUILD/$nombre.out"
  local salida="$BUILD/$nombre.salida.txt"
  local limite=$LIMITE_POR_DEFECTO
  [ -f "$dir/limite.txt" ] && limite=$(tr -d '[:space:]' < "$dir/limite.txt")

  echo "${NEGRITA}== Ejercicio $nombre ==${FIN}"

  # 1) librerias prohibidas
  local usoProhibido
  usoProhibido=$(grep -nE "^[[:space:]]*#[[:space:]]*include[[:space:]]*[<\"]($PROHIBIDOS)[>\"]" "$fuente")
  if [ -n "$usoProhibido" ]; then
    echo "${ROJO}NO ACEPTADO: se usa una libreria prohibida en $fuente${FIN}"
    echo "$usoProhibido"
    echo "Se puede usar lo que esta en las carpetas adts/ y helpers/."
    return 1
  fi

  # 2) compilacion
  mkdir -p "$BUILD"
  if ! g++ --std=c++11 -O2 "$fuente" -o "$ejecutable"; then
    echo "${ROJO}NO ACEPTADO: error de compilacion${FIN}"
    return 1
  fi

  # 3) casos de prueba
  local total=0 entrada esperado caso codigo tiempo linea
  local TIMEFORMAT=%R
  for entrada in "$dir"/tests/*.in.txt; do
    [ -f "$entrada" ] || continue
    esperado=${entrada%.in.txt}.out.txt
    caso=$(basename "$entrada" .in.txt)
    total=$((total + 1))

    # El tope es mayor que el limite: asi un programa que se cae (y tarda en
    # cerrarse) se informa como ERROR EN EJECUCION y no como TIEMPO EXCEDIDO.
    tiempo=$( { time correrConLimite $((limite + 3)) "$ejecutable" < "$entrada" > "$salida" 2> "$BUILD/$nombre.errores.txt"; } 2>&1 )
    codigo=$?
    tiempo=${tiempo/,/.}

    # 124: llego al tope. 137: hubo que matarlo. 0: termino bien, pero tarde.
    if [ $codigo -eq 124 ] || { { [ $codigo -eq 0 ] || [ $codigo -eq 137 ]; } && awk "BEGIN { exit !($tiempo > $limite) }"; }; then
      echo "  archivo $caso: ${ROJO}TIEMPO EXCEDIDO${FIN} (mas de $limite segundos)"
      echo "${ROJO}NO ACEPTADO${FIN}: la solucion es demasiado lenta. Revisar el orden pedido en el README."
      echo "Entrada del archivo: $entrada"
      return 1
    elif [ $codigo -ne 0 ]; then
      echo "  archivo $caso: ${ROJO}ERROR EN EJECUCION${FIN} (el programa se cayo, codigo $codigo)"
      grep -v '^timeout: ' "$BUILD/$nombre.errores.txt"
      echo "${ROJO}NO ACEPTADO${FIN}"
      echo "Entrada del archivo: $entrada"
      return 1
    elif ! diff <(normalizar "$esperado") <(normalizar "$salida") >/dev/null; then
      echo "  archivo $caso: ${ROJO}RESPUESTA INCORRECTA${FIN}"
      mostrarArchivo "Entrada" "$entrada"
      mostrarArchivo "Salida esperada" "$esperado"
      mostrarArchivo "Tu salida" "$salida"
      # Primera linea distinta, sin contar lineas vacias.
      linea=$(paste <(normalizar "$esperado") <(normalizar "$salida") | awk -F '\t' '$1"" != $2"" { print NR; exit }')
      if [ -n "$linea" ]; then
        echo "${NEGRITA}--- Primera diferencia: linea $linea de la salida ---${FIN}"
        echo "  esperado: $(normalizar "$esperado" | sed -n "${linea}p")"
        echo "  obtenido: $(normalizar "$salida" | sed -n "${linea}p")"
        echo "  (un valor vacio significa que una salida tiene menos lineas que la otra)"
      fi
      echo "${ROJO}NO ACEPTADO${FIN}"
      return 1
    fi
    echo "  archivo $caso: ${VERDE}OK${FIN}"
  done

  if [ $total -eq 0 ]; then
    echo "${ROJO}No hay archivos de prueba en $dir/tests${FIN}"
    return 2
  fi

  echo
  echo "${VERDE}${NEGRITA}  ACEPTADO  ${FIN}${VERDE} ejercicio $nombre - $total/$total archivos - $(date +%H:%M:%S)${FIN}"
  return 0
}

if [ $# -ne 1 ]; then
  uso
  exit 2
fi

if [ "$1" = "todos" ]; then
  resueltos=0
  cantidad=0
  resumen=""
  for dir in ejercicios/*/; do
    nombre=$(basename "$dir")
    numero=${nombre%%-*}
    cantidad=$((cantidad + 1))
    if probarEjercicio "$numero"; then
      resueltos=$((resueltos + 1))
      resumen="$resumen  ${VERDE}ACEPTADO${FIN}     $nombre\n"
    else
      resumen="$resumen  ${ROJO}NO ACEPTADO${FIN}  $nombre\n"
    fi
    echo
  done
  echo "${NEGRITA}== Resumen - $(date +%H:%M:%S) ==${FIN}"
  printf "%b" "$resumen"
  echo "${NEGRITA}Resueltos: $resueltos de $cantidad${FIN}"
  exit 0
fi

probarEjercicio "$1"
exit $?
