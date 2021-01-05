---
title: A könyvjelzőkről
author: Peter Herman
date: '2021-01-05'
slug: a-konyvjelzokrol
categories: []
tags:
  - bookmarks
  - setup
subtitle: ''
summary: ''
authors: []
lastmod: '2021-01-05T10:19:56+01:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

Jelenleg Mozilla Firefox böngészőt használok, korábban Google Chrome-ot. A weboldalakat kezdetektől fogva könyvjelzőzöm. De miért is?  

## Jellegzetességek
### Mentés

A böngészési szokásomra jelemző, hogy nem szeretek sok lapot nyitva hagyni. Ha nincs elegendő információ adott lapfülön, akkor becsukom. Ha tartalmaz később is hasznos infót, akkor általában könyvjelzőzöm. Mivel így gyorsan nő a könyvjelzők száma (ami például a Chrome-nál korábban gondot is okozott), ezért rendszeresen *exportálom* (elmentem) őket a számítógépemre. Ekkor lehetőségem van gyomlálni, felfrissíteni őket. A könyvjelzőim száma tehát növekszik és zsugorodik, aszerint, hogy mennyire tartom érdemesnek a témájukat megőrzésre. Előfordul az is, hogy a téma érdemes megőrzésre, de szükségszerűnek érzem a ritkítást. Ekkor rendszerint teljes mappákat törlök.  

### Rendszerezés
A könyvjelzőket *mappákba* rendezem téma szerint. Nemrég hoztam egy olyan szabályt, amihez igyekszem tartani magam: ne legyen három szintnél mélyebb a mappák egymásba ágyazása. Például R => Plot => Tools. Ha szükségesnek érzem egy negyedik szint létrehozását, akkor megfontolom az áthelyezéseket, törléseket, hogy lehetőleg tartsam magam az elvemhez. Ezáltal áttekinthetőbb marad.  

### Nyelvek
A könyvjelzőim többnyire *magyar* és *angol* oldalakat ölelnek fel. Mivel a téma alapján rendszerezem őket, ezért lényegtelen számomra a nyelvük. Emiatt keveredhetnek adott témán belül a magyar és az angol nyelvű oldalak. Mivel szükségtelennek érzem, hogy fordítsam őket a másik nyelvre, ezért a Források oldalon is így, eredeti nyelvükön, vegyesen szerepelnek.  

Az összes könyvjelzőmnek körülbelül a kétharmada látható a Források oldalon belül. Ezek többnyire a munkához és a szűkebben vett érdeklődési területemhez kapcsolódnak.  

## A bejegyzés létrehozása

Amikor az oldal összeállításán gondolkoztam, felvetődött, hogy megjelenítem a könyvjelzők favicon-jait. A velejáró munka (főképp az automatizálás) nehézkessége miatt viszont elvetettem. Helyette az egyszerű többszintű felsorolás listát alkalmazom. Azért is válaszottam ezt a megoldást, mivel a könyvjelzőim nagy száma és egymásba ágyazottságuk miatt szükségesnek láttam egy oldalsó tartalomjegyzék szerepeltetését, mellyel áttekinthetőbbek.  

