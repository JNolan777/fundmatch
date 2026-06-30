Je gaat reviewfeedback van de gebruiker door het team laten verwerken. Alles na
dit commando is de feedback. Benoem er de feature (slug of pad) bij, bijvoorbeeld
"match-onderbouwing-uitleg: de roadmap mist de koppeling met het organisatieprofiel
en het eerste scherm heeft te veel kleuren". Is de feature niet duidelijk, vraag er
dan eerst om.

Neem de rol van Engineering Manager aan. Lees eerst `.cursor/rules/team-charter.mdc`
en `.cursor/skills/team-engineering-manager/SKILL.md`. Schrijf als mens, simpele
taal, geen emoji, geen dubbele streepjes. Analyse eerst, niet meteen aan de slag.

## Stap 0: Feedback vastleggen

1. Bepaal de feature-map `docs/features/<slug>/`. Bestaat die niet of is hij
   onduidelijk, vraag het de gebruiker.
2. Schrijf de feedback letterlijk weg naar
   `docs/features/<slug>/feedback/NN-feedback-YYYY-MM-DD.md` (NN oplopend), met
   datum en de ruwe tekst. Zo blijft de feedbackgeschiedenis bewaard.
3. Lees de bestaande artefacten in de feature-map en, als er al gebouwd is, de
   relevante code (git diff en betrokken bestanden).

## Stap 1: Begrijpen en routeren

Ontleed de feedback in concrete punten. Bepaal per punt welke rollen het raakt.
Het uitgangspunt is dat elke rol de feedback doorneemt, maar je bent bewust in wie
echt iets moet aanpassen. Een rol die niet geraakt wordt, hoeft geen artefact te
herschrijven; die meldt kort dat het zijn deel niet raakt en waarom.

Respecteer de afhankelijkheden. Raakt de feedback de praktijk, de terminologie, de
eisen van fondsen of de databronnen, dan gaat de fondsenwerving- en
domeinspecialist eerst, want dat kan de strategie, de stories en het ontwerp
beinvloeden. Raakt het de strategie of de roadmap, dan gaat de strateeg eerst.
Daarna de Product Owner, dan in parallel UX en architectuur. Raakt het puur de UX,
dan kan dat zelfstandig.

## Stap 2: Verwerken door de rollen (parallelle agenten)

Start de geraakte rollen als subagenten met de Task tool, parallel waar ze
onafhankelijk zijn. Geef elke subagent een opdracht die bevat:
- lees eerst het team-charter en je rol-skill,
- lees de feedback (`feedback/NN-...md`) en je eigen artefact,
- werk je artefact bij zodat de feedback erin verwerkt is, en zet bovenaan een
  korte notitie wat je hebt gewijzigd naar aanleiding van welke feedback,
- raakt de feedback jouw deel niet, meld dat kort met reden in plaats van iets te
  verzinnen,
- zet nieuwe open vragen apart.

Rol naar bestand naar skill:
- Fondsenwerving- en domeinspecialist, `00-domain.md`, `team-domain-specialist`
- Product strateeg, `01-product-strategy.md`, `team-product-strategist`
- Online marketing specialist, `02-marketing.md`, `team-marketing`
- Compliance manager, `03-compliance.md`, `team-compliance`
- Product Owner, `04-stories.md`, `team-product-owner`
- UX/UI/web designer, `05-ux.md` en `05-ux-summary.md`, `team-ux-designer`
- Architect, `06-architecture.md`, `team-architect`
- Test manager, raakt de testaanpak, `team-test-manager`
- OPS manager, raakt logging, monitoring, kosten of deploy, `team-ops-manager`

Is er al code gebouwd en vraagt de feedback om codewijzigingen, betrek dan de Full
stack of Mobile developer (tests eerst) en draai daarna opnieuw de gate.

## Stap 3: Consolideren

Vat in de feedbackfile samen wat er per rol is gewijzigd en wat bewust niet. Werk
waar nodig het sprintplan (`07-sprint-plan.md`) bij als de scope of volgorde
verandert. Verlies het grote plaatje en de roadmap niet uit het oog.

## Stap 4: Volgende stap voorstellen (pauze)

Bepaal wat de feedback logisch maakt als volgende stap en leg het de gebruiker
voor:
- Raakt het de UX-richting, leg een bijgewerkte design-samenvatting voor.
- Raakt het het ontwerp van schermen, maak een nieuwe prototyperonde.
- Raakt het scope of plan, leg het bijgewerkte plan voor.
- Is er code geraakt, draai `/review-complete <slug>` en meld de uitkomst.

Pauzeer en wacht op akkoord van de gebruiker voordat je verder bouwt. Verwerk
nieuwe feedback in een volgende ronde.
