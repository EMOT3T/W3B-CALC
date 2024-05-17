document.getElementById('addButton').addEventListener('click', function() {
    document.getElementById('notaN3Row').style.display = 'table-row';
});

document.getElementById('editN3Button').addEventListener('click', function() {
    const notaN3Input = document.getElementById('notaN3');
    notaN3Input.disabled = !notaN3Input.disabled;
    this.textContent = notaN3Input.disabled ? '✏️' : '✔️';
});

document.getElementById('removeN3Button').addEventListener('click', function() {
    document.getElementById('notaN3Row').style.display = 'none';
    document.getElementById('notaN3').value = '';
    document.getElementById('notaN3').disabled = false;
    document.getElementById('editN3Button').textContent = '✏️';
});

const calcularMediaButton = document.getElementById('calcularMediaButton');
const notaAPInput = document.getElementById('notaAP');
const notaAIInput = document.getElementById('notaAI');
const notaN2Input = document.getElementById('notaN2');
const notaN3Input = document.getElementById('notaN3');

calcularMediaButton.addEventListener('click', calcularMedia);

function calcularMedia() {
    const notaN1 = parseFloat(document.getElementById('notaN1').value);
    let notaAP = parseFloat(notaAPInput.value);
    let notaAI = parseFloat(notaAIInput.value);
    const notaN3 = parseFloat(notaN3Input.value);

    if (!isNaN(notaAP) && !isNaN(notaAI)) {
        let notaN2 = (notaAP + notaAI) / 2;
        
        if (!isNaN(notaN3)) {
            let menorNotaIndex;
            if (notaN1 <= notaAP && notaN1 <= notaAI) {
                menorNotaIndex = 'N1';
            } else if (notaAP <= notaN1 && notaAP <= notaAI) {
                menorNotaIndex = 'AP';
            } else {
                menorNotaIndex = 'AI';
            }

            if (menorNotaIndex === 'AP') {
                notaAP = notaN3;
                notaN2 = (notaAP + notaAI) / 2;
            } else if (menorNotaIndex === 'AI') {
                notaAI = notaN3;
                notaN2 = (notaAP + notaAI) / 2;
            } else {
                notaN1 = notaN3;
            }
        }

        notaN2Input.value = notaN2.toFixed(2);

        const media = (notaN1 + notaN2) / 2;
        const mediaEscola = parseFloat(document.getElementById('mediaEscolaInput').value);

        if (!isNaN(mediaEscola)) {
            const mediaResult = document.getElementById('mediaResult');
            mediaResult.textContent = `Média: ${media.toFixed(2)} - ${media >= mediaEscola ? 'Parabéns você passou!' : 'Infelizmente você não passou'}`;
        } else {
            alert('Por favor, informe a média da Escola / Universidade.');
        }
    } else {
        alert('Por favor, preencha as notas de AP e AI.');
        return;
    }
}

// Botão do SubMenu
document.addEventListener('DOMContentLoaded', function() {
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
});
