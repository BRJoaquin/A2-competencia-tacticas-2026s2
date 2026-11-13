# Ejercicio 0 - Calentamiento

> Este ejercicio **no cuenta** para la competencia. Sirve para comprobar, antes
> de empezar, que la computadora del grupo compila y corre las pruebas.

## Problema

Dado un array de `N` números enteros, devolver la suma de todos.

## Qué hay que programar

En `main.cpp`, escribir el programa completo: **leer la entrada** (por `cin`),
resolver cada caso e **imprimir la salida** (por `cout`), con el formato que se
describe más abajo.

El `main` está vacío. Pueden agregar todas las funciones que necesiten.

> La suma puede ser más grande que lo que entra en un `int`: usen `long long`.

## Orden pedido

`O(N)` en tiempo.

## Formato de entrada

La primera línea tiene `P`, la cantidad de casos. Cada caso tiene dos líneas:
la primera con `N` y la segunda con los `N` números.

- `1 <= N <= 200.000`
- `-1.000.000.000 <= numero <= 1.000.000.000` (por eso la suma necesita `long long`)

## Formato de salida

Una línea por caso, con la suma.

## Cómo leer la entrada

Este es el esquema que sirve para **todos** los ejercicios de la competencia:

```cpp
int casos;
cin >> casos;
for (int i = 0; i < casos; i++)
{
    int n;
    cin >> n;
    int *arr = new int[n];
    for (int j = 0; j < n; j++)
    {
        cin >> arr[j];
    }

    // resolver el caso e imprimir la respuesta con cout << ... << endl;

    delete[] arr;
}
```

## Ejemplo

Entrada:

```
2
3
1 2 3
4
10 -5 0 7
```

Salida:

```
6
12
```

## Cómo probarlo

Desde la raíz del repositorio:

```bash
./probar.sh 0
```
