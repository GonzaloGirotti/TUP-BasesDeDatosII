# **Ejercicio 1 - Reglas de Integridad:**
### *Dado un modelo de base de datos de una universidad, identificar violaciones posibles a la integridad referencial si se elimina un estudiante con cursos inscritos. ¿Qué mecanismos usarías para evitarlo?*

En caso de eliminarse en una base de datos de una universidad, un estudiante con cursos inscriptos, esto generaría errores de integridad debido a la/las claves foráneas que asocian al alumno con los cursos. El eliminar al estudiante sin eliminar antes sus cursos, dejaría a estos sin un estudiante referenciado (sin una referencia a una fila la tabla padre).

Se podría resolver fácilmente con la restricción: "ON DELETE RESTRICT". Esto haría que, al intentar ejecutar la sentencia de eliminacion del alumno sin antes eliminar sus cursos, aparezca un error y se impidiese que la consulta sea ejecutada por completo.
    
## **EJEMPLO:**
Tabla padre: Alumnos.
id: 1, nombre_alumno: Juancito, id_curso: 2

Tabla hija: Cursos.
id: 1, nombre_curso: matematicas.
id: 2, nombre_curso: algebra.

**NO HACER ESTO (agregar FK sin ON DELETE RESTRICT):**
ALTER TABLE Alumnos
ADD CONSTRAINT fk_alumnoCurso
FOREIGN KEY (id_curso)
REFERENCES Cursos(id);

**HACER ESTO (agregar FK ¡CON! ON DELETE RESTRICT):**
ALTER TABLE Alumnos
ADD CONSTRAINT fk_alumnoCurso
FOREIGN KEY (id_curso)
REFERENCES Cursos(id)
ON DELETE RESTRICT;


        
