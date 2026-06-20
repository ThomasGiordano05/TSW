document.addEventListener("DOMContentLoaded", function() {
    const shopLink = document.getElementById('shop');
    const shopBlock = document.getElementById('shop-block');
    const navContainer = document.querySelector('.link');

    if (shopLink && shopBlock) {
        // Mostra la tendina all'entrata del mouse
        shopLink.addEventListener('mouseenter', function() {
            shopBlock.classList.remove('hidden');
        });

        // Nasconde la tendina quando il mouse esce
        if (navContainer) {
            navContainer.addEventListener('mouseleave', function() {
                shopBlock.classList.add('hidden');
            });
        }

        // FORZATURA DEL CLICK: Se per qualunque motivo l'evento si perde, 
        // intercettiamo il click e lo spingiamo noi a destinazione
        shopLink.addEventListener('click', function(e) {
            window.location.href = 'CatalogoServlet';
        });
    }
});