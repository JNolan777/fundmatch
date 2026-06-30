# Architectuurprincipes Fundmatch

Dit is de gezaghebbende bron voor de architectuur en de technische stack. De
architect beheert dit document. Developers en ops nemen het als basis. Het legt de
principes en de patronen vast die het hele team hanteert, zodat we niet per feature
opnieuw beslissen.

Status: levend document. Een nieuw, herbruikbaar patroon leg je hier vast zodra je
het bewust kiest, met een korte onderbouwing.

## De toetsstenen (gelden bij elke keuze)

Fundmatch moet top-notch zijn. Bij elke architectuurkeuze toets je expliciet:

- Schaalbaar. Werkt het van tien naar tienduizend organisaties, en van NL naar
  Europa, zonder herontwerp.
- Veilig. Security en privacy by design. Multi-tenant isolatie is heilig.
- Betrouwbaar en zero-defect. Faalpaden zijn ontworpen, niet toevallig. Een fout
  bereikt de gebruiker niet stil.
- Volledig observeerbaar. 100% logging als uitgangspunt, met monitoring en
  alerting die opvolgbaar zijn.
- Performant. Snelle schermen, geen N plus 1, zware queries via views, bewuste
  caching.
- Kostenefficient. Zeker de AI-laag: het juiste model per taak, tokenbudgetten,
  caching van resultaten, en meten wat een actie kost.
- Flexibel. Modulair opgebouwd zodat we functies en landen kunnen toevoegen zonder
  de kern te breken.

Geen workarounds. Kan iets niet binnen deze principes, geef twee of drie echte
opties met voor- en nadelen en laat de keuze aan de Engineering Manager.

## De stack

- Monorepo met pnpm workspaces en Turborepo voor build, test en lint.
- Web en admin: Next.js (App Router), TypeScript strict, Tailwind met design
  tokens. React Server Components waar het kan, client components waar nodig.
- Mobiel: React Native (Expo), TypeScript strict, gedeelde contracten met de
  backend.
- Backend: de API leeft in de Next.js route handlers (server). Een dunne,
  expliciete API-laag tussen client en data. Clients praten nooit direct met de
  database voor schrijfacties die businessregels of AI raken.
- Data: Supabase (Postgres) met Row Level Security voor multi-tenant isolatie.
- AI-laag: een serverside AI-gateway (een eigen module of package) die naar een
  LLM-provider praat. Geen LLM-calls vanuit de client.
- Validatie en contracten: gedeelde schema's (bijvoorbeeld met Zod) in een
  contracts-package, gebruikt door web, admin en mobiel.

## Mappenstructuur (richting)

```
apps/
  web/      productportaal voor fondsenwervers (Next.js)
  admin/    beheerportaal (Next.js)
  mobile/   React Native app (Expo)
packages/
  ui/           design system componenten en tokens
  contracts/    API- en datacontracten (schema's, types)
  types/        gedeelde TypeScript types
  supabase/     database client, generated types, migraties-helpers
  ai/           AI-gateway, prompts, gestructureerde uitvoer
  translations/ i18n bronteksten en helpers
  auth/         auth- en org-context helpers
```

Deze structuur is de richting. Leg afwijkingen vast met een reden. Hergebruik een
package boven kopieren tussen apps.

## Multi-tenant en data

- Elke organisatie (NGO) is een tenant. Tenantdata (profiel, aanvragen,
  voorstellen, rapportages, gebruikers) is strikt gescheiden.
- Isolatie loopt via RLS op elke tenant-tabel. Een policy filtert altijd op de
  org-context van de geauthenticeerde gebruiker. Vertrouw nooit alleen op de
  applicatielaag voor isolatie.
- De fondsendatabase is gedeelde, alleen-lezen referentiedata, los van de
  tenantdata. Schrijven daarop gebeurt via beheerde import, niet door tenants.
- Lees de schemadocumentatie voordat je een query schrijft, raad geen kolomnamen.
  Werk de schemadocs bij bij elke migratie.
- Lijst- en tabelschermen met data uit meerdere bronnen gebruiken een database
  view, geen geneste resource-queries.

