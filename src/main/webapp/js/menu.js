document.addEventListener("DOMContentLoaded", function() {
    const shopLink = document.getElementById('shop');
    const shopBlock = document.getElementById('shop-block');

    if (shopLink && shopBlock) {
        
        shopLink.addEventListener('click', function(e) {
            e.preventDefault(); 
            
            shopBlock.classList.toggle('hidden');
        });

        document.addEventListener('click', function(e) {
            if (!shopLink.contains(e.target) && !shopBlock.contains(e.target)) {
                shopBlock.classList.add('hidden');
            }
        });
    }
});