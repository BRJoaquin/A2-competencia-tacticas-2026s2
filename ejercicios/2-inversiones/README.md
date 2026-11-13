# Ejercicio 2 - Ranking desordenado

**Táctica sugerida:** dividir y conquistar.

## Problema

Una plataforma de música quiere medir qué tan parecidos son los gustos de dos
personas. Para eso toma el ranking de canciones de una persona y lo escribe
usando las posiciones del ranking de la otra. Si las dos personas piensan
exactamente igual, el resultado es un array ordenado de menor a mayor. Cuanto
más desordenado está el array, más distintos son los gustos.

El "desorden" se mide contando **inversiones**. Una inversión es un par de
posiciones `(i, j)` tal que:

- `i < j`, y
- `arr[i] > arr[j]`

Es decir: dos elementos que están "al revés" entre sí, el más grande antes que
el más chico. **No** hace falta que estén uno al lado del otro.

Por ejemplo, el array `2 4 1 3 5` tiene 3 inversiones:

```
2 4 1 3 5
^   ^          el 2 está antes que el 1
  ^ ^          el 4 está antes que el 1
  ^   ^        el 4 está antes que el 3
```

Dado un array, se quiere saber **cuántas inversiones tiene**.

La historia es solo el contexto. Los números del array pueden ser cualquier
entero entre 1 y 1.000.000.000, y se pueden repetir.

## Qué hay que programar

En `main.cpp`, escribir el programa completo: **leer la entrada** (por `cin`),
resolver cada caso e **imprimir la salida** (por `cout`), con el formato que se
describe más abajo.

El `main` está vacío. Pueden agregar todas las funciones que necesiten.

- Puede haber números **repetidos**.
- Dos elementos iguales **no** forman una inversión.

> **Ojo con el tipo de dato.** Con `N = 200.000` puede haber cerca de
> 20.000.000.000 inversiones. Ese número no entra en un `int`: usen `long long`
> para contar.

## Orden pedido

`O(N log N)` en tiempo.

Comparar todos los pares es `O(N²)` y no pasa los casos grandes.

## Pista

Piensen en **MergeSort**. Cuando se intercalan dos mitades ordenadas y se toma
un elemento de la mitad derecha antes que uno de la izquierda, ¿con cuántos
elementos de la mitad izquierda está "al revés"?

En `helpers/MergeSort.cpp` hay un MergeSort implementado. Pueden leerlo para
recordar cómo es, y escribir el suyo en `main.cpp`.

## Formato de entrada

La primera línea tiene `P`, la cantidad de casos. Cada caso tiene dos líneas:

```
N
arr_1 arr_2 ... arr_N
```

Límites (los de `N`, valores y largos son para **cada** caso):

- `1 <= P <= 1.000`
- `1 <= N <= 200.000`
- `1 <= arr_i <= 1.000.000.000`

## Formato de salida

Una línea por caso, con la cantidad de inversiones.

## Ejemplo

Entrada:

```
4
5
2 4 1 3 5
4
1 2 3 4
4
4 3 2 1
3
3 3 1
```

Salida:

```
3
0
6
2
```

Explicación:

- **Caso 1.** Es el ejemplo de arriba. Los pares de valores al revés son
  `(2,1)`, `(4,1)` y `(4,3)`.
- **Caso 2.** El array está ordenado: no hay inversiones.
- **Caso 3.** El array está totalmente al revés: todos los pares son
  inversiones. Con 4 elementos hay `4·3/2 = 6` pares.
- **Caso 4.** Cada `3` forma una inversión con el `1`. Los dos `3` entre sí no
  forman inversión porque son iguales.

## Cómo probarlo

Desde la raíz del repositorio:

```bash
./probar.sh 2
```
