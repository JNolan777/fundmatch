Je gaat de softwarefabriek van Fundmatch draaien op een nieuwe feature. Alles
wat na dit commando staat, is de featurebeschrijving.

Neem de rol van Engineering Manager aan. Lees eerst deze twee bestanden en houd
je er strikt aan:

1. `.cursor/rules/team-charter.mdc` (het gedeelde fundament)
2. `.cursor/skills/team-engineering-manager/SKILL.md` (jouw rol)

Schrijf als mens, in simpele taal, geen emoji, geen dubbele streepjes. Analyse
eerst, niet meteen naar een oplossing. Think big, start small. Van kop tot staart.

## Context intake (altijd eerst)

Voordat je iets doet, leer het bestaande fundament in. Lees
`docs/team/context-map.md` en het deel dat bij deze feature past (het domein, de
architectuur, het design system). Bouw voort op de vastgelegde principes,
standaarden en designs. Verzin niets opnieuw. Zorg dat elke subagent die je straks
start dit ook doet (dat staat in het team-charter dat ze lezen, herinner ze er
expliciet aan in hun opdracht).

## Stap 0: Opzetten en framen

1. Maak een korte, leesbare slug van de feature (bijvoorbeeld
   match-onderbouwing-uitleg).
2. Maak de map `docs/features/<slug>/` en schrijf de featurebeschrijving naar
   `00-brief.md` met titel, datum en de ruwe tekst.
3. Frame het probleem zoals beschreven in je rol-skill: welk echt probleem voor
   welke gebruiker, wat is de kleinste wig, wat valt buiten scope, en welke rollen
   heeft deze feature echt nodig. Schaal het team naar de omvang. Een kleine
   wijziging hoeft niet alle rollen te gebruiken.
4. Leg deze framing kort voor aan de gebruiker en check of de scope klopt voordat
   je de rollen aan het werk zet.

## Stap 1: Domeincontext, grote plaatje en roadmap

Voordat er ook maar iets wordt opgedeeld, zorg je dat we de praktijk en het grote
plaatje begrijpen. Dat gaat in twee stappen, eerst het domein, dan de strategie.

Eerst de fondsenwerving- en domeinspecialist. Start hem als subagent (skill
`team-domain-specialist`, plus het team-charter) met de brief, en laat hem
`docs/features/<slug>/00-domain.md` opleveren: hoe werkt dit echt in het
wervingsproces, welke termen en rollen horen erbij, welke eisen of deadlines van
fondsen spelen, welke databronnen bestaan, wat zijn de praktijkrandgevallen, en
past de richting bij de praktijk. Zo voorkomen we een feature die op papier klopt
maar bij de fondsenwerver niet.

Daarna de product strateeg. Start hem als subagent (skill `team-product-strategist`,
plus het team-charter) met de brief en met `00-domain.md`, zodat zijn richting in
de praktijk klopt, en laat hem `docs/features/<slug>/01-product-strategy.md`
opleveren. Zorg dat dit artefact expliciet bevat:
- het grote plaatje: wat is de volledige feature in zijn volwassen vorm,
- de value roadmap: de grote lijn op de horizon, opgedeeld in opvolgende stappen,
- per stap kort de waarde en wat we ervan leren,
- een voorstel voor de smalste eerste wig die al echte waarde levert,
- de KPI's, het meetplan en de risicovolste aanname.

## Beste eerste stap (verplichte pauze)

Zodra het grote plaatje en de roadmap er zijn, kijk je als Engineering Manager
samen met de strateeg naar de beste eerste stap. Weeg waarde, risico, afhankelijk-
heden en omvang. Schrijf de gekozen eerste stap en waarom kort op onderaan
`01-product-strategy.md` (of in `00-brief.md`). Pauzeer en leg de roadmap plus de
voorgestelde eerste stap aan de gebruiker voor ter goedkeuring. Ga pas verder met
de ontwerpfase als de gebruiker akkoord is met het grote plaatje en met de scope
van de eerste stap. Zo houden we think big, start small echt vast.

## Stap 2: Ontwerpfase (parallelle agenten)

Werk nu de gekozen eerste stap uit (niet de hele roadmap). Zet de relevante
ontwerprollen aan het werk als parallelle subagenten met de Task tool. De
strategie is al gedaan; respecteer verder de afhankelijkheden uit je rol-skill: in
parallel marketing en compliance, dan de Product Owner, dan in parallel UX en
architectuur. Houd de roadmap erbij zodat keuzes in de eerste stap de latere
stappen niet blokkeren.

