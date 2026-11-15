# Competencia de Tácticas - Algoritmos 2

Simulacro de concurso de programación sobre las tácticas del curso:
**greedy**, **dividir y conquistar**, **programación dinámica** y **backtracking**.

## Cómo se gana

- Hay **5 ejercicios**. Duración: **2 horas**.
- Gana el grupo con **más ejercicios ACEPTADOS** al terminar las 2 horas.
- Si hay empate en cantidad, gana el grupo con **menor tiempo acumulado**.
- La competencia dura las 2 horas completas: nadie gana antes de tiempo.
- Los ejercicios se pueden hacer en cualquier orden. Lean los cinco antes de
  elegir: no están ordenados por dificultad.
- Un ejercicio está resuelto si `./probar.sh` muestra `ACEPTADO` **y** GitHub lo
  confirma al final (ver [Las dos verificaciones](#las-dos-verificaciones)).
- No hay penalización por intentos fallidos. Prueben todas las veces que quieran.

### El desempate

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

### Las dos verificaciones

| | Cuándo | Qué pruebas corre | Para qué sirve |
|---|---|---|---|
| **Local**: `./probar.sh` | Durante las 2 horas, en la computadora del grupo | Las de la carpeta `tests/` | Fija el **minuto** de cada ejercicio |
| **GitHub** | Al terminar, cuando el grupo sube su código | Las de `tests/` y las **pruebas grandes** de `tests-github/` | Da el **veredicto final** |

- Las pruebas locales son chicas a propósito. Así una solución correcta pasa en
  cualquier computadora, también en una lenta.
- Las pruebas grandes controlan el **orden pedido**. GitHub las corre siempre en
  la misma máquina, igual para todos los grupos.
- Un ejercicio `ACEPTADO` en la computadora del grupo que GitHub **no** acepta
  **no cuenta**. Pasa, por ejemplo, con una solución de peor orden que el pedido.
- Conclusión: respeten el **orden pedido** de cada letra, aunque las pruebas
  locales pasen.

## Reglas

1. **Una sola computadora por grupo.**
2. **Sin internet durante las 2 horas.** Ni buscador, ni documentación online,
   ni repositorios. Internet se usa solo para bajar el repositorio al inicio y
   para subir el código al final.
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
8. No se modifican los casos de prueba, `probar.sh` ni la carpeta `.github`.

El código del grupo ganador se revisa antes de confirmar el resultado.

**Las letras se leen solas.** Cada ejercicio tiene en su `README.md` el problema,
el formato, los límites y ejemplos explicados. Si algo de una letra no se
entiende, pueden preguntarle a un docente: se responden **dudas de letra**
(qué se pide, el formato, un ejemplo). No se responden preguntas sobre cómo
resolver un ejercicio, y las letras no traen pistas. Si el script muestra
`RESPUESTA INCORRECTA`, comparen lo esperado con lo obtenido y vuelvan a leer la
letra.

## Paso a paso

### 1. Crear el repositorio del grupo y bajarlo

El repositorio del docente es una **plantilla** (template). Cada grupo crea su
copia en GitHub:

1. Abrir en el navegador la URL que muestra el docente.
2. Botón verde **Use this template** → **Create a new repository**.
3. Elegir un nombre, marcar **Private** y crear el repositorio.
4. Bajarlo a la computadora:

```bash
git clone <URL del repositorio del grupo>
cd <carpeta del repositorio>
```

Después de esto, **apagar el wifi**.

### 2. Comprobar que todo funciona

Antes de programar, comprueben que la computadora compila y corre las pruebas:

```bash
./probar.sh 1
```

Tiene que mostrar `RESPUESTA INCORRECTA` en el archivo `01-ejemplo`, porque el
ejercicio todavía no está resuelto. Si muestra otro error, avisen a un docente.

> Si aparece `permission denied`, correr `chmod +x probar.sh`.
> En Windows hay que usar **WSL**. En Mac y Linux funciona directo en la terminal.

### 3. Resolver un ejercicio

Cada ejercicio está en una carpeta dentro de [`ejercicios/`](ejercicios):

```
ejercicios/1-nombre/
├── README.md     la letra, el formato, el orden pedido y ejemplos
├── main.cpp      acá se programa (el main está casi vacío)
├── tests/        archivos de prueba (entrada .in.txt y salida esperada .out.txt)
└── tests-github/ pruebas grandes, las corre solo GitHub (algunos ejercicios)
```

Igual que en el obligatorio, el programa **lee la entrada por `cin`** e
**imprime la salida por `cout`**. Todos los ejercicios tienen la misma forma:
la primera línea trae la cantidad de casos, y después viene cada caso.

```cpp
int main()
{
    ios::sync_with_stdio(false); // ya vienen en cada main.cpp:
    cin.tie(nullptr);            // solo optimizan la lectura

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

Lo que trae cada caso cambia en cada ejercicio: lean el **Formato de entrada**
de cada letra. Por ejemplo, un caso con un número `N` y después `N` números se
lee así:

```cpp
int n;
cin >> n;
int *arr = new int[n];
for (int j = 0; j < n; j++)
{
    cin >> arr[j];
}
// ... resolver e imprimir ...
delete[] arr;
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
| `ACEPTADO` | Pasó todos los archivos de prueba locales. Falta la confirmación de GitHub al final. |
| `RESPUESTA INCORRECTA` | La salida no es la esperada. Muestra la entrada, lo esperado y lo obtenido. |
| `TIEMPO EXCEDIDO` | El programa tardó más de 10 segundos en un archivo de prueba completo (con todos sus casos). Revisar el **orden pedido**. |
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

El tiempo que cuenta es el del momento en que el docente lo verifica. Un
ejercicio que queda `ACEPTADO` después de las 2 horas no cuenta.

### 6. Subir a GitHub al terminar

Cuando el docente avisa que terminaron las 2 horas, **prender el wifi** y subir
el código:

```bash
git add -A
git commit -m "Entrega"
git push
```

> Si `git commit` pide un nombre y un email, correr
> `git config user.name "Nombre"` y `git config user.email "mail@ejemplo.com"`,
> y repetir el `git commit`.

Después, en la página del repositorio del grupo en GitHub:

1. Abrir la pestaña **Actions**.
2. Entrar a la corrida más nueva, de nombre **Veredicto**. Tarda cerca de un
   minuto.
3. El resumen muestra `ACEPTADO` o `NO ACEPTADO` para cada ejercicio. Mostrarlo
   al docente.

Ese resumen es el **veredicto final**. Cuentan los ejercicios que el docente
anotó durante la competencia **y** que GitHub muestra como `ACEPTADO`. Gana el
grupo con más ejercicios; si hay empate, el de menor tiempo acumulado.

## Sobre el orden

Cada ejercicio indica el **orden temporal pedido**. Las pruebas grandes que
corre GitHub están pensadas para que una solución de peor orden no termine a
tiempo (`TIEMPO EXCEDIDO`). Las pruebas locales no siempre lo detectan.

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
| [`adts/MinHeap.cpp`](adts/MinHeap.cpp) | `MinHeap<T>` (heap), `O(log N)` | `insertar`, `eliminarTope`, `tope`, `estaVacio`, `estaLleno`. Se crea con la capacidad y una función comparadora: `MinHeap<int> heap(100, comparar)` |
| [`helpers/MergeSort.cpp`](helpers/MergeSort.cpp) | `mergeSort`, `O(N log N)` | `mergeSort(arr, n)` para enteros, `mergeSort(arr, n, criterio)` para cualquier tipo |

## Ejercicios

| # | Ejercicio | Táctica |
|---|---|---|
| 1 | [Salones de Bedelía](ejercicios/1-salones) | Greedy |
| 2 | [Ranking desordenado](ejercicios/2-inversiones) | Dividir y conquistar |
| 3 | [¿Cuánto me llevo?](ejercicios/3-casas) | Programación dinámica |
| 4 | [Mao meno parecidas](ejercicios/4-edicion) | Programación dinámica |
| 5 | [Sopa de letras](ejercicios/5-sopa) | Backtracking |

¡Éxitos!
