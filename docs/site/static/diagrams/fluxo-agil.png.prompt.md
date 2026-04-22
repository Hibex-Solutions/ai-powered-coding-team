# Diagrama "Fluxo ágil e contínuo" — Prompt de geração

A imagem `fluxo-agil.png` é gerada com **Google Gemini**, mesmo estilo visual da opção **"Ciborgue"** usada no banner do site (ver `../banners/banner_ciborgue.png.prompt.md`).

## Prompt utilizado

```
Sci-fi cyberpunk holographic flowchart diagram in 16:9 landscape aspect
ratio. Dark deep navy background (#080d1a), subtle hexagonal grid and
circuit lines faintly visible in the corners, blue-to-purple neon glow
atmosphere, floating data particles, cinematic lighting, professional
sci-fi concept art style, high detail.

The composition is a NESTED FLOWCHART rendered as a holographic display:
an OUTER rounded container labeled at the top "CICLO DE OBJETIVO"
fully encloses a smaller INNER rounded container labeled at the top
"CICLO DE ENTREGA". Both containers have glowing blue-purple borders.
Flow follows labeled arrows top-to-bottom inside the containers, with
one return arc sweeping around the outside.

Follow the flow in this EXACT sequence and direction — every arrow
below must be clearly drawn and labeled:

[1] TOP of the outer container, floating just above its upper edge:
    a bright white pulsing dot marker labeled "● INÍCIO". This is the
    fixed entry point of the entire flow, and the whole loop restarts
    here every time.

[2] Arrow DOWN from "● INÍCIO" into the outer container to a glowing
    node labeled "DEFINE OBJETIVO", positioned in the gap between the
    outer container's top wall and the inner container's top wall.
    Beside this node: a floating holographic document panel
    "docs/GOAL.md" with emerald green (#10b981) glow.

[3] Arrow DOWN from "DEFINE OBJETIVO" crossing THROUGH the top wall of
    the inner container and landing on the FIRST node of the delivery
    cycle — "ESPECIFICA". This arrow explicitly shows that the inner
    cycle begins at ESPECIFICA.

[4] INSIDE the inner container, FOUR elements stacked TOP-TO-BOTTOM,
    connected by bright DOWN arrows — this is the linear delivery
    sequence:
      (a) Node "ESPECIFICA" — violet (#7c3aed) glow — with floating
          document panel "docs/BUSINESS.md" to its right.
      (b) Arrow DOWN to node "PROJETA" — electric blue transitioning
          to purple (#4f6ef7 → #a855f7) glow — with three stacked
          floating document panels to its right:
            "docs/ARCHITECTURE.md"
            "docs/SOLUTION.md"
            "docs/GUIDELINE.md"
      (c) Arrow DOWN to node "CONSTRÓI" — emerald green (#10b981)
          glow — with floating terminal/code panel labeled
          "[SOFTWARE]" to its right.
      (d) Arrow DOWN from "CONSTRÓI" into a glowing holographic
          DECISION DIAMOND (rhombus shape with neon edges) labeled
          "OBJETIVO ATINGIDO?". This diamond is the explicit end of the
          linear delivery sequence and the fork between the two
          possible outcomes.

[5] The decision diamond has TWO outgoing arrows, BOTH clearly drawn
    and labeled in full:
      — LEFT/UPWARD arrow labeled "não" — curves along the LEFT
        inside edge of the inner container, goes UP, and reconnects
        to the "ESPECIFICA" node, visibly closing the iteration loop
        of the delivery cycle. A small glowing caption "itera até
        atingir o GOAL" hovers beside this return arrow.
      — DOWN arrow labeled "sim" — leads straight down to a bright
        pulsing marker "■ FIM — OBJETIVO ATINGIDO" (bright white-emerald
        glow) placed at the BOTTOM of the inner container. This is
        the single exit point of the delivery cycle.

[6] Arrow from "■ FIM — OBJETIVO ATINGIDO" exits the bottom wall of the
    inner container, continues down through the bottom wall of the
    outer container, then curves AROUND THE OUTSIDE of the outer
    container along its right-hand side, sweeping upward. This curved
    arrow carries the label "novo objetivo" along its path. It
    finally re-enters the "● INÍCIO" marker at the top — visibly
    closing the full outer loop and making clear that every completed
    delivery cycle restarts the flow at the same INÍCIO point.

VISUAL EMPHASIS:
 - "● INÍCIO" (top of outer) and "■ FIM — OBJETIVO ATINGIDO" (bottom of
   inner) must be the two brightest, largest and most prominent
   markers in the composition.
 - The DECISION DIAMOND "OBJETIVO ATINGIDO?" with its two branches
   "não" (iterate back to ESPECIFICA) and "sim" (exit to FIM) must
   be drawn as a clearly recognizable diamond shape and is the
   conceptual core of the diagram — it represents the only two
   possible outcomes at the end of the delivery cycle.

Background (behind everything, purely atmospheric): a faint glowing
vertical strand of AI neural network / digital DNA in blue-to-purple
gradient with upward-flowing particles. It must NOT obscure any node,
arrow, label or container border.

All text — container labels ("CICLO DE OBJETIVO", "CICLO DE ENTREGA"),
node names ("DEFINE OBJETIVO", "ESPECIFICA", "PROJETA", "CONSTRÓI"),
decision label ("OBJETIVO ATINGIDO?"), branch labels ("não", "sim"),
terminal markers ("● INÍCIO", "■ FIM — OBJETIVO ATINGIDO"), artifact
filenames, the loop caption ("itera até atingir o OBJETIVO") and the
return arrow label ("novo objetivo") — must be crisp, legible,
futuristic sans-serif. No text outside the specified labels.
```
