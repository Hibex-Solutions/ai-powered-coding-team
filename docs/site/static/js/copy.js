document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('pre').forEach(function (pre) {
    var wrapper = document.createElement('div');
    wrapper.className = 'code-block';
    pre.parentNode.insertBefore(wrapper, pre);
    wrapper.appendChild(pre);

    var btn = document.createElement('button');
    btn.className = 'copy-btn';
    btn.textContent = 'Copiar';
    btn.addEventListener('click', function () {
      var text = pre.innerText;
      navigator.clipboard.writeText(text).then(function () {
        btn.textContent = 'Copiado!';
        btn.classList.add('copied');
        setTimeout(function () {
          btn.textContent = 'Copiar';
          btn.classList.remove('copied');
        }, 2000);
      }).catch(function () {
        btn.textContent = 'Erro';
        setTimeout(function () { btn.textContent = 'Copiar'; }, 2000);
      });
    });
    wrapper.appendChild(btn);
  });
});
