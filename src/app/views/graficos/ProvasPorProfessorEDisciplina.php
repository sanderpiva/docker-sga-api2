<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (isset($_GET['logout']) && $_GET['logout'] == 'true') {
    header("Location: index.php?controller=auth&action=logout");
    exit();
}

if (!isset($_SESSION['logado']) || $_SESSION['logado'] !== true || $_SESSION['tipo_usuario'] !== 'professor') {
    header("Location: index.php?controller=auth&action=showLoginForm"); // Corrigido para o controlador certo
    exit();
}

?>


<!DOCTYPE html>
<html>
<head>
    <title>Provas por Professor e Disciplina</title>
    <link rel="stylesheet" href="public/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>Gráfico: Provas por Professor e Disciplina</h1>
    <canvas id="grafico" width="800" height="200"></canvas>

    <script>
        fetch('/index.php?controller=grafico&action=dadosProvasPorProfessorEDisciplina')
            .then(res => res.json())
            .then(data => {
                const disciplinasSet = new Set();
                const professoresSet = new Set();

                data.forEach(item => {
                    disciplinasSet.add(item.disciplina);
                    professoresSet.add(item.professor);
                });

                const disciplinas = Array.from(disciplinasSet);
                const professores = Array.from(professoresSet);

                const datasets = professores.map((prof, index) => {
                    const bgColor = `hsl(${index * 60}, 70%, 60%)`; // <-- CERTIFIQUE-SE DE TER AS CRASES AQUI!
                    return {
                        label: prof,
                        backgroundColor: bgColor,
                        data: disciplinas.map(disc => {
                            const found = data.find(d => d.professor === prof && d.disciplina === disc);
                            return found ? found.total : 0;
                        })
                    };
                });

                new Chart(document.getElementById('grafico'), {
                    type: 'bar',
                    data: {
                        labels: disciplinas,
                        datasets: datasets
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: { stacked: false },
                            y: { beginAtZero: true }
                        }
                    }
                });
            });
    </script>
    <br><br><br>
    <a href="index.php?controller=auth&action=logout"><em>Logout -> HomePage</em></a>

</body>

<footer><br><br><br><br><br><br><br><br><br><br><br>
    <p>Desenvolvido por Juliana e Sander</p>
</footer>
</html>
