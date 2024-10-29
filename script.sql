-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui

-- Create table students_performance
-- with the required attributes
CREATE TABLE students_performance(  
    id SERIAL PRIMARY KEY,
    age INT,
    scholarship INT,
    partner INT,
    salary INT,
    mother_edu INT,
    father_edu INT,
    read_freq INT,
    read_freq_sci INT,
    classroom INT,
    grade INT);


-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui
DO $$
DECLARE
    alunos_aprovados_c_pais_phd REFCURSOR;
    numero_alunos INT;
    nome_tabela varchar(100) := 'students_performance';
BEGIN
    OPEN alunos_aprovados_c_pais_phd FOR EXECUTE
    format
    (
        'SELECT count(id) from  %s WHERE father_edu = 6 or mother_edu = 6'
        ,
        nome_tabela
    );
    LOOP
        FETCH alunos_aprovados_c_pais_phd INTO numero_alunos;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%',numero_alunos;
    END LOOP;
    CLOSE alunos_aprovados_c_pais_phd;
END;
$$


-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui
DO $$
DECLARE
    alunos_aprovados_c_pais_phd REFCURSOR;
    numero_alunos INT;
    nome_tabela varchar(100) := 'students_performance';
BEGIN
    OPEN alunos_aprovados_c_pais_phd FOR EXECUTE
    format
    (
        'SELECT COUNT(id) FROM students_performance WHERE partner = 2'
        ,
        nome_tabela
    );
    LOOP
        FETCH alunos_aprovados_c_pais_phd INTO numero_alunos;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%',numero_alunos;
    END LOOP;
    CLOSE alunos_aprovados_c_pais_phd;
END;
$$


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui
CREATE TABLE students_performance(
    id SERIAL PRIMARY KEY,
    age INT,
    scholarship INT,
    partner INT,
    salary INT,
    mother_edu INT,
    father_edu INT,
    read_freq INT,
    read_freq_sci INT,
    prep_study INT,
    prep_exam INT,
    classroom INT,
    grade INT);

DO
$$
DECLARE
    id INT;
    salary INT;
    read_freq INT;
    read_freq_sci INT;
    contagem INT;
    cursor_salario_frequencia CURSOR FOR SELECT salary, read_freq, read_freq_sci FROM students_performance;
BEGIN
    OPEN cursor_salario_frequencia;
    LOOP
    FETCH cursor_salario_frequencia INTO contagem;
    IF salary >= 5 and read_freq_sci = 3 THEN
        SELECT COUNT(id) AS contagem_ID;
        RAISE NOTICE '%', contagem_ID;
    END IF;
    EXIT WHEN NOT FOUND;
    END LOOP;
    CLOSE cursor_salario_frequencia;
END;
$$


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- recreate the table to attend the query
-- missing field
DO $$
DECLARE
    cursor_delete REFCURSOR;
    tupla RECORD;
    nome_tabela varchar(100) := 'students_performance';
BEGIN
    OPEN cursor_delete SCROLL FOR
    SELECT * FROM students_performance;
    LOOP
        FETCH cursor_delete INTO TUPLA;
        EXIT WHEN NOT FOUND;
        IF tupla.* IS NULL THEN
            DELETE FROM students_performance WHERE CURRENT OF cursor_delete;
        END IF;
    END LOOP;
    LOOP
        FETCH BACKWARD FROM cursor_delete INTO tupla;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', tupla;
    END LOOP;
    CLOSE cursor_delete;
END;
$$

-- ----------------------------------------------------------------
