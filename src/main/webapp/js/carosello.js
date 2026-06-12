document.addEventListener("DOMContentLoaded", () => {
    const images = document.querySelectorAll('.slide-img');
    let index = 0;
    let autoScrollInterval;

    function showImage(i) {
        images.forEach(img => img.classList.remove('active'));
        images[i].classList.add('active');
    }

    function nextImage() {
        index = (index + 1) % images.length;
        showImage(index);
    }

    function prevImage() {
        index = (index - 1 + images.length) % images.length;
        showImage(index);
    }

    function startAutoScroll() {
        autoScrollInterval = setInterval(nextImage, 3000);
    }

    function resetAutoScroll() {
        clearInterval(autoScrollInterval);
        startAutoScroll();
    }

    document.querySelector('.right-changer').addEventListener('click', () => {
        nextImage();
        resetAutoScroll();
    });

    document.querySelector('.left-changer').addEventListener('click', () => {
        prevImage();
        resetAutoScroll();
    });

    startAutoScroll();
});