## Auth en autorisatie

- Supabase Auth voor identiteit. httpOnly cookies op web en admin, Bearer token op
  mobiel.
- Elke API-route authenticeert, bepaalt de org-context, autoriseert de rol, en
  valideert invoer aan de serverkant. Geen handmatige tokenvalidatie verspreid door
  de code: een centrale helper.
- Rollen minimaal: platformbeheerder (admin-portaal), organisatiebeheerder, en
  gebruiker binnen een organisatie. Werk de rollen uit per feature in de stories.
- Least privilege. De service role alleen voor logging, beveiliging en beheerde
  import, nooit voor gewone datatoegang. Gebruikerscontext plus RLS is de norm.

## De AI-laag (kern van het product)

- Altijd serverside. De client stuurt intentie, de server praat met het model.
- Gestructureerde uitvoer. Vraag het model om gevalideerde, getypeerde uitvoer
  (schema), nooit ruwe tekst die je blind vertrouwt. Valideer voordat je opslaat
  of toont.
- Privacyveilig. Stuur alleen wat nodig is naar het model. Geen onnodige
  persoonsgegevens of vertrouwelijke aanvraaginhoud zonder grondslag. Stem af met
  compliance. Het flywheel leert op geanonimiseerde inzichten.
- Kostenbewust. Kies het model per taak (klein model voor extractie, groot model
  voor schrijven). Stel tokenbudgetten in, cache herbruikbare resultaten, en log
  wat een actie kost zodat we kosten kunnen sturen.
- Uitlegbaar. Een match of score komt met een onderbouwing. Bewaar genoeg context
  om een uitkomst te kunnen verklaren.
- Faalpaden. Wat als het model traag is, faalt, of onzin teruggeeft. Time-outs,
  retries met mate, en een nette degradatie naar de gebruiker.

## Beveiliging die je standaard meeneemt

- Security by design. Elke route authenticeert, autoriseert en valideert invoer
  aan de serverkant.
- Threat modeling per feature. Loop STRIDE langs: spoofing, tampering, repudiation,
  information disclosure, denial of service, elevation of privilege.
- OWASP Top 10 als checklist bij gevoelige features (auth, invoer, toegang, en de
  AI-laag: prompt injection en datalekken via het model).
- Geen geheimen in code of in de client. Secrets via Doppler en een lokale
  `.env.local` (zie het operations-playbook).

## Performance, betrouwbaarheid en kosten

- Query's met goede indexen, views voor zware lijstschermen, geen N plus 1.
- Caching bewust inzetten en invalidatie doordenken. Op mobiel de cache-versie
  ophogen als de vorm van gecachte data verandert.
- Faalpaden ontwerpen. Wat als een externe call (model, database, import) wegvalt.
- Geen single points of failure introduceren zonder het te benoemen.
- Meet de kosten van de AI-laag per actie en bewaak dat ze binnen budget blijven.

## Logging, monitoring en secrets

- 100% logging als uitgangspunt. Gebruik de centrale logger, geen console. Log met
  context, log geen gevoelige data of persoonsgegevens.
- Monitoring per feature. Welke signalen vertellen of het gezond is, welke fout
  verdient een alert, en wie volgt die op.
- Secrets via Doppler als bron van waarheid, met een lokale `.env.local` die
  daarmee in sync is. Details in `docs/team/operations-playbook.md`.

## Omgevingen en deployment

- Drie omgevingen: develop (lokaal plus develop database), staging (automatische
  deploy), productie. Migraties horen op de juiste plek en gaan via de pipeline
  naar de juiste omgeving.
- Git: lokaal committen op develop, alleen pushen als de gebruiker erom vraagt,
  nooit naar staging of main zonder expliciete vraag.

## Testen (in dienst van zero-defect)

De architect ontwerpt zo dat gedrag bewijsbaar is. Het testbeleid staat bij de
test manager, maar de architectuur ondersteunt het: testbare grenzen, echte-
database RLS-tests voor tenant-isolatie, contracttests op de API-grens tussen web,
admin, mobiel en backend, en tests op de gestructureerde AI-uitvoer.
