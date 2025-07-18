<?php

class Prova {
    private $pdo;

    public function __construct() {

        global $conexao;
        $this->pdo = $conexao;
        
    }

    public function getProvasPorProfessorEDisciplina() {
        $sql = "
            SELECT
                prof.nome AS professor,
                disc.nome AS disciplina,
                COUNT(*) AS total
            FROM
                prova p
            JOIN
                professor prof ON prof.id_professor = p.Disciplina_Professor_id_professor
            JOIN
                disciplina disc ON disc.id_disciplina = p.Disciplina_id_disciplina
            WHERE
                YEAR(p.data_prova) = 2025 -- Adicionando a condição para o ano 2025
            GROUP BY
                prof.nome,
                disc.nome
            ORDER BY
                disc.nome,
                prof.nome
        ";
        try {
            $stmt = $this->pdo->query($sql);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Erro na query SQL em Prova.php: " . $e->getMessage());
            return [];
        }
    }
}
?>