function adicionarCampos() {
    const numNotas = parseInt(document.getElementById("numNotas").value);
    const container = document.getElementById("notasPesos");
    container.innerHTML = "";

    for (let i = 0; i < numNotas; i++) {
        const div = document.createElement('div');
        div.style.textAlign = 'center'; // Centralizando o conteúdo dentro da div
        div.innerHTML = `
            <label for="nota${i}">Nota ${i + 1}:</label>
            <input type="number" id="nota${i}" step="0.01" style="margin: 5px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 16px; display: inline-block; text-align: center;">
            <br>
            <label for="peso${i}">Peso ${i + 1}:</label>
            <input type="number" id="peso${i}" step="0.01" style="margin: 5px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 16px; display: inline-block; text-align: center;">
        `;
        container.appendChild(div);
    }
}

function calcularMediaPonderada() {
    const numNotas = parseInt(document.getElementById("numNotas").value);
    let somaPesos = 0;
    let somaPonderada = 0;
    let camposVazios = false; // Variável para verificar se algum campo está vazio

    for (let i = 0; i < numNotas; i++) {
        const nota = parseFloat(document.getElementById(`nota${i}`).value);
        const peso = parseFloat(document.getElementById(`peso${i}`).value);

        // Verifica se algum campo está vazio
        if (isNaN(nota) || isNaN(peso)) {
            camposVazios = true;
            break; // Interrompe o loop se encontrar um campo vazio
        }

        somaPesos += peso;
        somaPonderada += nota * peso;
    }

    const mediaEscola = parseFloat(document.getElementById("mediaEscolaInput").value);
    const mediaPonderada = somaPonderada / somaPesos;

    const resultado = document.getElementById("resultado");
    resultado.innerHTML = "";

    if (camposVazios) {
        resultado.innerHTML = "Por favor, preencha todos os campos de notas e pesos.";
    } else if (!isNaN(mediaEscola)) {
        if (mediaPonderada >= mediaEscola) {
            resultado.innerHTML = `A sua média ponderada é ${mediaPonderada.toFixed(2)}. Parabéns você passou nesta matéria!`;
        } else {
            resultado.innerHTML = `A sua média ponderada é ${mediaPonderada.toFixed(2)}. Você reprovou nesta matéria!`;
        }
    } else {
        resultado.innerHTML = "Por favor, insira um valor válido para a média da sua Escola / Universidade.";
    }
}

//Botão do SubMenu
document.addEventListener('DOMContentLoaded', function() {
    // Adiciona um evento de clique ao botão de menu
    document.getElementById('menu-button').addEventListener('click', function() {
        var leftMenu = document.getElementById('left-menu');
        var submenu = document.getElementById('submenu');
        
        // Se o menu estiver visível, esconde-o
        if (submenu.style.display === 'block') {
            submenu.style.display = 'none';
            leftMenu.style.width = '80px'; // Reduz a largura do menu
        } else { // Se o menu estiver oculto, exibe-o
            submenu.style.display = 'block';
            leftMenu.style.width = '200px'; // Aumenta a largura do menu
        }
    });
});
