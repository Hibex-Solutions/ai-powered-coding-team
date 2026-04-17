---
title: "Boas práticas"
weight: 3
---

{{% card title="Regras fundamentais do modelo" %}}

<div class="rules-list">

{{% rule icon="📋" title="Especificação antes de implementação" %}}
<span>Nenhuma funcionalidade sem regra de negócio documentada — o código nasce da especificação, nunca o contrário.</span>
{{% /rule %}}

{{% rule icon="📂" title="Nenhuma tecnologia sem registro" %}}
<span>Toda stack deve estar declarada em <code>docs/SOLUTION.md</code> antes de ser adotada.</span>
{{% /rule %}}

{{% rule icon="🧪" title="Testes guiados por negócio" %}}
<span>Cobertura 100% das regras especificadas — cada regra de negócio tem pelo menos um teste correspondente.</span>
{{% /rule %}}

{{% rule icon="🔒" title="Secrets nunca no código" %}}
<span>Toda credencial e segredo deve ser configurável por ambiente — jamais embutido no código-fonte.</span>
{{% /rule %}}

{{% rule icon="⚙️" title="The Twelve-Factor App" %}}
<span>O software construído deve ser aderente aos doze fatores para garantir portabilidade e escalabilidade.</span>
{{% /rule %}}

{{% rule icon="🤝" title="Commits são humanos" %}}
<span>A IA propõe, o engenheiro commita — a decisão e responsabilidade de cada commit permanecem humanas.</span>
{{% /rule %}}

</div>

{{% /card %}}
