# tears_of_the_trimestre
The Legend of Celda: Tears of the Trimestre

## Informe sobre la Implementación de los Predicados en Prolog

### Introducción
Este informe tiene como objetivo ofrecer una descripción detallada de la formulación y el enfoque empleados en la implementación de los predicados `cruzar/3` y `siempre_seguro/1` en el lenguaje de programación Prolog. Estos predicados fueron concebidos para abordar un desafío específico relacionado con la navegación en un laberinto complejo, el cual está representado mediante una estructura de datos específica. Dichas implementaciones corresponden al **Proyecto II**, titulado ***“La Leyenda de Celda: El Secreto de la Matriz Traspuesta”***, el cual forma parte del curso **CI–3661 – Laboratorio de Lenguajes de Programación**.

### Justificación

- #### Predicado `cruzar/3`
    El predicado `cruzar/3` se implementó con el objetivo de determinar si existe una configuración de palancas que permita atravesar el laberinto de manera segura. La elección de utilizar el enfoque de backtracking en Prolog se fundamenta en la necesidad de explorar exhaustivamente todas las combinaciones posibles de palancas, permitiendo al intérprete Prolog retroceder y explorar diferentes opciones cuando una configuración no conduce a una solución segura.

    La justificación detrás de este enfoque radica en la naturaleza del problema, donde es esencial evaluar cada disposición de palancas para encontrar una solución viable. Se incorporó una lógica para evitar bucles infinitos mediante el mantenimiento de un registro de los submapas ya visitados, asegurando así la eficiencia y coherencia en la exploración del laberinto.

    El manejo específico de juntas y bifurcaciones en el predicado `cruzar_aux` es clave para abordar la complejidad inherente al laberinto. La recursión sobre estos elementos garantiza la evaluación adecuada de los caminos individuales y la combinación de todos los caminos.

- #### Predicado `siempre_seguro/1`
    El predicado `siempre_seguro/1` se diseñó para verificar si, independientemente de la disposición de las palancas, existe una manera segura de atravesar el laberinto. Se priorizó la claridad en la lógica del código y la representación directa de los casos base.

    Se definieron casos base explícitos para pasillos regulares y de cabeza, reconociendo que estos son intrínsecamente seguros de cruzar. La recursión se implementó de manera clara y directa para juntas y bifurcaciones, asegurando que ambos caminos sean considerados y, por ende, garantizando la solidez del predicado.

    La introducción de una lista de submapas visitados es crucial para prevenir bucles infinitos durante la recursión y asegurar que no se repita la exploración de submapas.

### Conclusión
La implementación de estos predicados en Prolog se caracteriza por su robustez y modularidad. El enfoque de backtracking, la atención a la recursión y casos base, y la claridad en la lógica del código contribuyen a una solución efectiva y comprensible para el problema del laberinto. La adaptabilidad y coherencia en la estructura del código facilitan su comprensión y ofrecen una base sólida para abordar problemas similares en el futuro.

### Integrantes
- Miguel Perez (15-11126)
- Jose Perez (16-10882)
- Gabriel Chaurio (17-10126)
