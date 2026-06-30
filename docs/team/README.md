# Het agentic team van Fundmatch

Dit is de softwarefabriek van Fundmatch. Het is een team van gespecialiseerde
rollen die samen een idee omzetten in een werkende, geteste en opgeleverde
feature. Fundmatch is een AI-first SaaS voor fondsenwerving, en het team is daar
helemaal op toegesneden.

Je geeft een featurebeschrijving door en de Engineering Manager regisseert de
rest. Elke rol doet vanuit zijn eigen expertise zijn deel, levert een afgesloten
artefact op, en de volgende rol bouwt daarop voort.

## Hoe gebruik je het

De fabriek draaien op een nieuwe feature:

```
/feature <korte beschrijving van wat je wilt>
```

De Engineering Manager pakt dan de regie. Het verloopt in twee fases:

1. Ontwerpfase. Eerst zorgt de fondsenwerving- en domeinspecialist samen met de
   product strateeg voor de domeincontext en het grote plaatje. Daarna draaien
   meerdere rollen parallel hun analyse en leveren elk hun artefact op in
   `docs/features/<slug>/`. Denk aan domeincontext, productstrategie, marketing,
   compliance, user stories, UX en architectuur.
2. Realisatiefase. De Engineering Manager hakt het werk in kleine plakjes. Per
   plakje gaat het van kop tot staart: bouwen, testen en opleveren.

Een losse rol handmatig inschakelen kan ook:

```
/role-architect        de architect
/role-ux-designer      de UX/UI/web designer
/role-test-manager     de test manager
... enzovoort, zie /team voor de volledige lijst
```

Controleren of een feature of plakje echt compleet is:

```
/review-complete <slug of pad naar de feature-map>
```

Dit start parallelle controle-agenten die elk vanuit hun eigen vakgebied
nakijken of alles erin zit en aan de kwaliteitseisen voldoet.

## Feedback teruggeven aan het team

Heb je een artefact, samenvatting, prototype of plakje gezien en wil je dat
aanpassen, dan geef je je feedback met:

```
/feedback <slug>: <jouw feedback>
```

De Engineering Manager legt je feedback vast in `docs/features/<slug>/feedback/`,
laat de geraakte rollen die parallel doornemen en in hun artefacten verwerken, en
houdt rekening met de afhankelijkheden (verandert de strategie, dan volgen stories,
UX en architectuur). Daarna stelt hij de logische volgende stap voor: een
bijgewerkte samenvatting, een nieuwe prototyperonde, een bijgewerkt plan, of de
gate. Het proces pauzeert voor jouw akkoord.

## Beheer en troubleshooting vragen aan de OPS manager

Voor bugs, incidenten, onderhoud, logcontroles, issue-analyse en functioneel
beheer schakel je de OPS manager in met:

```
/ops <jouw vraag of probleem>
```

De OPS manager werkt volgens het beheer-playbook
(`docs/team/operations-playbook.md`): hij weet waar de secrets en access tokens
staan (Doppler en de lokale `.env.local`), hoe hij de database bekijkt en muteert,
hoe logging en monitoring werken, en hij werkt methodisch van symptoom naar root
cause naar oplossing. Develop mag hij vrij inspecteren en muteren; naar staging of
productie doet hij niets zonder jouw expliciete toestemming.

## De rollen

| Rol | Wat die doet |
|-----|--------------|
| Engineering Manager | Regisseert de hele levenscyclus, bewaakt dat alle rollen hun deel doen en dat het van kop tot staart wordt opgeleverd. |
| Fondsenwerving- en domeinspecialist | Kent het echte wervingsproces, de terminologie, de fondsen en de databronnen (ANBI, subsidies, vermogensfondsen). Denkt vooraf mee met de strateeg, adviseert de Product Owner en controleert achteraf op aansluiting bij de praktijk. |
| Product strateeg | Vindt pijnpunten en kansen, bepaalt waarde, business- en licentiemodellen, go to market, value roadmap en KPI's. |
| Online marketing specialist | Maakt per feature meteen de solution marketing, positionering, doelgroep, kanalen en meetplan. |
| Product Owner | Vertaalt features naar bouwbare user stories met BDD acceptatiecriteria. |
| UX/UI/web designer | Ontwerpt strakke, simpele, zelfverklarende schermen volgens het design system, met maximaal hergebruik. |
| Architect | Bewaakt schaalbaarheid, herbruikbaarheid, veiligheid, performance, kosten, de AI-laag en multi-tenant isolatie. |
| Test manager | Borgt kwaliteit volgens de test trophy: static analysis, unit, integratie en waar nodig ketentests. |
| Compliance manager | Bewaakt privacy, beleid, voorwaarden, AVG en de zorgvuldige omgang met donor- en aanvraagdata en met de AI-laag. |
| Full stack developer | Bouwt de web- en backend-features volgens plan en design system. |
| Mobile developer | Bouwt de mobiele features in React Native. |
| OPS manager | Bewaakt logging, monitoring, omgevingen, kosten, disaster recovery en deployment. |

