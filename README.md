# Competencia de Tácticas - Algoritmos 2

Simulacro de concurso de programación sobre las tácticas del curso:
**greedy**, **dividir y conquistar**, **programación dinámica** y **backtracking**.

## Cómo se gana

- Hay **5 ejercicios**. Duración: **2 horas**.
- Gana **el primer grupo que tenga 3 ejercicios ACEPTADOS**. En ese momento
  termina la competencia.
- Los ejercicios se pueden hacer en cualquier orden. Lean los cinco antes de
  elegir: no están ordenados por dificultad.
- Un ejercicio está resuelto **solo** si `./probar.sh` muestra `ACEPTADO`.
  Eso significa que pasó **todos** los archivos de prueba dentro del tiempo.
- No hay penalización por intentos fallidos. Prueben todas las veces que quieran.

### Si nadie llega a 3 ejercicios

Si pasan las 2 horas y ningún grupo tiene 3 ejercicios:

1. Gana el grupo con **más ejercicios** aceptados.
2. Si hay empate en cantidad, gana el grupo con **menor tiempo acumulado**.

El **tiempo acumulado** es la suma, para cada ejercicio aceptado, de los minutos
que pasaron **desde el inicio de la competencia** hasta que el docente lo
verificó.

Ejemplo: dos grupos terminan con 2 ejercicios cada uno.

| Grupo | Primer aceptado | Segundo aceptado | Tiempo acumulado |
|---|---|---|---|
| A | minuto 20 | minuto 95 | 20 + 95 = **115** |
| B | minuto 50 | minuto 70 | 50 + 70 = **120** |

Gana el grupo **A**, aunque el grupo B terminó su segundo ejercicio antes.
Conclusión: conviene avisar cada ejercicio **apenas** queda aceptado.

## Reglas

1. **Una sola computadora por grupo.**
2. **Sin internet.** Ni buscador, ni documentación online, ni repositorios.
3. **Sin inteligencia artificial.** Ni chats, ni autocompletado con IA
   (Copilot, Cursor, etc. deben estar apagados).
4. **Sin material.** Solo este repositorio.
5. **Solo C++**, compilado con `g++ --std=c++11`.
6. **No se puede usar** `vector`, `sort`, ni los contenedores o algoritmos de la
   librería estándar (`<vector>`, `<algorithm>`, `<list>`, `<queue>`, `<stack>`,
   `<map>`, `<set>`...). El script rechaza la entrega si los encuentra.
7. **Sí se puede usar** todo lo que está en las carpetas [`adts/`](adts) y
   [`helpers/`](helpers), además de `<iostream>`, `<string>`, `<limits>`,
   `<climits>`, `<cassert>` y arrays comunes.
8. No se modifican los casos de prueba ni `probar.sh`.

El código del grupo ganador se revisa antes de confirmar el resultado.

**Las letras se leen solas.** Cada ejercicio tiene en su `README.md` el problema,
el formato, los límites y ejemplos explicados. Si algo de una letra no se
entiende, pueden preguntarle a un docente: se responden **dudas de letra**
(qué se pide, el formato, un ejemplo). No se responden preguntas sobre cómo
resolver un ejercicio, y las letras no traen pistas. Si el script muestra
`RESPUESTA INCORRECTA`, comparen lo esperado con lo obtenido y vuelvan a leer la
letra.

## Paso a paso

### 1. Bajar el repositorio

```bash
git clone <URL que muestra el docente>
cd <carpeta del repositorio>
```

Después de esto, **apagar el wifi**.

### 2. Comprobar que todo funciona (ejercicio 0)

El ejercicio 0 no cuenta. Sirve para comprobar que la computadora compila y corre
las pruebas, y para practicar el formato de entrada y salida.

```bash
./probar.sh 0
```

Tiene que mostrar `RESPUESTA INCORRECTA` (todavía no está resuelto). Resuelvan
`ejercicios/0-calentamiento/main.cpp` y vuelvan a correrlo hasta ver `ACEPTADO`.

> Si aparece `permission denied`, correr `chmod +x probar.sh`.
> En Windows hay que usar **WSL**. En Mac y Linux funciona directo en la terminal.

### 3. Resolver un ejercicio

Cada ejercicio está en una carpeta dentro de [`ejercicios/`](ejercicios):

```
ejercicios/1-nombre/
├── README.md     la letra, el formato, el orden pedido y ejemplos
├── main.cpp      acá se programa (el main está vacío)
└── tests/        archivos de prueba (entrada .in.txt y salida esperada .out.txt)
```

Igual que en el obligatorio, el programa **lee la entrada por `cin`** e
**imprime la salida por `cout`**. Todos los ejercicios tienen la misma forma:
la primera línea trae la cantidad de casos, y después viene cada caso.

