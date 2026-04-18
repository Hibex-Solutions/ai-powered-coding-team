(function () {
  var slides = Array.from(document.querySelectorAll('.banner-slide'));
  if (slides.length === 0) return;

  for (var i = slides.length - 1; i > 0; i--) {
    var j = Math.floor(Math.random() * (i + 1));
    var tmp = slides[i]; slides[i] = slides[j]; slides[j] = tmp;
  }

  var current = 0;
  slides[current].classList.add('active');

  setInterval(function () {
    slides[current].classList.remove('active');
    current = (current + 1) % slides.length;
    slides[current].classList.add('active');
  }, 30000);
})();