## Het fundament

Alle rollen delen een gezamenlijk fundament. Dat staat in de rule
`.cursor/rules/team-charter.mdc`. Daar staat hoe we schrijven, hoe we werken
(analyse eerst, shift left, think big start small), hoe de artefacten aan elkaar
worden doorgegeven en wat de overkoepelende definition of done is.

Daarnaast ligt de inhoudelijke basis vast in `docs/foundation/`:
`product-vision.md`, `domain-fundraising.md`, `architecture-principles.md` en
`design-system.md`. De rollen nemen die als bron en verzinnen niets opnieuw.

## Context intake: altijd eerst de bestaande kennis inleren

Voordat een rol iets ontwerpt, plant of bouwt, leert hij eerst het bestaande
fundament in. Dat is een aparte laag, geen herhaling per rol:

- `docs/team/context-map.md` is de index van alle bestaande kennis: het domein,
  de architectuur, het datamodel, het design system, meertaligheid en testen.
- Het team-charter dwingt af dat elke rol de context-map en het relevante deel
  leest, en eerst zoekt of iets al bestaat voordat hij iets nieuws maakt.
- Zo blijft het team binnen de vastgelegde principes, standaarden en designs en
  verzint het niets opnieuw.

Werk je aan nieuwe of veranderde documentatie, architectuur of een nieuw
component, werk dan ook de context-map en het fundament bij zodat de index actueel
blijft.

## UX met twee reviewmomenten

De UX/UI/web designer werkt met twee korte reviewmomenten, zodat je vroeg kunt
bijsturen en niet pas aan het eind:

1. Design-samenvatting. Eerst een korte, high-level beschrijving van wat hij gaat
   ontwerpen in `docs/features/<slug>/05-ux-summary.md`: wat het oplost, welke
   schermen, de flow op hoofdlijnen, de belangrijkste keuzes en wat binnen en
   buiten scope valt. Het proces pauzeert en legt dit aan jou voor ter beoordeling
   van de richting.
2. Prototype. Na akkoord op de richting maakt hij een zichtbaar prototype, bij
   voorkeur als shells in de echte app. Het proces pauzeert opnieuw en legt het
   prototype aan jou voor. Pas na akkoord gaat het richting plan en bouw.

## Doorbouwen zonder steeds te blijven hangen

Een project-hook keurt veilige, vaak gebruikte commando's automatisch goed, zodat
het team kan doorwerken zonder dat je elke keer iets moet goedkeuren. Risicovolle
commando's vraagt het altijd aan jou.

- Hook: `.cursor/hooks.json` en `.cursor/hooks/approve-safe-commands.sh`.
- Automatisch goedgekeurd: tests, validate, build, lint, type-check, git add en
  commit, en andere veilige dev-commando's.
- Altijd ter bevestiging: git push, deploys, supabase db push, doppler secrets
  schrijven, rm met opties, drop, delete of alter in SQL, sudo, force operaties,
  en alles wat naar buiten communiceert zoals curl. Ook een compound commando dat
  een van deze bevat.
- Onbekende commando's worden standaard ter bevestiging voorgelegd.

Volledig autonome bouwsessie nodig? Maak het bestand `.cursor/team-autorun-on`
aan. Dan worden ook onbekende commando's automatisch goedgekeurd. De risicovolle
lijst blijft altijd om bevestiging vragen, ook in deze modus. Verwijder het
bestand om weer voorzichtig te werken.

De allowlist staat in het hookscript en kun je naar smaak aanpassen. Als de hook
niet meteen werkt, herlaadt Cursor `hooks.json` bij opslaan, of herstart Cursor
even.

## Waar de skills staan

- Rol-playbooks: `.cursor/skills/team-<rol>/SKILL.md`
- Gedeeld fundament: `.cursor/rules/team-charter.mdc`
- Inhoudelijke basis: `docs/foundation/`
- Commands: `.cursor/commands/feature.md`, `.cursor/commands/feedback.md`,
  `.cursor/commands/team.md`, `.cursor/commands/review-complete.md` en
  `.cursor/commands/role-*.md`
- Artefacten per feature: `docs/features/<slug>/`