```cpp
int main()
{
    int casos;
    cin >> casos;
    for (int i = 0; i < casos; i++)
    {
        // leer un caso
        // resolverlo
        // imprimir la respuesta, seguida de un salto de línea
    }
    return 0;
}
```

### 4. Probar

Desde la raíz del repositorio:

```bash
./probar.sh 1        # prueba el ejercicio 1
./probar.sh todos    # prueba todos y muestra cuántos están resueltos
```

Cada ejercicio tiene varios **archivos de prueba**, y cada archivo trae varios
casos. El script compila, corre cada archivo y se detiene en el primero que
falla:

| Mensaje | Qué significa |
|---|---|
| `ACEPTADO` | Pasó todos los archivos de prueba. El ejercicio está resuelto. |
| `RESPUESTA INCORRECTA` | La salida no es la esperada. Muestra la entrada, lo esperado y lo obtenido. |
| `TIEMPO EXCEDIDO` | El programa tardó más de 2 segundos en un archivo de prueba completo (con todos sus casos). Revisar el **orden pedido**. |
| `ERROR EN EJECUCION` | El programa se cayó (índice fuera de rango, puntero nulo, recursión infinita...). |
| `error de compilacion` | No compila. |
| `libreria prohibida` | Se incluyó algo que no está permitido (regla 6). |

Para probar a mano con un caso propio:

```bash
mkdir -p build
g++ --std=c++11 -O2 ejercicios/1-nombre/main.cpp -o build/prueba.out
./build/prueba.out < ejercicios/1-nombre/tests/01-ejemplo.in.txt
```

### 5. Avisar

Cuando un ejercicio muestra `ACEPTADO`:

1. **Levantar la mano** y dejar el `ACEPTADO` en pantalla.
2. El docente se acerca, lo verifica y anota en el pizarrón el ejercicio y el
   **minuto** de la competencia.
3. Seguir con otro ejercicio.

El tiempo que cuenta es el del momento en que el docente lo verifica. Con el
**tercer** `ACEPTADO`, correr `./probar.sh todos`, dejar el resumen en pantalla y
avisar. El primer grupo verificado con 3 resueltos gana.

## Sobre el orden

Cada ejercicio indica el **orden temporal pedido**. Los casos de prueba grandes
están pensados para que una solución de peor orden no termine a tiempo
(`TIEMPO EXCEDIDO`).

- Si los casos chicos pasan y los grandes dan `TIEMPO EXCEDIDO`, revisen el
  orden de la solución. También puede ser un bug, como un ciclo que no termina.
- Si los grandes dan `RESPUESTA INCORRECTA` o `ERROR EN EJECUCION`, es un bug:
  revisen el tipo de dato (`int` o `long long`), los índices y el tamaño de los
  arrays.

## Lo que ya está hecho

Son las mismas estructuras del repositorio del curso. Los `#include` ya están
escritos (comentados) arriba de cada `main.cpp`: alcanza con descomentar.

```cpp
#include "../../adts/ListImp.cpp"
```

| Archivo | Qué trae | Operaciones |
|---|---|---|
| [`adts/ListImp.cpp`](adts/ListImp.cpp) | `ListImp<T>` (lista) | `insert`, `insertAt`, `remove`, `removeAt`, `get`, `getSize`, `isEmpty`, `getIterator` |
| [`adts/QueueImp.cpp`](adts/QueueImp.cpp) | `QueueImp<T>` (cola) | `enqueue`, `dequeue`, `next`, `isEmpty` |
| [`adts/StackImp.cpp`](adts/StackImp.cpp) | `StackImp<T>` (pila) | `push`, `pop`, `top`, `isEmpty` |
| [`helpers/MergeSort.cpp`](helpers/MergeSort.cpp) | `mergeSort`, `O(N log N)` | `mergeSort(arr, n)` para enteros, `mergeSort(arr, n, criterio)` para cualquier tipo |

## Ejercicios

| # | Ejercicio | Táctica |
|---|---|---|
| 0 | [Calentamiento](ejercicios/0-calentamiento) | (no cuenta) |
| 1 | [Salones de Bedelía](ejercicios/1-salones) | Greedy |
| 2 | [Ranking desordenado](ejercicios/2-inversiones) | Dividir y conquistar |
| 3 | [¿Cuánto me llevo?](ejercicios/3-casas) | Programación dinámica |
| 4 | [Mao meno parecidas](ejercicios/4-edicion) | Programación dinámica |
| 5 | [Sopa de letras](ejercicios/5-sopa) | Backtracking |

¡Éxitos!
