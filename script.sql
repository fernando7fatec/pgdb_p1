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


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------
