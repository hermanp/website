---
title: Kispest lakótelep, 8. rész. Az épületek
author: Peter Herman
date: '2021-03-15'
slug: kispest-lakotelep-8-resz
categories: []
tags: 
  - kispest
  - lakótelep
  - panel
subtitle: ''
summary: ''
authors: []
lastmod: '2021-06-14'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

Ebben a részben a célom rögzíteni azokat a lépéseket, amik elvezettek a lakóépületek interaktív térképi ábrázolásáig: épületlajstrom, OpenStreetMap szerkesztés és exportálás, térképi ábrázolás és R Shiny alkalmazás. És a fő kérdés: ki tervezte ezeket az épületeket? :smiley:

*Mi a cél?*

Térképen ábrázolni az *épület körvonalat* (magyarul talán így mondanánk, angolul viszont *building footprint*-nek hívják). Az interaktív megvalósítás a későbbiekben azt jelenti, hogy ki/be kapcsolhatóak a megjelenített épületek az egyes jellemzők szerint. Ehhez vélhetőleg Shiny-t alkalmaznék.


## Kiindulási adatok

Felhasználva a [4. részben](/hu/post/kispest-lakotelep-4-resz/) közölt 1981-es Kispest beépítési tervet és *A budapesti célcsoportos és magánerős komplex VI. ötéves tervi lakásépítés: hálós elemzés*[^2] című többkötetes kiadvány helyszínrajzait, ezeket egybevetve a Google Maps műholdas alaptérképével, képes voltam összeírni a kispesti lakótelep lakóépületeit (zárójelben típusok szerint):

- I. ütem:
    - 3 db 5 szintes, két különálló egységből álló **ismeretlen típusú** épület és
    - 8 db 10 szintes **A-4** típusú pontház
- II/A ütem:
    - 3 db 10 szintes **A-4** típusú pontház
    - 10 db 11 szintes **S-12** típusú szalagház és
    - 5 db 4 és 5 szintes elemekből összeállított **H-O** típusú épület
- II/B ütem:
    - 12 db 11 emeletes **S-412** típusú szalagház
    - 14 db 11 emeletes **S-312** típusú szalagház
    - 10 db 11 emeletes **F-90** típusú szalagház
    - 9 db 4 és 5 szintes elemekből összeállított **H-O** típusú épület és
    - 17 db 4 vagy 5 szintes **E-5** típusú épület

{{< figure src="IMG_20200730_143336.jpg" title="Kispest városközpont 2/B ütem 1. és 2. szakasz helyszínrajz. Forrás: A budapesti célcsoportos és magánerős komplex VI. ötéves tervi lakásépítés: hálós elemzés" numbered="true" >}}

{{< figure src="IMG_20200730_143400.jpg" title="Kispest városközpont 2/B ütem 3. szakasz helyszínrajz. Forrás: A budapesti célcsoportos és magánerős komplex VI. ötéves tervi lakásépítés: hálós elemzés." numbered="true" >}}


