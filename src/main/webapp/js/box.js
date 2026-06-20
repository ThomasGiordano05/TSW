document.querySelectorAll('.grid-element-footer').forEach(footer => {
    
    const normal = footer.querySelector('.heart-normal');
    const positive = footer.querySelector('.heart-positive');

    normal.addEventListener('click', () => {
	    e.stopPropagation();
	    e.preventDefault();
        normal.classList.add('hidden');
        positive.classList.remove('hidden');
    });

    positive.addEventListener('click', () => {
        positive.classList.add('hidden');
        normal.classList.remove('hidden');
    });

});
