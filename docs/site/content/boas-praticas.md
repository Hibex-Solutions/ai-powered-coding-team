---
title: "Boas práticas"
weight: 3
---

{{% card title="Regras fundamentais do modelo" %}}

<div class="rules-list">

{{% rule icon="📋" title="Especificação antes de implementação" %}}
<span>Cada documento é produzido pela IA em sessão supervisionada pelo papel humano correspondente. O objetivo nasce em <code>GOAL.md</code> (engenheiro supervisiona). O problema nasce em <code>BUSINESS.md</code> (analista supervisiona). A projeção da solução — <code>GUIDELINE.md</code>, <code>ARCHITECTURE.md</code> e <code>SOLUTION.md</code> — é produzida em paralelo, com designer e arquiteto supervisionando em coordenação, a partir do problema já consolidado. O código nasce dessa projeção (engenheiro supervisiona). Nunca antes — pular etapas viola as regras primárias invioláveis.</span>
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
<span>A IA propõe em <strong>todos</strong> os artefatos — <code>GOAL.md</code>, <code>BUSINESS.md</code>, <code>GUIDELINE.md</code>, <code>ARCHITECTURE.md</code>, <code>SOLUTION.md</code> e código. O papel humano correspondente (engenheiro, analista, designer, arquiteto) revisa e commita — a decisão e responsabilidade de cada commit permanecem humanas.</span>
{{% /rule %}}

</div>

{{% /card %}}
