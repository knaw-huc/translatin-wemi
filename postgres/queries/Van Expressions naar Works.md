Om van Expressions naar Works te komen is het belangrijk om na te gaan welke Expressions ongeveer dezelfde intellectuele
inhoud hebben. Zij vormen de Works. Alle verschijningsvormen van Expressions/Manifestations (first printings, reprints,
synopsis) die door één auteur (bijv. de Jezuïeten van Mechelen) zijn uitgebracht met min of meer dezelfde titel
(Joseph/Ioseph), eventueel in verschillende talen, die hetzelfde genre kennen, maar door verschillende drukkers zijn
gedrukt, vallen bijvoorbeeld onder hetzelfde Work.

Met de volgende metadata moet rekening worden gehouden in de query nu we van Manifestations via Expressions naar Works
proberen te komen:

- Alle auteurs moeten overeenkomen (hard criterium, volgorde maakt niet uit). Na implementatie van data Proot moeten we
  dit criterium waarschijnlijk herzien omdat we dan veel meer onbekende auteurs hebben opgespoord die werkten voor een
  Organisation die we nu nog hebben onderscheiden als bijv. ‘Jezuïeten van…’. Kan gewoon met ID’s van de auteurs.
- De talen van de Expressions mogen variëren (ongeacht de zekerheid waarmee deze zijn vastgesteld). De volgorde speelt
  hierbij geen rol.
- Min of meer dezelfde titel, waarbij ook oog is voor titels in andere talen die aan elkaar gekoppeld kunnen worden op
  Work-niveau. Dit is het lastigste gedeelte van de query. Werken met een relatieve Levenstheinafstand van 0.1 of 0.2
  lijkt een goed uitgangspunt (ligt een beetje aan de zoekopbrengst). Letters die sowieso gelijk aan elkaar staan zijn:
  u=v, i=j, w=vv, ij=y.
- ‘Form_type’ hoeft niet overeen te komen (i.t.t. query voor realisatie van het Expression-niveau).
- Áls er een genre wordt genoemd, moet deze overeenkomen. Áls er een subgenre wordt genoemd, mag deze niet conflicteren
  met een ander subgenre (er worden wellicht Manifestations genoemd die hetzelfde overkoepelende genre hebben, maar
  waarvan het subgenre net iets verschilt).
- Geen tijdsframe

Mogelijke queries voor het TransLatin-symposium van 1-2 september (van belangrijk naar minder belangrijk gerangschikt):

- Aantal Manifestations afgezet tegen de tijd (grafiek van aantal Manifestations door de eeuwen heen per jaar/decennium);
- Aan welke Works kunnen de meeste Manifestations worden gehangen (ongeacht vorm, etc.)?
- Eventueel op de vorige query voortbordurend als de opbrengsten hier hoog genoeg zijn (zeg tenminste 20/30
  Manifestations die onder een Work gekoppeld kunnen worden: op welke momenten door de tijd verschijnen deze
  Manifestations (op tijdlijn gevisualiseerd);

- Welke auteurs hebben de meeste Manifestations?
- Welke drukkers hebben de meeste Manifestations?
- Welke auteurs en welke drukkers werken het meeste samen bij Manifestations?
- In welke steden werden de meeste Manifestations gedrukt, eventueel afgezet tegen de tijd?
