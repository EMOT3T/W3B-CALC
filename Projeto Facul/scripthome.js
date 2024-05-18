document.addEventListener('DOMContentLoaded', function() {
    // Adiciona evento de clique ao botão "Adicionar N3"
    document.getElementById('addN3Button').addEventListener('click', function() {
        document.getElementById('notaN3Row').style.display = 'table-row';
    });

    // Adiciona evento de clique ao botão "Remover N3"
    document.getElementById('removeN3Button').addEventListener('click', function() {
        document.getElementById('notaN3Row').style.display = 'none';
        document.getElementById('notaN3').value = '';
    });

    // Ação de clique no submenu
    document.getElementById('menu-button').addEventListener('click', function() {
        var leftMenu = document.getElementById('left-menu');
        var submenu = document.getElementById('submenu');
        
        if (submenu.style.display === 'block') {
            submenu.style.display = 'none';
            leftMenu.style.width = '80px';
        } else {
            submenu.style.display = 'block';
            leftMenu.style.width = '200px';
        }
    });

    // Adiciona evento de clique ao botão "Calcular média"
    document.querySelector('button').addEventListener('click', function() {
        calcularMedia();
    });
});

// Função para calcular a média
function calcularMedia() {
    const notaN1 = parseFloat(document.getElementById("notaN1").value);
    let notaAP = parseFloat(document.getElementById("notaAP").value);
    let notaAI = parseFloat(document.getElementById("notaAI").value);
    const notaN3 = parseFloat(document.getElementById("notaN3").value);
    const mediaEscola = parseFloat(document.getElementById("mediaEscolaInput").value);
    const pontoExtra = document.getElementById("pontoExtra").checked ? parseFloat(document.getElementById("valorPontoExtra").value) : 0;

    const resultado = document.getElementById("resultado");
    resultado.innerHTML = "";

    if (isNaN(notaN1) || isNaN(notaAP) || isNaN(notaAI)) {
        resultado.innerHTML = "Por favor, preencha todas as notas.";
        return;
    }

    if (isNaN(mediaEscola)) {
        resultado.innerHTML = "Por favor, insira um valor válido para a média";
        return;
    }

    let notaN2 = (notaAP + notaAI) / 2;

    if (!isNaN(notaN3)) {
        let menorNota = Math.min(notaN1, notaAP, notaAI);
        if (menorNota === notaN1) {
            notaN1 = notaN3;
        } else if (menorNota === notaAP) {
            notaAP = notaN3;
            notaN2 = (notaAP + notaAI) / 2;
        } else {
            notaAI = notaN3;
            notaN2 = (notaAP + notaAI) / 2;
        }
    }

    document.getElementById('notaN2').value = notaN2.toFixed(2);
    let mediaFinal = (notaN1 + notaN2) / 2;

    if (!isNaN(pontoExtra)) {
        mediaFinal += pontoExtra;
    }

    if (mediaFinal >= mediaEscola) {
        resultado.innerHTML = `A sua média é ${mediaFinal.toFixed(2)}. Parabéns, você passou nesta matéria!`;
    } else {
        resultado.innerHTML = `A sua média é ${mediaFinal.toFixed(2)}. Você reprovou nesta matéria!`;
    }
}

// Função para alternar a exibição do campo de valor do ponto extra
function togglePontoExtra() {
    const pontoExtra = document.getElementById("pontoExtra");
    const valorPontoExtra = document.getElementById("valorPontoExtra");
    
    if (pontoExtra.checked) {
        valorPontoExtra.style.display = "inline";
    } else {
        valorPontoExtra.style.display = "none";
        valorPontoExtra.value = "";
    }
}
