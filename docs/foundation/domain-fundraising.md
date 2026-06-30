# Domeinkennis fondsenwerving

Dit is de gezaghebbende bron over het domein: hoe fondsenwerving echt werkt, de
juiste terminologie, de spelers, het proces en de databronnen. De fondsenwerving-
en domeinspecialist beheert dit document. Andere rollen lezen het om geen feature
te bouwen die op papier klopt maar in de praktijk van een fondsenwerver niet.

Status: levend document. Vul het aan met nieuwe domeinkennis, en houd het eerlijk
gescheiden tussen feit en aanname.

## Twee soorten fondsenwerving

Fundmatch richt zich op fondsenwerving in brede zin. Twee hoofdvormen:

1. Institutionele fondsenwerving. Geld van fondsen, stichtingen, vermogensfondsen
   en de overheid. Dit gaat via aanvragen tegen criteria: het kernproces van V1.
   Denk aan vermogensfondsen, subsidies van gemeente, provincie, rijk en EU,
   loterijgelden en bedrijfsfondsen.
2. Private fondsenwerving. Geld van individuen en bedrijven: donaties, periodieke
   giften, grote giften (major donors), nalatenschappen, donateurswerving en
   bedrijfssponsoring. Dit is relatiegedreven in plaats van aanvraaggedreven.

V1 staat in dienst van de institutionele kant (matching en aanvragen). Private
fondsenwerving komt later in beeld (relatiebeheer, CRM, campagnes). Houd bij elk
ontwerp scherp welke vorm je raakt, want het proces en de data verschillen.

## Het institutionele wervingsproces (van zoeken tot verantwoorden)

Dit is de keten die een organisatie doorloopt. Fundmatch versimpelt elke stap.

1. Profiel: het organisatieprofiel. Wat doe je, voor wie, in welke sector en regio,
   welk budget, welke rechtsvorm en status (zoals ANBI). Dit profiel is de basis
   voor matching.
2. Prospecteren: fondsen vinden die passen. Welke fondsen geven aan dit thema, in
   deze regio, op deze schaal, en staan open voor aanvragen.
3. Fit beoordelen. Past de organisatie en het project bij de doelstelling en de
   criteria van het fonds. Hier zit de winst: alleen aanvragen waar je echt past.
   Fundmatch drukt dit uit als GO, PARK of STOP met een onderbouwing.
4. Aanvraag schrijven. Een projectplan en begroting opstellen volgens de eisen van
   het fonds, vaak per fonds in een eigen format met eigen vragen.
5. Indienen en volgen. Indienen via het kanaal van het fonds, deadlines bewaken,
   status bijhouden (concept, ingediend, in behandeling, toegekend, afgewezen).
6. Beschikking en uitvoering. Bij toekenning volgt een beschikking met
   voorwaarden, soms cofinanciering of een verplichte eigen bijdrage.
7. Verantwoorden en rapporteren. Voortgangs- en eindrapportage, financiele
   verantwoording, en relatiebeheer richting het fonds voor een volgende aanvraag.

## Terminologie (de juiste taal van de sector)

Gebruik de juiste termen. Verkeerde termen kosten meteen vertrouwen. In de UI is
de brontaal Nederlands (sentence case), in code en data is alles Engels.

- Fonds: een organisatie die geld verstrekt (vermogensfonds, vermogend fonds).
  In code vaak `foundation` of `funder`.
- Subsidie: financiering vanuit de overheid tegen voorwaarden. In code `subsidy`
  of het bredere `grant`.
- Grant of gift: een toekenning vanuit een fonds. In code `grant`.
- Aanvraag: het ingediende verzoek om financiering. In code `application`.
- Voorstel of projectplan: de inhoudelijke tekst bij de aanvraag. In code
  `proposal`.
- Begroting: het financiele plan bij de aanvraag. In code `budget`.
- Beschikking: het formele besluit van een fonds of overheid. In code `decision`
  of `award`.
