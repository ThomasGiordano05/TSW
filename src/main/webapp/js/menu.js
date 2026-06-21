document.addEventListener("DOMContentLoaded", function() {
    const shopLink = document.getElementById('shop');
    const shopBlock = document.getElementById('shop-block');

    if (shopLink && shopBlock) {
        
        shopLink.addEventListener('click', function(e) {
            // Impedisce al link di seguire immediatamente il link del tag <a> (se presente)
            e.preventDefault(); 
            
            // Mostra o nasconde la tendina alternando la classe 'hidden'
            shopBlock.classList.toggle('hidden');
        });

        // OPZIONALE: Chiude la tendina se l'utente clicca in un punto qualsiasi fuori dal menu
        document.addEventListener('click', function(e) {
            if (!shopLink.contains(e.target) && !shopBlock.contains(e.target)) {
                shopBlock.classList.add('hidden');
            }
        });
    }
});