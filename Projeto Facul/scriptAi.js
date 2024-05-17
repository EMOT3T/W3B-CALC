// Função para atualizar o ícone do botão de alternância com base no modo atual
function updateToggleButtonIcon() {
    const sunIcon = document.getElementById('sun-icon');
    const moonIcon = document.getElementById('moon-icon');

    // Verifica se o modo escuro está ativado
    if (document.body.classList.contains('dark-mode')) {
        // Se estiver, mostra apenas o ícone da lua e oculta o ícone do sol
        sunIcon.style.display = 'none';
        moonIcon.style.display = 'inline';
    } else {
        // Se não estiver, mostra apenas o ícone do sol e oculta o ícone da lua
        sunIcon.style.display = 'inline';
        moonIcon.style.display = 'none';
    }
}

// Verifica se o modo escuro está habilitado ao carregar a página e atualiza o ícone do botão
if (localStorage.getItem('darkMode') === 'true') {
    enableDarkMode();
} else {
    disableDarkMode(); // Desativa o modo escuro se não estiver ativado
}

// Adiciona um evento de clique ao botão de alternar tema
document.getElementById('theme-toggle').addEventListener('click', () => {
    const body = document.body;

    // Verifica se o modo escuro está ativado
    if (body.classList.contains('dark-mode')) {
        // Desativa o modo escuro
        disableDarkMode();
        // Armazena a preferência do usuário no armazenamento local
        localStorage.setItem('darkMode', 'false');
    } else {
        // Ativa o modo escuro
        enableDarkMode();
        // Armazena a preferência do usuário no armazenamento local
        localStorage.setItem('darkMode', 'true');
    }

    // Atualiza o ícone do botão de alternância após a mudança de tema
    updateToggleButtonIcon();
});

// Função para ativar o modo escuro
function enableDarkMode() {
    const body = document.body;
    // Adiciona a classe 'dark-mode' ao body
    body.classList.add('dark-mode');
}

// Função para desativar o modo escuro
function disableDarkMode() {
    const body = document.body;
    // Remove a classe 'dark-mode' do body
    body.classList.remove('dark-mode');
}

// Chama a função para atualizar o ícone do botão de alternância ao carregar a página
updateToggleButtonIcon();


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