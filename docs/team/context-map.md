# Context map Fundmatch

Dit is de index van de bestaande kennis en het fundament van Fundmatch. Elke rol
leest hier eerst het deel dat bij zijn taak hoort, voordat hij iets ontwerpt, plant
of bouwt. Het doel is simpel: bouw voort op wat er al is, verzin niets opnieuw, en
blijf binnen de vastgelegde principes, standaarden en designs.

Lees niet alles elke keer. Lees gericht wat bij je rol en je taak past. Twijfel je
of iets al bestaat, zoek het dan eerst op in de code voordat je iets nieuws maakt.

Fundmatch is een jong, AI-first product. Veel patronen worden nu voor het eerst
gelegd. Leg een nieuw patroon bewust en herbruikbaar vast in het fundament, en werk
deze context-map bij zodat de index actueel blijft.

## Het belangrijkste startpunt

- `.cursor/rules/team-charter.mdc`: het gedeelde fundament (schrijfstijl,
  werkwijze, artefactenstroom, definition of done). Leidend.
- De inhoudelijke basis in `docs/foundation/`:
  - `product-vision.md`: visie, probleem, doelgroep, model, roadmap, KPI's.
  - `domain-fundraising.md`: het wervingsproces, terminologie, spelers,
    databronnen, GO/PARK/STOP, praktijkrandgevallen.
  - `architecture-principles.md`: de toetsstenen, de stack, multi-tenant, auth, de
    AI-laag, beveiliging, performance, logging en omgevingen.
  - `design-system.md`: principes, tokens, componenten, pagina-skeletten, de twee
    reviewmomenten.

## Domein (fondsenwerving)

- Lees `docs/foundation/domain-fundraising.md` voordat je een domeinkeuze maakt.
- De kern: het institutionele wervingsproces van profiel, prospecteren, fit
  beoordelen (GO/PARK/STOP), aanvraag schrijven, indienen en volgen, beschikking,
  en verantwoorden.
- De juiste terminologie staat in dat document. Gebruik de termen van de sector in
  de UI (Nederlands), en Engels in code en data.

## Architectuur

- `docs/foundation/architecture-principles.md` is de gezaghebbende bron.
- Stack: pnpm monorepo met Turborepo, Next.js App Router en TypeScript strict voor
  web en admin, React Native (Expo) voor mobiel, Supabase (Postgres) met RLS,
  Tailwind met design tokens, en een serverside AI-gateway.
- Multi-tenant: elke organisatie is een tenant, isolatie via RLS. De fondsendatabase
  is gedeelde, alleen-lezen referentiedata.
- Auth: Supabase Auth, httpOnly cookies op web en admin, Bearer op mobiel, met
  org-context in elke geautoriseerde request.
- De AI-laag is altijd serverside, met gestructureerde uitvoer, privacyveilig en
  kostenbewust.

## Datamodel en schema

- Lees de schemadocumentatie voordat je een query schrijft. Raad geen kolomnamen.
- Het schema en de migraties horen bij de Supabase-opzet in `packages/supabase` en
  per app waar van toepassing. Werk de schemadocs bij bij elke migratie.
- Inspecteren van de live database: via de Supabase MCP uit `.mcp.json` en via de
  scripts in `scripts/` (zie het operations-playbook). Op develop mag je vrij
  inspecteren, op staging en productie alleen lezen tenzij expliciet anders
  gevraagd.

## Design system

- `docs/foundation/design-system.md` is de gezaghebbende bron.
- Tokens en componenten leven in `packages/ui`. Hergebruik `Button`, `Icon`,
  `Input`, `FormField`, `Dropdown`, `Table`, `FilterPanel`, `Pagination`, `Modal`,
  `Card`, `PageHeader`, `EmptyState`, en de AI-componenten `ChatThread`,
  `MatchResult` en `ProposalEditor`.
- Web en admin delen `packages/ui`. De mobiele app deelt de tokens en de merk-DNA,
  met eigen native componenten.
- Pagina's volgen het vaste skelet (PageHeader plus content-container plus een vast
  patroon). Verzin geen nieuwe pagina-indeling.

## Meertaligheid

- Bronteksten en helpers in `packages/translations`. Nederlands is de brontaal,
  daarna EN, DE en FR voor de Europese uitrol.
- Alle gebruikersteksten via i18n, geen hardgecodeerde teksten. Datums en bedragen
  via de format-helper.

## Testen

- Test trophy en TDD/BDD: het beleid staat bij de test manager
  (`.cursor/skills/team-test-manager/SKILL.md`).
- Echte-database tests voor RLS en tenant-isolatie, contracttests op de API-grens
  tussen web, admin, mobiel en backend, en tests op de gestructureerde AI-uitvoer.
- De testopzet en de helpers leven per app in de testmappen en in de gedeelde
  packages. Hergebruik bestaande testhelpers boven nieuwe.

## Beheer, troubleshooting en toegang

- Leidraad voor beheer: `docs/team/operations-playbook.md`. Hierin staat waar de
  secrets en access tokens staan (Doppler en de lokale `.env.local`), hoe je de
  database bekijkt en muteert, hoe logging en monitoring werken, en de
  troubleshooting-werkwijze.
- Beheer- en troubleshooting-vragen stel je aan de OPS manager met `/ops <vraag>`.

## Apps en packages

- `apps/web`: het productportaal voor fondsenwervers (Next.js).
- `apps/admin`: het beheerportaal (Next.js).
- `apps/mobile`: de React Native (Expo) app, praat met de backend-API.
- `packages/ui`: design system componenten en tokens.
- `packages/contracts`: API- en datacontracten (schema's, types).
- `packages/types`: gedeelde TypeScript types.
- `packages/supabase`: database client, generated types, migratie-helpers.
- `packages/ai`: de AI-gateway, prompts en gestructureerde uitvoer.
- `packages/translations`: i18n bronteksten en helpers.
- `packages/auth`: auth- en org-context helpers.

Deze structuur is de richting uit de architectuurprincipes. Bestaat een app of
package nog niet, dan leg je hem aan volgens dat document en werk je deze map bij.

## Bestaande features als voorbeeld

Voordat je iets nieuws bouwt, zoek een bestaande, vergelijkbare feature en volg
dat patroon. Omdat het product jong is, kan het zijn dat een patroon nog niet
bestaat. Leg het dan bewust en herbruikbaar aan en documenteer het in het
fundament, zodat de volgende rol erop voortbouwt.

## De regel bij twijfel

Bestaat er al een component, patroon, helper of view die past? Gebruik die. Een
nieuw ding maken mag alleen als je hebt gezocht en het echt niet bestaat, en je
legt dan uit waarom een nieuw, herbruikbaar ding nodig is, en je legt het vast in
het fundament.
