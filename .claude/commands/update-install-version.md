# Atualiza a versão do exemplo de instalação no README

Consulte a última release disponível em https://api.github.com/repos/hibex-solutions/ai-powered-coding-team/releases/latest
e extraia o valor de `tag_name`.

Se a resposta for 404 ou `tag_name` estiver vazio, use a string `latest` como versão.

Em seguida, edite o arquivo `README.md` substituindo o segundo argumento do comando de instalação com versão específica pelo valor obtido. A linha a editar segue o padrão:

```
... | bash -s -- meu-projeto <versão-atual>
```

Essa linha aparece no segundo bloco de código da seção "### 1. Instale o template". Substitua apenas o valor da versão nessa linha, mantendo todo o restante inalterado.

Não faça mais nenhuma alteração além dessa substituição.
