# Design system Fundmatch

Dit is de gezaghebbende bron voor het design system en de UI-standaarden. De UX/UI
designer beheert dit document. Developers nemen het als basis. Het doel: clean,
simpel, maximaal hergebruik, en consistentie zodat we snel en voorspelbaar
ontwikkelen.

Status: levend document. Mist er echt iets, dan breid je het systeem uit en leg je
de nieuwe waarde hier vast, zodat hij herbruikbaar wordt. Niet per scherm afwijken.

## De principes

- Minder is meer. Elk element verdient zijn bestaan. Twijfel je, haal het weg.
- Zelfverklarend boven uitleg. Een goed scherm heeft bijna geen handleiding nodig.
- Consistentie is de kern, geen detail. Dezelfde spacing, typografie en componenten
  overal. Rust ontstaat door herhaling, niet door variatie.
- Atomic design. Bouw van atomen (knop, invoerveld, icoon) naar moleculen
  (zoekbalk, formulierveld), naar organismen (tabel, filterpaneel), naar templates
  en pagina's. Ontwerp in herbruikbare bouwstenen, niet in losse schermen.
- Hergebruik boven nieuw. Een nieuw component is bijna altijd een teken dat je iets
  bestaands over het hoofd ziet.
- Toegankelijk. WCAG 2.1 AA als ondergrens: contrast, toetsenbordbediening,
  gekoppelde labels, betekenisvolle alt-teksten.

## Design tokens (de enige bron van waarheid voor stijl)

Alle stijl komt uit tokens. Nooit losse hexwaarden of magische getallen in een
component. De tokens leven in `packages/ui`.

### Kleur

Een kleine, functionele set. Leun op neutraal, zet kleur bewust in.

- Neutraal: een schaal van bijna-zwart (`#111111`) via grijstinten naar wit. Tekst
  donker op licht, oppervlakken wit op een lichtgrijze achtergrond.
- Primair (accent en hoofdactie): blauw `#4F8EF7`.
- Secundair: paars `#8E4FF7`, spaarzaam, voor onderscheidende accenten.
- Status: succes groen `#22C55E`, waarschuwing amber `#EAB308`, fout rood
  `#EF4444`.
- Domeinstatus GO/PARK/STOP: GO gebruikt succes-groen, PARK gebruikt
  waarschuwing-amber, STOP gebruikt fout-rood. Dit is het enige plek waar status
  consequent met kleur wordt gecodeerd, want het is functioneel kernonderdeel.

Regel: weinig kleuren per scherm. Kleur heeft altijd een reden (accent trekt
aandacht naar de hoofdactie, rood waarschuwt, groen bevestigt). Kleur nooit als
decoratie. Haal kleur altijd uit een token.

### Spacing (vaste schaal van 4)

Gebruik alleen deze schaal voor padding, marges en gaps. Geen 7, 13 of 19.

`4, 8, 12, 16, 24, 32, 48, 64`

Dezelfde soort elementen krijgen dezelfde ruimte. Twee kaarten of twee
formuliervelden hebben identieke padding en tussenruimte. Wat op het ene scherm
24px marge heeft, heeft dat op het andere ook.

### Radius en schaduw

- Radius: `8` (klein, knoppen en velden), `12` (kaarten), `16` (panelen), `20`
  (grote blokken). Niet daartussenin verzinnen.
- Schaduw: een zachte paneelschaduw voor witte kaarten op de grijze achtergrond.
  Een vaste waarde uit de tokens.

### Typografie

- Systeem-sans als basislettertype.
- Een vaste, beperkte schaal van groottes en gewichten. Een handvol niveaus is
  genoeg: paginatitel, sectiekop, body, secundair, klein label. Verzin geen
  tussenmaten.
- Beperk het aantal verschillende groottes per scherm. Zet grootte, gewicht en
  kleur in om hierarchie te tonen, niet om te versieren.
- Tekst in sentence case. Alleen het eerste woord een hoofdletter. Kort en helder.

### Iconen

- Een set met dunne lijn, consistente stijl, vaste maten. Vaste betekenis per
  icoon (plus is toevoegen, pen is bewerken, prullenbak is verwijderen, opslaan is
  opslaan). Verzin geen nieuwe betekenis per scherm.

## De componenten (atomic, herbruikbaar)

Bouw deze bouwstenen een keer goed in `packages/ui` en hergebruik ze overal.
Verzin geen eigen varianten per scherm.

- Atomen: `Button`, `Icon`, `Input`, `Label`, `Badge`, `Avatar`, `Spinner`.
- Moleculen: `FormField` (label plus input plus fouttekst, verticale layout),
  `SearchBar`, `Dropdown` (de canonieke single-select, geen native select),
  `Tag`.
