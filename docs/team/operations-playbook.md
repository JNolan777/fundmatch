# Beheer-playbook (operations)

Dit is de leidraad voor beheer: troubleshooting, beheeracties, onderhoud,
issue-analyse, toegang tot systemen, logging en monitoring. Het beschrijft hoe we
in de praktijk werken zodat een beheeractie niet stukloopt op ontbrekende kennis,
bijvoorbeeld waar de access tokens en secrets staan.

De OPS manager (`.cursor/skills/team-ops-manager/SKILL.md`) neemt dit document als
leidraad. Lees het voordat je een beheer- of troubleshooting-taak oppakt.

Schrijf en communiceer in het Nederlands. Alles wat techniek raakt (namen van
secrets, env-vars, tabellen, API's, commando's) is Engels.

Fundmatch is een jong product. Waar een concreet stuk infrastructuur nog niet
bestaat, leg je het aan volgens `docs/foundation/architecture-principles.md` en
werk je dit playbook bij. Raad niet, leg het vast.

---

## Gouden regels

- Analyse eerst. Begrijp het probleem en verzamel bewijs voordat je iets muteert.
  Geen blinde fixes, geen workarounds.
- Develop mag, staging en productie alleen met expliciete toestemming. Op develop
  mag je vrij inspecteren en muteren. Naar staging of productie (database, deploy,
  secrets) doe je niets zonder dat de gebruiker er expliciet om vraagt.
- Secrets nooit in code, client of logs. Lees ze uit de juiste bron, echo ze niet,
  commit ze niet, en log geen tokens of persoonsgegevens.
- Servers herstart de gebruiker zelf in een externe terminal. De agent herstart
  geen dev-servers en gebruikt geen `pkill` of `kill`.
- Gebruik de bestaande scripts en patronen in `scripts/` in plaats van nieuwe
  ad-hoc oplossingen.

---

## Waar staan secrets en toegang (de kaart)

Secrets zijn bewust gelaagd, elk met een eigen doel. Pak de bron die bij je taak
hoort.

| Bron | Wat erin staat | Waarvoor je het gebruikt |
|------|----------------|--------------------------|
| Doppler | Bron van waarheid voor applicatie-secrets per omgeving (database keys, JWT signing key, de LLM-provider API key, service-to-service secret) | Taken die app-secrets nodig hebben, via `doppler run -- <command>`. Een project per app of een gedeeld project, met configs `dev`, `stg` en `prd`. |
| `.env.local` per app | Lokale runtime-kopie van de app-secrets, in sync met Doppler | Wordt automatisch gelezen door `pnpm dev`. Niet committen. |
| Supabase project keys | Anon key (client) en service role key (server, beheerd) | De anon key in de client, de service role key alleen serverside voor beheerde import, logging en gebruikersbeheer. |
| `.mcp.json` (Supabase MCP) | De verbinding voor het inspecteren van de database via MCP | Database bekijken en bevragen tijdens ontwikkeling en troubleshooting. |

Vuistregel voor welke toegang je nodig hebt:

- Database inspecteren of bevragen op develop: de Supabase MCP of een script in
  `scripts/`.
- Een app-secret nodig in een script (bijvoorbeeld de LLM API key): `doppler run --
  <command>`.
- Een gebruiker aanmaken of verwijderen: de service role key via de Supabase Admin
  API, standaard alleen op develop.

---

## Omgevingen

Drie omgevingen. Houd altijd in de gaten in welke je werkt.

| Omgeving | Branch | Waarvoor |
|----------|--------|----------|
| develop | `develop` | Lokaal plus de develop-database. Vrij inspecteren en muteren. |
| staging | `staging` | Acceptatie, automatische deploy bij push. Alleen lezen tenzij gevraagd. |
| productie | `main` | Live. Niets zonder expliciete toestemming. |

Lokaal draait de app via `pnpm dev`. Test en staging deployen automatisch via de
pipeline bij push naar die branch.

---

## Database bekijken en muteren

- Gebruik de Supabase MCP uit `.mcp.json` of de scripts in `scripts/` om de
  database te bekijken. Lees voor elke query eerst de schemadocumentatie, raad geen
  kolomnamen.
- Op staging of productie voer je alleen leesqueries uit, tenzij de gebruiker
  expliciet om een mutatie vraagt.
- Bij RLS- of auth-issues: controleer de live policy- of functiestaat, niet alleen
  of een migratie gedraaid is.

### Migraties

- Migraties horen bij de Supabase-opzet (`packages/supabase` en per app waar van
  toepassing). Develop deployen mag de agent direct voor snelle feedback.
- Naar staging of main: nooit zonder expliciet verzoek. Dat loopt via de pipeline
  bij push naar die branch.
- Werk na een migratie de schemadocs bij en controleer of views meegezogen moeten
  worden.

---

## Gebruikersbeheer (aanmaken en verwijderen)

