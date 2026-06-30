Toon een kort overzicht van het agentic team van Fundmatch en hoe je het
gebruikt. Schrijf als mens, simpele taal, geen emoji, geen dubbele streepjes.

Leg uit:

- De fabriek draai je met `/feature <beschrijving>`. De Engineering Manager pakt
  de regie, laat de ontwerprollen parallel werken, plant in kleine plakjes en
  levert van kop tot staart op.
- De controle draai je met `/review-complete <slug>`. Parallelle controle-agenten
  kijken na of alles compleet en goed is.
- Reviewfeedback geef je met `/feedback <slug>: <jouw feedback>`. De Engineering
  Manager legt de feedback vast en laat de geraakte rollen die parallel doornemen
  en in hun artefacten verwerken, en stelt daarna de volgende stap voor.
- Beheer en troubleshooting (bugs, incidenten, onderhoud, logcontroles,
  functioneel beheer) vraag je aan de OPS manager met `/ops <jouw vraag>`. Die
  werkt volgens het beheer-playbook (`docs/team/operations-playbook.md`).
- Een losse rol schakel je handmatig in met een van de role-commands.

De rollen en hun command:

- Engineering Manager, `/role-engineering-manager`, regisseert de levenscyclus.
- Fondsenwerving- en domeinspecialist, `/role-domain-specialist`, het
  wervingsproces, terminologie, fondsen, databronnen en aansluiting bij de praktijk.
- Product strateeg, `/role-product-strategist`, waarde, model, KPI's, roadmap.
- Online marketing specialist, `/role-marketing`, positionering en go to market.
- Product Owner, `/role-product-owner`, user stories met BDD acceptatiecriteria.
- UX/UI/web designer, `/role-ux-designer`, strakke, simpele schermen, design system.
- Architect, `/role-architect`, schaalbaar, veilig, kostenbewust, de AI-laag, binnen
  de architectuur.
- Test manager, `/role-test-manager`, kwaliteit volgens de test trophy.
- Compliance manager, `/role-compliance`, privacy, beleid, donor- en aanvraagdata,
  de AI-laag.
- Full stack developer, `/role-fullstack-developer`, web- en backend-bouw.
- Mobile developer, `/role-mobile-developer`, mobiele bouw in React Native.
- OPS manager, `/role-ops-manager` of `/ops <vraag>`, logging, monitoring, kosten,
  deployment, beheer en troubleshooting.

Het gedeelde fundament staat in `.cursor/rules/team-charter.mdc`. De inhoudelijke
basis staat in `docs/foundation/`. De volledige rol-playbooks staan in
`.cursor/skills/team-<rol>/SKILL.md`. De artefacten per feature staan in
`docs/features/<slug>/`.

Geef daarna kort aan wat de gebruiker als volgende stap kan doen.