Ezekről egy [attribútum táblázatot](https://docs.google.com/spreadsheets/d/1LVAJUEYR19ZKJL6qfAU35jEEAo43WpLNQSETC82IGZk/edit?usp=sharing) állítottam össze, ami tartalmazza a lakóépület típusát, címét, szintszámát és egyéb adatokat.


## OpenStreetMap térképezés

Az ábrázoláshoz az épületek körvonalait legálisan, könnyen meg lehet szerezni az [OpenStreetMap](https://www.openstreetmap.org) (OSM) adatbázisból. Ennek több módja is lehet: letölteni a terület shape file-ját, majd R-be beolvasni és feldolgozható formára hozni[^3] vagy külön erre a célra kialakított R csomagot használni. Amikor nekikezdtem a munkának, sok épület nem vagy pontatlanul volt berajzolva. Két út állt előttem: vagy csak magamnak rajzolgatok vagy a munkámat közzéteszem az OSM-en, így másoknak is segítek. Utóbbi mellett döntöttem és felvettem a kapcsolatot a hazai OSM közösséggel a Google Groups-os levelezőlistájukon keresztül.

Segédletként pedig az alábbiakat találtam:
- [Település felrajzolása műholdkép alapján](https://www.osmtippek.hu/josm/rajzolas-muholdkeprol/) - OSM Tippek
- [Épületek, vonalak és területek derékszögesítése, párhuzamosítása](https://www.osmtippek.hu/josm/szerkesztes/derekszogesites/) - OSM Tippek
- [Fast building tracing with JOSM](https://blog.mapbox.com/fast-building-tracing-with-josm-58a3c3be9be8) - Medium
- [Map Buildings using JOSM like a Pro](https://www.youtube.com/watch?v=u6KsJOaA-iE) - Youtube
- [OpenStreetMap szerkesztés JOSM building tools](https://www.youtube.com/watch?v=OWMJX3MoJGk) - Youtube
- [OSM Kezdők kézikönyve](https://wiki.openstreetmap.org/wiki/Hu:Beginners%27_guide) - OSM Wiki

Ezek alapján a lényeget így szűrtem le: igazítani kell a műholdképet a GPS track-ekhez és meglévő OSM térképhez, aztán rajzol az ember, nem sokat, hogy ne ütközzön mással és feltölti az OSM szerverre.

**Kérdéseim** is voltak, amiket feltettem:
- *Mit tegyek módosítandó épületnél? Húzogassam a pontokat, vonalakat és egyesítsek stb. vagy töröljem és rajzoljam újra? Vagy hagyjam békében?* **Válasz**: A panelházakat négyszögesíteni kell (JOSM-ben Q gomb). A kérdéses épületek törölhetőek (ha sok módosítás lenne szükséges, mert alapjában véve pontatlan) és  újra rajzolhatóak, a FÖMI 2007/2010 ortofotóról látható tagolással. Ha egyszer valaki rosszul rajzolta be és csak ennyi amink van (tehát egyetlen verzió), akkor nyugodtan törölhető és sokkal kényelmesebb újra berajzolni. Ellenben mondjuk egy nagy bevásrálóközpontot, amit már 5-en átszerkesztettek (Version #5), ott inkább a javítgatás a javasolt, ne vesszen el valami fontos a történetéből.
- *Melyik hátteret használjam fel a munkához? FÖMI 2007/2010 vagy FÖMI 2005? Bing? A rajzolni kívánt épületek biztosan nem módosultak az utóbbi időben (legfeljebb szigetelték őket).* **Válasz**: FÖMI 2007/2010. FÖMI-t nem szokás eltolni (igazítani) a rajzolás megkezdésekor, csak műholdképet (pl. Bing). A területen az utak geometriái elég jók, igazodnak a FÖMI 2007/2010-hez. Az Ady Endre utat és az Üllői utat ne mozgassam semerre, akkor sem, ha pontatlan a geometriája (mert mondjuk Bing-ről rajzolták), de a közöttük lévő területen azt tehetek arrább, amit jónak látok.
- *Honnan tudhatnám, hogy munkám felesleges, mert a kispesti lakótelepi területtel már más foglalkozik? Amikor lekérdezem a funkciókat egy területen, akkor látom, ki, mikor, mit módosított. Van valami nyilvántartás, térkép erről, ahol jelezni lehet egy területre a munkát?* **Válasz**: Nem valószínű, hogy más is éppen ott rajzol, szerkessz nyugodtan. A sok szerkesztő miatt nincs olyan, hogy valaki "lefoglal" egy környéket. Ha elég gyakran mentesz, valószínűleg nem fogsz ütközni mással. Azt pedig látod, ha elkezdenek megszaporodni a dolgok épp azon a részen, ahol te is dolgozol — lehet, hogy valaki pont ott érzett késztetést egy kis térképezésre, ezzel besegít neked is. Az elemek történetéből látod, hogy ki csinálja, és vele fel lehet venni a kapcsolatot, és egyeztetni a munkákról.

Fontos továbbá:
- házszámok feltüntetése POI-ként elhelyezve, lépcsőházanként.
- épületek adatai: emeletszám, építés ideje, épület színe, építész/tervező, építészeti stílus, stb.
- source címke a módosításokra
- park területére ne essen épület, ezt igazítani
- belső utak felrajzolása
- paneleknél, magas épületeknél a tető a talajszinti vetülete

### JOSM
A térképi rajzolást a [JOSM](https://josm.openstreetmap.de/) szoftverrel végeztem. A munka az alábbi lépésekből áll:
1. Kérdéses terület adatainak letöltése
2. Légi felvétel betöltése (FÖMI ortofotó 2007-2010)
3. Rajzolás
4. Adatok feltöltése az OSM szerverre (esetleges ütközések javítása)

Az OSM szerverére felkerült adatok különböző idő után válhatnak láthatóvá a neten is böngészhető térképen, mivel a térképet az adatokból rajzolja meg a szerver és ez különféle terepi objektumok esetén más-más időt vehet igénybe. Több fórumoldal foglalkozik ezzel a kérdéssel (keresés: `building not render after edit osm`). Például: [Why my last edits are not displayed?](https://help.openstreetmap.org/questions/23836/re-why-my-last-edits-are-not-displayed)


## R Leaflet

Miután a nekem szükséges épületeket létrehoztam és feltöltöttem az OSM-re, onnan letöltöm és térképen ábrázolom típus szerint őket. A teljes munkafolyamat R-ben végezhető.


________________

## Az új E típus

Az E típusú épületek újszerűséget vittek a paneles építészetbe. Milyenek voltak ezek? Miben tértek el a korábbi típustervektől? Tényleg jobbak voltak? Lássuk a BFT VB előterjesztést!

[1982. március 3](https://library.hungaricana.hu/hu/view/HU_BFL_XXIII_102_a_1_1982-03-03/?pg=0&layout=s)-án tárgyalta a BFT VB az *új egységesített lakóház, illetve lakástípusok műszaki-gazdasági tervezési rendszerének bemutatása, különös tekintettel a fővárosi igények érvényesítésére* pontot. Ez az E típus ismertetése.

### Előzmények

*Milyen indokok miatt kell új típus?*
> A jelenleg épülő lakások típustervei még a IV. ötéves tervidőszakban készültek, ma már nem elégítik ki a családok igényeit. Különösen a szűk, étkezésre alkalmatlan konyhák állnak a jogos kritikák középpontjában. Ugyancsak jogos bírálatok tárgya a monotonitás, a homlokzatok, illetve beépítési módok egyhangúsága. [...] a házgyárak sablon-parkjának avultsága, elhasználódottsága is sürgeti az új lakástipusok tervezését [...] 
Az energiatakarékossági hatósági intézkedéseket is csak a házgyárak új termékeinek alkalmazásával tudják a kivitelezők betartani.

*Miért "E" típus?*
Mert "egységesített".

### Előnyei

> A mai gyakorlatban egy-egy lakóterületen a területre dolgozó házgyár épület-típusai valósulnak meg. A beépítési terveket és a lakásösszetételt meghatározza a gyártott épülettípus. Így a lakásösszetétel megkívánt változatai gyártási korlátokba ütköznek.

- Korábban épületeket tipizáltak, az E típusnál a lakásokat, közlekedőket (lépcsőházakat). Eredmény: lehetőség van arra, hogy egy-egy épületben az építtető határozza meg a lakásösszetételt és az építész a városrészhez illeszkedő, változatos tömegű és homlokzati kialakítású, szinte egyedi épületeket tervezzen.
- Nincs kötött szintszám, 3-tól 11- emeletig lehet építeni (korábban 5 és 11 szintes). 5 emelettől felfele felvonóval.
- Az épületek lehetnek pontházak, egyenes vagy tört vonalú, belső kertet körbezáróak.
- Földszinti lakásokhoz kis kertek tartoznak.
- Egyhangúság feloldására:
    - többféle méretű ablak, franciaerkély
    - különféle felületű panel (sima, rovátkált, kőzúzalékos stb.)
    - sok változatú loggia, korlát, virágvályú, napellenző.
- Egységesítették a teherhordó szerkezetek méretrendjét, a lepcsőházakat és azokat a részleteket, melyek egy-egy lakásnál, vagy épületnél azonos kívánalmakat elégítenek ki. Eredmény: a legváltozatosabb összeépítések és homlokzati kialakítások is a jelenleg használatos panelféleségek **egyötödével** legyenek megvalósíthatóak. A gyártott paneltípusok számának csökkenése a gyártó-szerelőipar számára is számottevő előnyt jelent. 
- Domino elv: az alapelem a lakás (építtető által meghatározható alapterületi és szobaszám összetétellel). Eredmény: a jelenleginél korszerűbb, az igényeket, a családösszetételt jobban követő lakások épitése.
- A rendszer számítógépes feldolgozásra is alkalmas, ami az ipar hatékonyságát növeli.

### Felkészülés

Az ÉVM Építőipari Főosztálya meghatározta 1980. november 26-ai levelében, hogy mely lakótelepek épülhetnek vegyes (régi és új) típusösszetétel mellett és melyek csak az új E típussal.

> A fejlesztési programterv kidolgozása és elfogadása után a LAKÓTERV elkészítette a lakásegységek alaprajzi variációit. A terv konzultáció során a Főváros képviselői ragaszkodtak a már korábban elkészített és jóváhagyott — illetve készítés alatt álló — lakótelepi beruházási programok megvalósítására (lakásszám, alapterület, szobaszám és költség vonatkozásában egyaránt) alkalmas lépcsőházi egységek-szekciók kidolgozásához.

{{< figure src="E_tipus_valtozatok_tablazata.png" title="Az E típusterv. Lakásváltozatok. Itt csak 23-at számoltam össze a szövegbeli 29-hez képest. A táblázatos forma értelmezéséhez lásd az életmód szerinti igények táblázatos rendszerét lejjebb." numbered="true" >}}

{{< figure src="E_tipus_epuletvaltozatok_peldak.png" title="Az E típusterv. Példák épületváltozatok kialakítására a lakástípusok variálásával. A képen talán láthatóak a lakásokban a típusaik felirata halványan." numbered="true" >}}

A VI. ötéves tervi lakótelepek előkészítésével összhangban 46 lépcsőházi változat terve készült el 29 féle különböző lakást variálva. Típustervként közzé fogják tenni őket. Az ÉVM és Főváros között 1979. júniusban létrejött megállapodás szerint 1982. évben többszintes épületekben 1116 új típusú lakást terveztek megépíteni (III. Kaszásdűlő, XVII. Rákoskeresztúr III.ütem, XIX. Kispest II/B ütem) összesen hat épületben. A tervezés és gyártásra való felkészülés határidő késedelme miatt 1982-ben csak Kaszásdűlőn valósul meg 165 lakás prototípusként, így Kispesten a régi típusú gyártmányokból épülnek.

> Az új termékek fokozatos bevezetése esetén I. ütemben az I-es és a IV-es házgyárak készülnek fel a többszintes (E-5 földszint + 3-4 emelet) lakóépületek elemeinek gyártására. A gyártó-sablonok és segédberendezések tervezése, elkészítése és gyártósorokba állítása olyan ütemben halad, hogy a tényleges gyártás várhatóan 1982. júniusában, napi 5 lakás gyártáskapacitással megindulhat. A II. sz. házgyárban a vállalat egyelőre nem tervezi a termékváltást, a III. sz. házgyár pedig 1984-ig a jelenlegi típusokat gyártja, és addig felkészül az átállásra.

Mi késlelteti a tervezést?
> Az új típusú tervcsalád előkészítése során a típustervezés a tervezett ütemben haladt ugyan, de a gyártmánytervek készítése, ennek függvényében a termékárak megadása területén már határidő késés mutatkozott, az MGN szintentartás és az ezt követő egyeztetések a hatósági árjóváhagyás folyamatát késleltették, s ez visszahat a típusterv közzététel határidő késedelmére. A gyártásfelkészítés nem kellő üteme miatt pedig az eredetileg új termékből tervezett épületek régi típusúra való átterveztetése, a beépitési tervek sorozatos módosítása válik szükségessé.

### A terv

*Kik végezték az E típus kidolgozását?* Az Építésügyi és Városfejlesztési Minisztérium kijelölése alapján a LAKÓTERV, azon belül a III. iroda:

| Név             | Beosztás                   |
| --------------- | -------------------------- |
| Heinrich F.     | műterem vezető             |
| Korényi A.      | műterem vezető             |
| Ligeti G.       | műterem vezető             |
| Borostyánkőy L. | iroda vezető               |
| Jakab Z.        | műszaki igazgató helyettes |
| Koltai E.       | igazgató                   |

Azonban érdemes rámutatni itt egy **Virág Csabával**, LAKÓTERV vezető építészével készült [interjúra](http://www.kozep.bme.hu/wp-content/uploads/2013/08/tanulmany_viragcsaba_2007.pdf), melyet Buzder-Lantos Zsófia és Gönczi Orsolya készített. Ennek Panelos Fejlesztési Programterv fejezetében olvashatunk az általa N+H System (N: nappali, H: háló) tervről, mely a paneles lakóépületek tervezésének és technológiájának fejlesztéséről kiírt pályázatra készült el.[^1] Munkatársai Korényi András és Nagy János "a paneltechnológia atyjai" voltak. Két évig tervezte kb. 60 fős csapatával, de nem részletezett okokból visszalépett e terv vezetésétől. Ekkor vették át tőle:

> Korényi—Zoltai barátaim azután legalább e munka maradék eredményeiből az ún. „E”-típusból megcsinálták a Káposztásmegyeri Lakótelepet. Ez történt 1982-ben.

Egy központi kérdés számomra továbbra is az, hogy **ki és milyen meggondolásból tervezte** a korábbi paneles lakásokat és épületeket? Erre vetett némi fényt az alábbi odavetett mondata Virág Csabának:

> Volt egy Tóth János nevű technikus, ő mondta meg, milyennek kell lenni egy panellakásnak. Mi felfogadtuk őt konzulensnek a pályázathoz. Így kaphattuk meg a munkát, különben csak csökkentett első díjat akartak adni nekünk.


*Mi alapján terveztek?*

Az igények 3 szempontja:

1. a lakók számára olyan lakást biztosítson, ami nemcsak a változó család nagyságát, de a családok változó életmódját is követni tudja,
2. legyen alkalmas változatos és humánus új városok, városrészek építésére, környezetformálására,
3. az ipar számára - a változatosság növelése mellett - a "gyártás" feladatát egyszerűsítse, a rentábilis "szériatermelés" feltételeit biztosítsa. 
Továbbá megkapták a BFT VB Beruházási és Lakásügyi Főosztályaitól az igényelt arányokat: 5 % 2 fős, 10 % otthonház, 10 % 3 fős, 44 % 4 fős, 16 % 5 fős, 15 % 6 fős. alapterületi átlag: 54,0 m2, korábban 53,0 m2. További igények, hogy lehetőleg külön biztosítsanak helyet az étkezés részére és hogy a hálóhelyek elhelyezését lehetőleg differenciáltan, félszobákban oldják meg.

*Hogyan terveztek?*

Az életmód szerinti igényeket egy táblázatos rendszerbe foglalták és a táblázatot új lakásfajtákkal töltötték ki. Az igényesebb lakások A1-től C3-ig fokozatosan egyre nagyobb alapterületűek. A 2 fős lakások épületbe helyezésénél azt a lehetőséget biztosították, hogy azok egy ajtónyílás áttörésével mindig kapcsolhatóak legyenek egy nagyobb — pl. 4 fős — lakáshoz. Ha ezt a lakáskiutalás is követi, akkor a generációs együttélés kedvezően biztosítható. Ezt fontosabb szempontnak tartották, mint az önálló 2 fős lakások területi növelését. Egyes jellemzőket az előnyök fejezetében tüntetek fel, feljebb.

*Az életmód szerinti igények táblázatos rendszere*

|   | A | B | C |
| - | - | - | - |
| 1 | + | 0 | 0 |
| 2 | + | 0 | 0 |
| 3 | 0 |   |   |

- *+* = jelenlegi lakások zöme 
- 0 = új lakások zöme
- A = minden szobában 2 fekhely 
- B = nappaliban csak 1 fekhely
- C = fekvőhelymentes nappali szoba 
- 1 = étkezés a nappali szobában 
- 2 = étkezés étkezőfülkében, vagy étkezőkonyhában 
- 3 = a lakáshoz kiegészítő helyiség is tartozik 

{{< figure src="E_tipus_2A1.png" title="Az E típusterv 2 férőhelyes, A 1 változatú lakása." numbered="true" >}}

{{< figure src="E_tipus_3B2.png" title="Az E típusterv 3 férőhelyes, B 2 változatú lakása." numbered="true" >}}

{{< figure src="E_tipus_4B2.png" title="Az E típusterv 4 férőhelyes, B 2 változatú lakása. Idézet a szövegből: egy olyan nappaliból áll, melyben csak egy fekhely van, az étkezés egy, a nappalival összenyitható étkezőfülkében történik és a lakáshoz 2 hálóhelyiség tartozik." numbered="true" >}}

{{< figure src="E_tipus_5C3.png" title="Az E típusterv 5 férőhelyes, C 3 változatú lakása." numbered="true" >}}

{{< figure src="E_tipus_6A3.png" title="Az E típusterv 6 férőhelyes, A 3 változatú lakása." numbered="true" >}}

Az új típusú lakások felszereltsége és műszaki tartalma:
- új típusú beépített konyhabútorokkal, kamraszekrényekkel és beépített szekrényekkel vannak ellátva, 
- fürdőszobák műanyag fal és padlóburkolatokkal, összefolyóval,
- szobák szőnyegpadlóval, tapétázva készülnek,
- a belső ajtók lakk öntöttek, az ablakok műanyagbevonatúak hőszigetelő üvegezéssel.
- a 6 fős lakás 2 db fürdővel
- a beépített szekrényfalak áthelyezésével két kisebb helyiségből egy nagyobb alakítható ki
- emeleti lakások loggiája elég nagy pl. nyugágyhoz

A E típusról szóló javaslatot a BFT VB elfogadja, de a konkrét állsáfoglalást többen ellenzik, mert szélesebb társadalmi egyeztetést kíván. (Vannak konkrét kritikák egyes lakásoknál.) Utasítják a Beruházási Osztályt, hogy 1983-ban ismét adjon tájékoztatást a bevezetés állapotáról. Ezt meg is teszik [1983. június 8](https://library.hungaricana.hu/hu/view/HU_BFL_XXIII_102_a_1_1983-06-08/?pg=0&layout=s)-án. A tájékoztató pontjai kiegészültek tartalmukban, csak szemlézve őket:

> A fejlesztési programterv keretein belül 25-féle életmód változatú lakás került kiválasztásra különböző alapterületű és szobaszámú változatokkal. [A 29-hez képest.]

> A 43. sz. ÁÉV 1982. januárjában bejelentett döntése alapján, az E-5, az E-11 típusu lakóházi és otthonházi szerkezetek az I. és IV. Házgyárban kerülnek gyártásra. A II. házgyár a VI. ötéves tervben továbbra is a régi típusu épületelemeket gyártja, a III. Házgyárban 
pedig a meglevő berendezésekhez igazodó, de új termékcsalád kerül bevezetésre.

> A korlátozott számú elemgyártás [mármint a sablonválaszték, amiből összerakhatják a tervezők a házakat] tehát a VI. ötéves tervidőszakban még nem teszi lehetővé, hogy az E termék adta lehetőségek szerinti lakásválaszték teljeskörüen megválósítható legyen. Ezért az új termékekből épülő lakások és épületek komplex értékelése ma még nem időszerű. 

> Nem megoldott még a fürdőszobák válaszfalas rendszerben való megvalósításának kérdése. A kivitelező vállalat — technológiai és gazdasági szempontjai alapján — továbbra is a térelemes fürdőszoba megoldást tudja építeni, így a szűkös fürdőszobák problémáinak megoldását a VII. ötéves tervi lakások fogják csak biztosítani.

Szó esik még a Kaszásdűlői 165 lakásos prototípus épületről, fejlesztési lehetőségeiről, a lakosság tájékoztatásáról. A mellékletben az *Az E termékcsaládból előkészített lakások a VI. ötéves tervben* táblázat szerint Kispestre is jutott ezekből! Az E-5 lakóépülettel a II/B ütemben 1983-ban 392 db, 1984-ben 584 db lakást építenek és a E típusterv "otthonház" terméke alapján 64 lakásos nyugdíjasházat is építettek, ezt külön meg is említettem a [4. részben](/hu/post/kispest-lakotelep-4-resz/). Végül elfogadják (az észrevételekkel együtt) a tájékoztatót és nem határoznak későbbi jelentés adásról.


[^1]: Kovács Judit: *N+H rendszer. Titka: az egyszerűség*. (1979. március 18. Magyar Nemzet, 35. évfolyam 65. szám 7. oldal)
[^2]: A budapesti célcsoportos és magánerős komplex VI. ötéves tervi lakásépítés: hálós elemzés / [kidolgozta az Építésgazdasági és Szervezési Intézet 31. Főosztály Lakótelep Szervezési Osztálya]. Tanulmányok, helyszínrajzok, tervrajzok, táblázatok, grafikonok. Kiad. az Építésügyi Tájékoztató Központ. 9-13. kötetek lelhetőek fel a FSZEK Budapest Gyűjteményében.
[^3]: Stackoverflow: R plot building footprint / outline on map using OpenStreetMap data.  https://stackoverflow.com/q/53161186. Elérés: 2021.06.14.