- Cofinanciering: financiering die meerdere bronnen combineert. Vaak een eis.
- ANBI: Algemeen Nut Beogende Instelling, een Nederlandse fiscale status. Veel
  fondsen geven alleen aan ANBI's, en het ANBI-register is een kernbron.
- Doelstelling en criteria: waar een fonds voor is en wie mag aanvragen
  (sector, regio, doelgroep, bedrag, rechtsvorm).
- Donateur, gift, periodieke gift, nalatenschap, major donor: termen uit de
  private kant.

## De spelers en bronnen in Nederland

- Het ANBI-register (Belastingdienst). Publiek en machineleesbaar. De kernbron
  voor wie ANBI-status heeft en de basis van de fondsendatabase.
- CBF (Centraal Bureau Fondsenwerving). Toezicht en het keurmerk Erkend Goed Doel.
- FIN (vereniging van fondsen in Nederland) en bestaande fondsengidsen zoals
  Fondsenwijzer. Overzichten van vermogensfondsen.
- Goede Doelen Nederland. Brancheorganisatie, een belangrijk kanaal richting
  organisaties.
- Overheidsloketten voor subsidies (gemeente, provincie, rijk, RVO, EU-programma's).
- Jaarverslagen en beleidsplannen van fondsen. Hierin staat wat ze echt financieren
  en wat ze in het verleden hebben toegekend.

Wees eerlijk over wat publiek en gestructureerd beschikbaar is en wat een aanname
of handwerk is. Niet alle fondsen publiceren even veel, en criteria staan vaak in
lopende tekst die de AI moet interpreteren.

## Databronnen en de fondsendatabase

- De fondsendatabase is gedeelde referentiedata: alle tenants matchen hiertegen.
  Hij bevat per fonds de doelstelling, criteria, sector, regio, bedragenrange,
  deadlines en bron. In code een tenant-overstijgende, alleen-lezen dataset.
- Databronnen verschillen in kwaliteit en versheid. Leg per veld vast waar het
  vandaan komt en wanneer het is bijgewerkt, zodat matching uitlegbaar blijft.
- Houd rekening met landverschillen. De NL-bronnen (ANBI, FIN) hebben geen directe
  tegenhanger in elk land. Bij de Europese uitrol komen er andere registers bij.

## GO, PARK, STOP: de fit-uitdrukking

De kern van V1 is een eerlijke fit-beoordeling, niet zoveel mogelijk treffers.

- GO: sterke fit, de moeite waard om aan te vragen, met de redenen erbij.
- PARK: gedeeltelijke fit, kan met een aanpassing (bijvoorbeeld een deelproject of
  een ander bedrag), bewust geparkeerd.
- STOP: geen fit, niet aanvragen, met de reden zodat de gebruiker leert.

De onderbouwing is net zo belangrijk als de score. De gebruiker moet snappen
waarom, en het signaal traint het model.

## Praktijkrandgevallen die een naief ontwerp breken

- Fondsen met dichte deadlines of alleen op uitnodiging.
- Eisen aan rechtsvorm of status (alleen ANBI, alleen bepaalde regio's).
- Cofinanciering verplicht, of een maximum per organisatie per jaar.
- Een aanvraag die meerdere jaren beslaat, of een vervolgaanvraag op een lopende
  toekenning.
- Vertrouwelijke projectinformatie en persoonsgegevens in een aanvraag.
- Een organisatie die onder een koepel of als fiscaal doorgeefluik werkt.
- Fondsen waarvan de criteria alleen in vrije tekst staan en geinterpreteerd
  moeten worden, met risico op een verkeerde match.

## Aansluiting op het platform

- Elke organisatie is een tenant met een eigen profiel, aanvragen, voorstellen en
  rapportages. De fondsendatabase is gedeeld.
- Sluit terminologie in de UI aan op wat fondsenwervers gebruiken, en houd rekening
  met meertaligheid: een term moet in elke taal kloppen, niet alleen in het
  Nederlands.
- Bij persoonsgegevens en vertrouwelijke aanvraaginhoud stem je af met compliance,
  zeker waar data naar de AI-laag gaat.
