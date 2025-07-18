<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prova Dinâmica</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            background-color: #f4f4f4; 
            color: #333; 
        }
        .container { 
            max-width: 800px; 
            margin: 0 auto; 
            background-color: #fff; 
            padding: 25px; 
            border-radius: 8px; 
            box-shadow: 0 0 10px rgba(0,0,0,0.1); 
        }
        h1, h2 { 
            color: #0056b3; 
            border-bottom: 2px solid #eee; 
            padding-bottom: 10px; 
            margin-bottom: 20px; 
        }
        .questao { 
            background-color: #f9f9f9; 
            border: 1px solid #ddd; 
            padding: 15px; 
            margin-bottom: 20px; 
            border-radius: 6px; 
        }
        .questao h3 { 
            margin-top: 0; 
            color: #333; 
        }
        .alternativas ul { 
            list-style: none; 
            padding: 0; 
        }
        .alternativas li { 
            margin-bottom: 8px; 
            padding: 5px; 
            background-color: #e9e9e9; 
            border-radius: 4px; 
        }
        .error-message { 
            color: red; 
            background-color: #ffe0e0; 
            border: 1px solid red; 
            padding: 10px; 
            border-radius: 5px; 
            margin-bottom: 20px; 
        }
        .no-data {
            color: #666;
            text-align: center;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Prova Dinâmica</h1>

        <?php if (isset($erro)): // Se houver uma mensagem de erro, exibe-a ?>
            <p class="error-message"><?php echo htmlspecialchars($erro); ?></p>
        <?php endif; ?>

        <?php 
            // Nesta configuração, não temos um objeto 'prova' completo (nome, descrição da prova em si),
            // pois estamos buscando as questões diretamente pela disciplina.
            // Se você ainda precisar exibir o "Nome da Prova" ou "Descrição da Prova",
            // você precisará de uma lógica adicional no seu controller para buscar esses dados
            // da tabela 'prova' com base na disciplina selecionada (se houver uma prova padrão para a disciplina).
        ?>

        <h2>Questões da Disciplina:</h2>
        <?php if (!empty($questoes_prova)): // Verifica se o array de questões não está vazio ?>
            <?php $numero_questao = 1; ?>
            <?php foreach ($questoes_prova as $questao): // Itera sobre cada questão encontrada ?>
                <div class="questao">
                    <h3>Questão <?php echo $numero_questao++; ?>: <?php echo htmlspecialchars($questao['codigoQuestao'] ?? ''); ?></h3>
                    <p><?php echo nl2br(htmlspecialchars($questao['descricao'] ?? 'N/A')); ?></p>
                    
                    <div class="alternativas">
                        <h4>Alternativas:</h4>
                        <ul>
                            <?php 
                                // EXEMPLO SE VOCÊ TIVESSE UMA TABELA 'ALTERNATIVAS'
                                // E UM MÉTODO NO MODEL PARA BUSCÁ-LAS:
                                /*
                                if (isset($questao['id_questao'])) {
                                    // Isso chamaria um método NO SEU CONTROLLER ou diretamente aqui,
                                    // MAS É MELHOR QUE O CONTROLLER PASSE AS ALTERNATIVAS JÁ PRONTAS.
                                    // Ex: $alternativas_desta_questao = $this->questaoModel->getAlternativasByQuestaoId($questao['id_questao']);
                                    // if (!empty($alternativas_desta_questao)) {
                                    //     foreach ($alternativas_desta_questao as $alt_key => $alternativa_texto) {
                                    //         echo '<li>' . chr(65 + $alt_key) . ') ' . htmlspecialchars($alternativa_texto['texto_alternativa']) . '</li>';
                                    //     }
                                    // }
                                }
                                */
                                // Por enquanto, um placeholder:
                            ?>
                            <li>(Alternativas desta questão viriam aqui)</li> 
                        </ul>
                    </div>
                    <?php 
                    // if (!empty($questao['caminho_imagem'])): 
                    ?>
                        <?php // endif; ?>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p class="no-data">Nenhuma questão encontrada para esta disciplina.</p>
        <?php endif; ?>
    </div>
</body>
</html>