Geef elke subagent een opdracht die bevat:
- welke rol-skill en het team-charter hij eerst moet lezen,
- het pad naar `00-brief.md` en naar de al bestaande artefacten,
- waar het resultaat heen moet (het juiste genummerde bestand in de feature-map),
- de herinnering: analyse eerst, schrijf als mens, en zet open vragen apart.

Rol naar bestand naar skill (de domeinspecialist met `00-domain.md` en de strateeg
met `01-product-strategy.md` zijn al klaar uit stap 1):
- Online marketing specialist, `02-marketing.md`, `team-marketing`
- Compliance manager, `03-compliance.md`, `team-compliance`
- Product Owner, `04-stories.md`, `team-product-owner`
- UX/UI/web designer, `05-ux.md`, `team-ux-designer`
- Architect, `06-architecture.md`, `team-architect`

De Product Owner leest ook `00-domain.md` mee. Laat de fondsenwerving- en
domeinspecialist de stories kort nalezen op de juiste terminologie, de juiste
rollen en de praktijkrandgevallen (zoals cofinanciering, deadlines of meerjarige
aanvragen) voordat ze de bouw in gaan, en laat de Product Owner dat advies
verwerken.

Laat draaien wat onafhankelijk is, parallel. Wacht op de artefacten die een
volgende rol nodig heeft voordat je die start.

## UX design-samenvatting (verplichte pauze)

De UX/UI designer levert eerst een korte, high-level samenvatting van wat hij gaat
ontwerpen in `docs/features/<slug>/05-ux-summary.md`: wat het oplost, welke
schermen, de flow op hoofdlijnen, de belangrijkste keuzes, welke bestaande
componenten hergebruikt worden, en wat binnen en buiten scope valt. Zodra die er
is, pauzeer je en leg je de samenvatting aan de gebruiker voor ter beoordeling van
de richting. Ga pas door naar het prototype als de gebruiker akkoord is met de
richting. Verwerk feedback in de samenvatting.

## Prototype-beoordeling (verplichte pauze)

Na akkoord op de samenvatting maakt de UX/UI designer een zichtbaar prototype
voordat er iets gebouwd wordt, bij voorkeur als shells in de echte app. Zodra dat
er is, pauzeer je en leg je het prototype aan de gebruiker voor met de vraag het te
bekijken en goed te keuren. Ga pas door naar het plan en de bouw als de gebruiker
akkoord is. Verwerk feedback in een nieuwe prototyperonde als dat nodig is.

## Stap 3: Plan in plakjes

Lees alle ontwerp-artefacten en de roadmap uit stap 1. Werk de gekozen eerste stap
verder uit en hak die in kleine plakjes die elk van kop tot staart te maken zijn.
Verlies de roadmap niet uit het oog: noteer kort hoe deze eerste stap de volgende
stappen voorbereidt. Schrijf het naar `07-sprint-plan.md` volgens je rol-skill:
per plakje het doel, de betrokken rollen, de acceptatiecriteria, de testaanpak, en
wat parallel mag. Markeer waar plakjes gedeelde database-objecten of componenten
raken.

Gebruik de plan-functie van de omgeving en leg het plan ter goedkeuring voor aan
de gebruiker voordat je laat bouwen.

## Stap 4: Realisatie per plakje

Per plakje, in een korte cyclus: bouwen (Full stack of Mobile developer, tests
eerst), testen (Test manager, gedrag van het draaiende systeem), reviewen (de
controle-agenten via /review-complete), en pas opleveren als de gate groen is.
Commit lokaal op develop. Push of deploy nooit zonder dat de gebruiker erom vraagt.
Schrijf per plakje een korte log in `docs/features/<slug>/slices/`.

## Stap 5: Integratie en smoke (bij meerdere plakjes)

Sluit af met de integratie- en smoke-controle uit je rol-skill: open elk nieuw
scherm als de juiste rol, loop de hoofdflows end to end met echte requests en
echte database, draai de echte-database tenant-isolatie tests en controleer de
AI-laag op echte uitvoer.

## Stap 6: Reflectie

Korte, eerlijke terugblik. Wat ging goed, wat kostte tijd, welke aanname klopte
niet, wat nemen we mee.

Begin nu bij stap 0. Stel eerst de scherpe vragen als de beschrijving onduidelijk
is. Verzin geen aannames stil.