- Organismen: `Table` (met de standaard celbouwstenen, sortering en lege en
  laadstaten), `FilterPanel`, `Pagination`, `Modal`, `Card`, `PageHeader` (titel,
  icoon en acties), `EmptyState`.
- AI-specifiek: `ChatThread` (de conversatie), `MatchResult` (een fonds met
  GO/PARK/STOP score en onderbouwing), `ProposalEditor` (tekstveld met AI-suggestie
  en menselijke bewerking).

### Knoppen

- Twee vormen: tekstknop met label en vaste hoogte per maat, en icon-only knop met
  tooltip. Een primaire actie per context, de rest is outline of ghost.
- Varianten hebben betekenis: primair is de hoofdactie, danger alleen voor
  verwijderen. Verzin geen gekleurde knoppen.

### Tabellen

- Altijd het `Table` component, nooit eigen tabel-markup. Celtypografie, rijhoogte,
  kopstijl, padding en de sorteer-affordance horen bij het component.
- Status in een rij is platte tekst of tekst met een token-tint, geen gekleurde
  achtergrond-badge, behalve de functionele GO/PARK/STOP indicator.

## De pagina-skeletten (vaste layouts)

De app is bewust repetitief. Elke pagina gebruikt hetzelfde skelet en dezelfde
containers. Dat is de kwaliteitslat, geen beperking: voorspelbaarheid maakt de app
strak en snel te bouwen. Verzin geen nieuwe pagina-indeling.

Het standaard skelet:

1. `PageHeader`: paginakop met titel, icoon links en acties rechts.
2. Een content-container: witte kaart met vaste padding (24), radius (16) en de
   paneelschaduw, met een vaste marge boven de header (32).
3. Binnenin een van de vaste patronen:
   - Overzicht: `FilterPanel` plus `Table` plus `Pagination`.
   - Detail: een detailweergave (read-only) met een bewerk-affordance, en
     gerelateerde secties.
   - Dashboard: een metrics-rij plus een grid van content-panels.
   - Conversatie (AI): `ChatThread` met de matches of het resultaat eronder.

Subnavigatie binnen een sectie hoort in de pagina (een in-page navigatie of tabs),
niet als tweede niveau in de hoofdnavigatie. De hoofdnavigatie blijft een niveau.

## Tonen versus bewerken

Scheid het tonen van een record van het bewerken ervan. Een detailpagina opent
read-only met een bewerk-affordance. Een gerichte, korte actie (klein record maken
of bewerken, een relatie leggen, een bevestiging) gebeurt in een `Modal`, zodat de
gebruiker in context blijft. Een bewerkpatroon per scherm, niet mengen.

## Meertaligheid in het ontwerp

Alle teksten gaan via i18n. Ontwerp met de gedachte dat tekst in een andere taal
langer of korter kan zijn. Houd ruimte vrij en vermijd vaste breedtes voor tekst.
Datums en bedragen via een format-helper, nooit hardgecodeerd.

## Web en mobiel

Web en admin delen dit design system via `packages/ui`. De mobiele app (React
Native) deelt dezelfde merk-DNA en tokens (kleuren, spacing, typografie,
GO/PARK/STOP), maar heeft eigen, native componenten. Zet vaste pixelmaten uit een
ontwerp om naar responsieve layout. Kleine vaste elementen zoals iconen mogen een
vaste maat houden. Houd web en mobiel consistent in taal en betekenis.

## De twee verplichte reviewmomenten

De UX/UI designer werkt met twee korte reviewmomenten, zodat je vroeg kunt
bijsturen:

1. Design-samenvatting. Eerst een korte, high-level beschrijving van wat hij gaat
   ontwerpen in `docs/features/<slug>/05-ux-summary.md`: wat het oplost, welke
   schermen, de flow op hoofdlijnen, de belangrijkste keuzes, welke bestaande
   componenten hergebruikt worden, en wat binnen en buiten scope valt. Het proces
   pauzeert en legt dit voor ter beoordeling van de richting.
2. Prototype. Na akkoord op de richting volgt een zichtbaar prototype. De standaard
   is shells in de echte app (correcte routing, componenten en layout, met
   realistische dummy data en alle zichtbare acties), niet een losstaand HTML-
   bestand. Een losstaand HTML-prototype mag alleen bij een echt nieuw concept dat
   anders niet te beoordelen is, met de reden erbij. Het proces pauzeert opnieuw en
   legt het prototype voor. Pas na akkoord gaat het richting plan en bouw.

## De regel bij twijfel

Twijfel je over een grootte, gewicht, kleur of afstand, kies dan de waarde die al
in het design system staat en die elders al gebruikt wordt. Voeg pas een nieuwe
waarde toe als je hebt vastgesteld dat hij echt mist, en leg hem dan hier vast.