Az oldal létrehozásának fáradságos folyamatát jól bemutatja a hozzá tartozó GitHub issue [Make a treeview of bookmarks in Resources menu](https://github.com/hermanp/website/issues/2). Ezt megpróbálom az alábbiakban röviden összefoglalni:
- **cél**: könyvjelzőim egy részének megjelenítése a Források oldalon belül, minél inkább automatizáltan. Ezáltal rákényszerítem magam a rendezésükre, mások számára elérhetővé teszem őket és hivatkozni tudok rájuk a weboldalamon.
- **kezdeti ötlet**: a Windows Intéző által megjelenített mappák fagráfja jutott eszembe. Ezt az angol *treeview*-nek hívja. Hasonló hatást lehetne elérni az *accordion* elemmel, mely ugyancsak kibontható listát képez. Az egyes könyvjelzőket jó lenne megmagyarázni: miért érdekes az adott oldal. A *favicon*-okat is jó lenne megjeleníteni a könyvjelzők címe mellett.
- **kutatás**: Google-lal kerestem olyan kifejezéskre, amelyek felölelték a technológiai környezetet (Hugo), preferált technológiát (HTML, CSS, hogy minél egyszerűbb legyen) és az automatizálhatóságot.
- **letörés**: miután kizártam lehetőségeket a bonyolultságuk miatt és mivel nem találtam kész (egyszerű) megoldást a problémámra, ezért kénytelen voltam a létező legegyszerűbb, funkcióját ellátó változatot kikísérletezni. Ezt a folyamatot jól mutatja a két Stack Overflow poszt is, amit a témában közzétettem: [Convert Firefox bookmarks JSON file to markdown](https://stackoverflow.com/q/65111588/14261671) és [Keep newline character in string during gsub](https://stackoverflow.com/q/65143495/14261671)
- **megoldás**: egyszerű felsorolás listába rendezés. A sok könyvjelző miatt szükséges lenne tartalomjegyzék. Ezt a Hugo képes maga generálni a header (fejléc) elemekből, ehhez viszont kénytelen vagyok a mappaneveket megfelelő szintű fejléc elemmé alakítani. A markdown lehetővé teszi a stíluselemek kombinálását.
- **finomítás**: szerettem volna csak bizonyos listaelemeknél megtartani a jelölőket (bullet point, marker), de sajnos a CSS jelenlegi állása szerint erre nincs lehetőségem. Ezért eltávolítottam az összes elől.

## Általános megfontolások

A könyvjelzőim kordában tartására jó módszernek ígérkezik az, ha egy csoportot, amely adott témát ölel fel, külön helyezek el a Források menün belül. Így kikerülnek a könyvjelzők közül, azok számát csökkentve, mégis lehetőség nyílik a kibontásukra. Folytatni lehet a feltárást a témában, további linkeket bevonva és azokat már magyarázattal is el lehet látni. Ezek posztok előzményeiként is felfoghatóak lesznek.  

Ha távolabbról szemléljük a jelenséget, akkor valójában a következő kérdést tehetjük fel: *hogyan lehet a böngészés során elénk kerülő dolgokat kezelni?* És ebbe beletartozik a:
- **mentés** (későbbi elérés), erre a könyvjelzők megfelelőek
- **rendszerezés** (a fentiek tükrében, csoportosítva legyenek vagy címkézve, hogy áttekinthetőek vagy könnyen fellelhetőek legyenek), erre is jók a könyvjelzők. Különösen a Firefoxban, mivel a Chrome könyvjelzőit nem lehet címkézni.
- **egy ötlet rögzítése** (mire is gondoltam, amikor mentettem), 
- **részlet megjelölése** (lehet, hogy csak egy mondat érdekes az egész oldalon).

Ezekre próbálnak megoldást adni az *annotation tool*-ok ([alternatívák](https://alternativeto.net/software/memex/)), mint amilyen a:
- [Memex](https://getmemex.com/). Ezt egy ideig próbáltam használni, de kicsit nehézkesnek találtam. Ez betudható az átállásnak is. Maga a cég filozófiája példaértékű, érdemes a blogját olvasni.
- [Pocket](getpocket.com). Ezt is elkezdtem használni, de ez sem kényelmes. Az adatok exportálásával még nem foglalkoztam (de nem tűnik barátságosnak).

Áttekintve a könyvjelzőimet, talán az alábbi típusokat különíthetem el:
- fórumok, pl. [Stack Overflow](https://stackoverflow.com/), [Quora](http://www.quora.com/)
- adatbázisok, gyűjtemények, keresők, pl. [Internet Archive](https://archive.org/index.php), [Hungaricana](https://hungaricana.hu/hu/)
- eszközök, pl. [Trello](https://trello.com/), [Leaflet](https://leafletjs.com/)
- posztok, cikkek, pl. [Medium](https://medium.com/) posztok, [Index](https://index.hu/tech/helpdeszka/2019/03/05/netbiztonsagi_kalauz_kiberbiztonsag_adatvedelem_jelszo_adathalaszat_titkositas/) cikkek
- könyvek, pl. [Happy Git and GitHub for the useR](http://happygitwithr.com/), [ELTE IK ekönyvek](https://www.inf.elte.hu/etananyagok)
- blogok, személyes weblapok, pl. [Hope in Source](https://hopeinsource.com/), [Yan Holtz](https://www.yan-holtz.com/)
- önálló oldalak, pl. [EU GDPR](https://gdpr.eu/)

Ha ezeken végigtekintek, látható, hogy van átfedés, például a Stack Overflow oldalon gyakran keresek is. Úgy is tekinthetek rájuk, mint oldalakra,
- amelyeken nem generálódik új tartalom vagy az csak csekély, így felfogható könnyen
- amelyeken (nagyobb mennyiségű) új tartalom jön létre vagy fedezhető fel, így gyorsan növekedne a könyvjelzők száma általuk.

A fenti helyzet veti fel e kérdéseket: érdemes-e az adott oldalhoz tartozó könyvjelzőket az adott oldal alá sorolni és úgy kezelni? Lehetséges-e azok kezelése azon oldalon keresztül, ahová tartoznak? Nem teszi nehezebben áttekinthetővé és nehezebben elérhetővé őket, ha adott oldaon keresztül kezelem őket és nem a könyvjelzőkön keresztül? Például a Medium poszokat a Mediumon keresztül rendezzem? A Stack Overflow kérdéseket a saját oldalán keresztül kezeljem? Ha így lenne, akkor csak az egyik helyen tartanám meg őket: vagy a könyvjelzők között vagy az adott oldal rendszerében, mivel dupla munkát nem akarok végezni. Másik alternatíva a fentebb említett annotáló alkalmazások használata, melyekben vegyesen lehetne a gyorsan generált tartalmakat menteni és felügyelni, onnan a könyvjelzők közé csak egyesek kerülnének be. Harmadik alternatíva, hogy jegyzetet készítek róluk, akár így, a blogon és ezáltal feldolgozom őket. Ekkor nem szükséges magát az oldalt elmenteni, viszont megjelennek a jegyzetek és azokat kell karban tartani...

A helyzet képlékeny és a jövőben még alakulni fog.