Gebruikers beheer je via de Supabase Admin API met de service role key, niet via
losse SQL, zodat cascades correct gaan. Verifieer eerst dat de gebruiker bestaat,
voer de actie uit, en bevestig daarna dat het echt weg of aangemaakt is. Echo de
service role key nooit en ruim tijdelijke scripts op. Standaard alleen op develop.

---

## Logging en monitoring

- Centrale logger. Applicatiecode logt via de centrale logger; fouten en
  waarschuwingen gaan ook naar een opvolgbare plek. Geen `console.*` in
  applicatiecode, geen gevoelige data in logs. 100% logging als uitgangspunt.
- AI-laag. Log per AI-actie de kosten (tokens) en de uitkomst op hoofdlijnen, zodat
  we kosten en kwaliteit kunnen sturen, zonder persoonsgegevens of vertrouwelijke
  inhoud te loggen.
- Monitoring en feedback loop. Bepaal per feature welke fout een alert verdient en
  wie die oppakt. Een signaal is pas af als iemand het opvolgt.

---

## Troubleshooting-werkwijze

Werk een bug of incident methodisch af, niet met gokwerk:

1. Reproduceer en omschrijf het symptoom precies: welke app, welke rol, welke
   omgeving, welke stappen, wat zie je en wat verwacht je.
2. Verzamel bewijs uit de echte systemen: logs, relevante database-rijen via de
   Supabase MCP of scripts, en de netwerk- en statuscodes. Voor RLS- of
   auth-issues: controleer de live policy- of functiestaat.
3. Bepaal de oorzaak (root cause), tot aan de architectonische bron. Benoem wat er
   kapot is en waarom.
4. Stel oplossingen voor (meerdere, met voor- en nadelen) als het meer dan een
   triviale fix is, en wacht op een keuze bij architectonische impact.
5. Fix met een test. Volg de TDD/BDD-regel: bij een bug eerst een falende
   regressietest die het symptoom reproduceert, dan de fix, dan groen.
6. Verifieer in de draaiende app, niet alleen met mocks.

Veelvoorkomende oorzaken om vroeg te checken:

- 401 of 403 na inloggen: de org-context of de rol klopt niet, of de RLS-policy
  filtert te streng of te ruim.
- Lege of verkeerde resultaten: de tenant-context ontbreekt in de query, of een
  policy verwijst naar de verkeerde kolom.
- Trage of dure AI-uitkomst: het verkeerde model voor de taak, geen caching, of
  geen tokenbudget.
- Verouderde schema-cache na een migratie: herlaad de schema-cache.

---

## Deployment en omgevingsbeheer

- Deploy van staging en main gaat automatisch via de pipeline bij push naar die
  branch. De agent pusht nooit proactief en nooit naar staging of main zonder
  expliciet verzoek.
- Houd wijzigingen traceerbaar via migraties en commits. Hoog de mobiele
  cache-versie op als de gecachte datavorm verandert.

---

## Builds, tests, CI/CD en gates

De commando's draai je vanuit de projectroot, tenzij anders vermeld.

### Builds en validatie

- Builds en taken lopen via Turborepo. `pnpm build` bouwt alles, per app via de
  app-scripts.
- Validatie (snel): `pnpm validate` = lint plus type-check over alle apps. Los:
  `pnpm type-check` en `pnpm lint`.
- Fix alle TypeScript- en ESLint-fouten en warnings voor commit; warnings blokkeren
  de build.

### Tests

- Unit tests via Vitest. Integratietests inclusief echte-database RLS-tests voor
  tenant-isolatie. Contracttests op de API-grens tussen web, admin, mobiel en
  backend. Tests op de gestructureerde uitvoer van de AI-laag. E2E via Playwright
  voor de kritieke flows.
- De echte-database tests draaien alleen tegen develop, nooit tegen staging of
  main.

### Gates (kwaliteitspoorten)

- Pre-commit: lint en type-check op de gewijzigde bestanden.
- CI op een PR naar staging of main: static analysis (blokkeert bij elke fout of
  warning) en de testsuite met coverage.
- Team-gate: `/review-complete <slug>` start parallelle controle-agenten die per
  vakgebied nakijken of alles compleet en goed is.
- Gedrag boven artefacten: RLS-, database-, auth-, AI- en UI-werk is ook echt
  draaiend geverifieerd, niet alleen met groene mocks. Een plan met meerdere
  plakjes eindigt met een integratie- en smoke-wave.
- Branch-discipline: de agent commit lokaal op develop en pusht nooit proactief;
  naar staging of main alleen op expliciet verzoek.

---

## Secrets en kosten bewaken

- Bewaak dat secrets per omgeving kloppen en niet in code, client of logs belanden.
- Bewaak de kosten van de AI-laag: het juiste model per taak, tokenbudgetten,
  caching, en meten wat een actie kost. Een uit de hand lopende AI-rekening is een
  beheerincident.

---

## Snelle recepten

```bash
# Snel valideren (lint plus type-check)
pnpm run validate

# Alles bouwen via Turborepo
pnpm build

# Unit tests draaien
pnpm test

# Een app-secret gebruiken in een eenmalige taak
doppler run -- <command>
```
