Je gaat de completeness gate draaien. Dit is de controle die bepaalt of een
feature of plakje echt compleet en goed is voordat het klaar mag heten. Alles na
dit commando is de slug of het pad naar de feature-map (bijvoorbeeld
docs/features/match-onderbouwing-uitleg).

Neem de rol van Engineering Manager aan. Lees eerst `.cursor/rules/team-charter.mdc`
en `.cursor/skills/team-engineering-manager/SKILL.md`. Schrijf als mens, simpele
taal, geen emoji, geen dubbele streepjes.

## Werkwijze

1. Lees de artefacten en de slice-logs in de feature-map, en de echte wijzigingen
   in de code (git diff en de betrokken bestanden).
2. Bepaal welke disciplines relevant zijn voor wat er gebouwd is. Een
   backend-wijziging hoeft niet door de UX-controle, een puur visueel scherm niet
   per se door de architectuurcontrole. Wees hier bewust in.
3. Start de relevante controle-agenten parallel met de Task tool, in readonly waar
   dat kan. Geef elke controle-agent de opdracht om eerst het team-charter en zijn
   rol-skill te lezen, en daarna te controleren of zijn deel compleet en goed is.
   Vraag per agent om een oordeel: groen (in orde), geel (aandachtspunt) of rood
   (blokkerend), met concrete bevindingen en bewijs.

Controle-agenten en waar ze op letten:
- Fondsenwerving- en domeinspecialist (`team-domain-specialist`): klopt het met het
  echte wervingsproces, is de terminologie juist, sluit het aan op de databronnen
  en de eisen van fondsen, en kan een organisatie dit echt gebruiken. Zijn de
  praktijkrandgevallen afgedekt.
- Test manager (`team-test-manager`): voldoende dekking, echte-database tenant-
  isolatie tests groen, contracttests en AI-uitvoer-tests waar nodig, en echt
  gedragsbewijs van het draaiende systeem, niet alleen mocks. Acceptatiecriteria
  aantoonbaar gedekt.
- UX/UI designer (`team-ux-designer`): klopt het scherm met de designspec en het
  design system, is het bereikbaar voor de juiste rollen, rendert het zonder
  fouten, sentence case en i18n in orde.
- Architect (`team-architect`): past het binnen de architectuur, RLS en tenant-
  isolatie correct, de AI-laag serverside, veilig en kostenbewust, geen workarounds.
- Compliance manager (`team-compliance`): privacy, donor- en aanvraagdata, de
  AI-laag en beleid in orde, afspraken en policy-updates benoemd.
- Product Owner (`team-product-owner`): zijn alle acceptatiecriteria aantoonbaar
  gehaald, ook de foutpaden en rechten.
- OPS manager (`team-ops-manager`): logging en monitoring meegebouwd, AI-kosten
  bewaakt, deploy- en migratiestappen kloppen, herstelpad bekend.

4. Verzamel de oordelen in `docs/features/<slug>/99-completeness.md` met per
   discipline de status en de bevindingen, en een eindoordeel.

## Uitkomst

- Is alles groen, meld dat de gate gehaald is en wat er nog als geel openstaat.
- Is er iets rood, dan blokkeert dat de oplevering. Vat de blokkers samen en geef
  per blokker aan of het opgelost kan worden of dat er een keuze van de gebruiker
  nodig is, met opties.

Verzin geen oordeel zonder bewijs. Een controle-agent die niets kon controleren
meldt dat eerlijk in plaats van groen te zeggen.
