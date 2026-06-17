document.addEventListener("DOMContentLoaded", () => {
    const images = document.querySelectorAll('.slide-img');
    const dots = document.querySelectorAll('.dot');
    let index = 0;
    let autoScrollInterval;

    function showImage(i) {
        images.forEach(img => img.classList.remove('active'));
        images[i].classList.add('active');
        updateDots(i);
    }

    function updateDots(i) {
        dots.forEach(dot => dot.classList.remove('active-dot'));
        dots[i].classList.add('active-dot');
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

    // Frecce
    document.querySelector('.right-changer').addEventListener('click', () => {
        nextImage();
        resetAutoScroll();
    });

    document.querySelector('.left-changer').addEventListener('click', () => {
        prevImage();
        resetAutoScroll();
    });

    // Click sui pallini
    dots.forEach((dot, i) => {
        dot.addEventListener('click', () => {
            index = i;
            showImage(index);
            resetAutoScroll();
        });
    });

    startAutoScroll();
});
