---
title: Hogyan hoztam létre ezt a blogdown weboldalt
author: Peter Herman
date: '2020-11-23'
slug: hogyan-hoztam-letre-ezt-a-blogdown-weboldalt
categories: []
tags:
  - academic
  - blogdown
  - setup
  - website
  - wowchemy
subtitle: ''
summary: ''
authors: []
lastmod: '2021-01-05'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

"Lehet, hogy létre kellene hoznom egy weboldalt vagy blogot. Talán portfóliót is bemutathatnék? (Hahaha ... Először létre kellene hozni egy portfóliót.:smile:) Csak szeretnék egy egyszerű módszert weboldal készítéshez és fenntartáshoz. Hm... `blogdown`? Szuper, meg tudom csinálni az egészet RStudio-ban!" — valahogy így fantáziáltam róla hónapokkal ezelőtt.

![Kép a Szaffi című animációs filmből](szaffi.jpg)
> Ahol azt kéri, amit nem kaphat, ott azt kapja, amit nem kér.  
> — *Cafrinka* a [Szaffi](https://www.imdb.com/title/tt0137226/)-ból, a kép forrása: [Smaragd Sárkány animéi blog](https://smaragdanimesarkany.blog.hu/2019/10/27/szaffi_832)

Most nézzük meg, hogyan sikerült eljutnom idáig és milyen akadályok lassítottak. Ez az első bejegyzés emlékeztetőként :memo: szolgál magamnak és talán segítő kéz másoknak.

# Háttér
Ismerem az RStudio-t és az R programnyelvet. Ha lenne mód arra, hogy egy webhelyet ezekkel az eszközökkel  el lehet készíteni és közzétenni, akkor az nagyon elegáns lenne! Ezenkívül lehet, hogy néha R kódrészletet használnék a hozzászólásokban. Ezekkel a lehetséges kívánalmakkal keresgéltem és találtam meg a `blogdown` csomagot. Ez volt a kiindulópont; a telepítés során gyakran újraértékeltem a lehetőségeket, amelyeket a következő szakaszok foglalnak össze.

### Statikus weboldal generátorok
Alapvetően kétféle webhely létezik: **statikus** és **dinamikus**. Az alábbi blogdown könyvfejezet [2.1 Static sites and Hugo](https://bookdown.org/yihui/blogdown/static-sites.html) jó összehasonlítást ad. Volt kísértés **weboldal készítő** használatára, de elutasítottam a tartalom átköltöztethetősége és (az akkor remélt) gyors beindítás miatt. Több indokot is bemutatnak a következő linkek (egy webes keresésből: `website builder cms vs hugo`):

- [Why I Chose Hugo Framework For My First Blog?](https://www.techighness.com/post/why-i-chose-hugo-framework-for-my-first-blog/)
- [Why I moved my personal blog from Wordpress to Hugo](https://martijnvanvreeden.nl/why-i-moved-my-personal-blog-from-wordpress-to-hugo/)
- [Jamstack](https://jamstack.org/) - egy új mozgalom a weboldal és alkalmazás fejlesztésben, ami az olyan statikus weboldal generátorokra támaszkodik, mint a Hugo

Statikus weboldalra esett a választásom  az egyszerűsége és a tartalom hordozhatósága miatt. Ha a közeljövőbeli igényeimet kielégíti, miért ne használnám ezt az egyszerűbb megközelítést?

### Blogdown
A `blogdown` alapos dokumentációval rendelkezik ([blogdown: Creating Websites with R Markdown](https://bookdown.org/yihui/blogdown/)) és rengeteg webhelyet hoztak létre a segítségével (lásd: [blogdown]() a Források oldalon). Ezen webhelyek némelyikének vannak bejegyzései, tippjei a telepítésről, vagy hivatkoznak olyan GitHub repozitóriumra, amely a forrásfájlokat tartalmazza. Mindez a sok forrás ígéretessé teszi. (És kimerítővé is a befogadását.)

A Blogdown a `hugo` keretrendszert, egy **statikus weboldal generátort** használ ahhoz, hogy a weboldalt a forrásfájljaiból felépítse. Hogy ez mit jelent? A Hugo lehetővé teszi, hogy a weboldal tartalmát egyszerű markdown szintaxis (valamint LaTeX matematikai és úgynevezett shortcode jelölők) révén létrehozhassuk. A markdown fájlok (`.md`) alapján a Hugo megpróbálja létrehozni a böngészők által olvasható fájlokat (ezt a folyamatot *build*-nek hívják). Azonban nem érti meg az R markdown (`.Rmd`, `.Rmarkdown`) fájlokat, azt a változatot, amely R kódrészletek alkalmazását teszi lehetővé. De a blogdown színrelép és átalakítja az R markdownokat:

- HTML-ekké. Ez azonban nem kívánt következményekkel járhat, amelyek a [Changing your Blogdown Workflow](https://drmowinckels.io/blog/2020-05-25-changing-you-blogdown-workflow/) bejegyzésben olvashatók (amelyre blogdown felhasználók egyéb kerülőútjai mellett hivatkoztak a repó [v0.21 wishlist #476](https://github.com/rstudio/blogdown/issues/476) issue-jában). A legtöbb kérdés megoldódott [ezen a megjegyzés](https://github.com/rstudio/blogdown/issues/476#issuecomment-708908238) tanúsága alapján.
- markdown fájlokká. Ezt a Hugo már képes feldolgozni. Ez a blogdown-ban beállítható a build folyamat speciális lehetőségeként. A build lehetőségek áttekintéséhez lásd a blogdown könyv [D.9 Different building methods](https://bookdown.org/yihui/blogdown/methods.html) szakaszát, és ezeket az érzékletes diagramokat: [Scientific and Technical Blogging: Radix vs. Blogdown](https://emitanaka.org/r/posts/2018-12-12-scientific-and-technical-blogging-radix-vs-blogdown/#fig:blogdown).

### Academic (Wowchemy) téma
Fontos alkotóelem a **Hugo téma**. Amint az a blogdown könyv [1.7 A recommended workflow](https://bookdown.org/yihui/blogdown/workflow.html) fejezetében szerepel, az első feladat egy Hugo alapú webhely építésekor az, hogy:

> 1. Carefully pick a theme at https://themes.gohugo.io...  
> [magyarul: 1. Óvatosan válasszunk témát a https://themes.gohugo.io oldalról...]

A webhely létrehozására tett első próbálkozásaim idején (2020. szeptember közepe) a blogdown könyv az **Academic témát** javasolta, amely *"erősen ajánlott az egyetemi felhasználók számára"* lásd a vonatkozó könyvfejezet [előzményeit](https://github.com/rstudio/blogdown/commits/master/docs/01-introduction.Rmd), különös tekintettel erre a [pull request-re](https://github.com/rstudio/blogdown/pull/479). Kétnyelvű oldalt akartam, az Academic ezt támogatta, ezért választottam. Időközben az Academic átment egy [arculatváltáson](https://wowchemy.com/blog/introducing-wowchemy/), Wowchemy lett és adaptálta a Hugo modulok rendszerét. Ehhez a blogdown-nak alkalmazkodnia kellett, és valahogy a karbantartójának, Yihui Xie-nek sikerült is ezt meglépni. De az újonnan fellépő nehézségek arra késztették a karbantartóit, hogy távolítsák el az Academic-et az ajánlott témák közül. Mégis miért tartok ki mellette? Főleg azért, mert:

- *népszerű*, így nagyobb eséllyel kapok segítséget, ha szükséges
- *aktívan karbantartott*, ami frissítéseket és új funkciókat is jelent
- *egyszerű, mégis funkcionális kialakítás*, amely különböző tartalmakat tesz lehetővé (bemutatkozó oldal, blogbejegyzés, könyvfejezet)

Majdnem sutba dobtam és meg is teszem, ha szükséges. A fentiek szemléltetik, mennyire fontos lépést tartani a változásokkal. Néha ezek a változtatások elrontják a kódot és néha a dependency hell szól közbe. Ezzel elérkeztünk a tényleges telepítési folyamathoz.

# Telepítés és használat
## Telepítés
Szinte az egész blogdown könyvet elolvastam és a [telepítést](https://bookdown.org/yihui/blogdown/installation.html) ennek megfelelően végeztem el. De feltűnt az első akadály, amit ez a [Stack Overflow poszt](https://stackoverflow.com/q/63898557/14261671) dokumentál.

A fő probléma az volt, hogy telepíteni kellett a Go-t ahhoz, hogy használni lehessen a blogdown-t az Academic Hugo témával (az RStudio-ban, de feltételezem, hogy az RStudio nélkül is így lett volna). Ennek oka a téma Hugo modulrendszerre való átállása volt. Amint a Stack Overflow posztban is kiemeltem, ez számomra meglepő volt, hiszen *"A többi statikus weboldal generátorral ellentétben a Hugo telepítése nagyon egyszerű, mert egyetlen futtatható fájlt biztosít függőségek nélkül a legtöbb operációs rendszer esetén."* — olvasható a blogdown könyv [2.1 Static sites and Hugo](https://bookdown.org/yihui/blogdown/static-sites.html) szakaszában. A problémám ellentmondott a Hugo egyik fő előnyének! A blogdown csomag karbantartójának, Yihui Xie-nek köszönhetően ez megoldódott a [da068a7](https://github.com/rstudio/blogdown/commit/da068a7d8b4b5c923044665de91c21906ca66a11) jelzetű commit által (ahol ő maga is kifejezi a döbbenetét a helyzet miatt). Ez a commit a blogdown [0.21-es verziójához](https://github.com/rstudio/blogdown/blob/2637c1cdfb997f0ff113cfa2225533a3d88f87c1/NEWS.md) tartozott. (Itt az *"If a theme contains Hugo modules ..."* kezdetű bekezdés vonatkozik erre a problémára, aminek a lényege, hogy már egy téma telepítése során feloldásra kerül egy modultól való függőség, tehát nem lesz szükséges a Go vagy Git telepítése modulrendszerű téma használatakor). Megjegyzés: ha az Academic téma [telepítési dokumentációját](https://wowchemy.com/docs/install-locally/) követjük, akkor a Go (és más szoftverek) telepítése szükséges előzetesen.

A szoftveres környezet beállítása után követtem a téma dokumentációját: [Getting started](https://wowchemy.com/docs/get-started/), vagyis *Első lépések*. Az experience widget kivételével meg akartam szabadulni a legtöbbtől. Erről ez olvasható:
> Then, open your `content/home/` folder and set the active parameter to either true or false for each widget depending on if you wish to display it or not. Widgets that you don’t need **can alternatively be deleted** rather than setting active to false.  
> [magyarul: a `content/home/` mappában az egyes widgetek `active` paraméterét állítsuk be true-ra vagy false-ra, aszerint, hogy meg akarjuk-e jeleníteni. A szükségtelen widgetek **törölhetőek is**, nem muszáj az `active` paraméter false-ra állításával foglalkozni.]

Tehát töröltem őket. Mégse tudtam megszabadulni ettől a kezdőképernyőtől:

![Nem kívánt kezdőlap képernyő zöld háttérrel](green_homepage.png)

Tehát némi szitkozódás és újratelepítés után úgy döntöttem, hogy megtartom az összes widget fájlt és az `active` paraméterüket `false`-ra állítom a fájl front matter-jében. És lám, működött. (Egyébként ezt a képet nem korábban mentettem el, hanem a Google képkeresőjével találtam meg: `hugo academy widget` :heavy_plus_sign: Tools :arrow_right: Color :arrow_right: zöld)

Mit tettem ezen kívül a telepítés részeként?

- beállítottam az avatart (kép a kezdőképernyőn és a tartalom után), lásd: [Wowchemy docs: Getting started](https://wowchemy.com/docs/get-started/#introduce-yourself)
- weboldal ikon, [Wowchemy docs: Customization](https://wowchemy.com/docs/customization/#website-icon)
- színes témák, [Wowchemy docs: Customization](https://wowchemy.com/docs/customization/#color-themes)
- menük (angol/magyar), [Wowchemy docs: Language and translation](https://wowchemy.com/docs/language/#navigation-bar)
- widget térköz, [Add option to customize homepage section spacing? #433](https://github.com/wowchemy/wowchemy-hugo-modules/issues/433)
- egyéb beállítások (mind a `config/_default/params.toml` fájlban)
  - nincs térkép
  - nincs Contact widget
  - nincs komment

## Kétnyelvű beállítások
Problémák merültek fel a kétnyelvű beállításommal is. A legnehezebbet egy [Stack Overflow poszt](https://stackoverflow.com/q/64688201/14261671)-ban dokumentáltam. Amikor megpróbáltam használni a blogdown "New Post" bővítményét, a bővítmény létrehozta, de nem töltötte be az új fájlt. Yihui commit-ja oldotta meg a blogdown repóban. A kétnyelvű beállításokról leírásokat az Források menü [blogdown]() szakaszában lehet megtalálni.

A beállítás két részre osztható: **tartalom** és **interfész** fordításra.

### Tartalom fordítás
A tartalomfordítás kétféleképpen kezelhető: **fájlnevek alapján** és **könyvtárak szerint** ([Hugo Multilingual Part 1: Content translation](https://regisphilibert.com/blog/2018/08/hugo-multilingual-part-1-managing-content-translation/)). Azért választottam a könyvtár módot, mert szerettem volna kihasználni a Hugo *page bundle* lehetőségeit (amely megengedi az adott poszthoz tartozó fájlok különálló mappákba rendezését). Létrehoztam (tükröztem) a magyar tartalom mappát (`content/hu/`) az angol (`content/en/`) alapján és módosítottam a fájlokat.

- *Hogyan lehet szerkeszteni azt, amit a böngészőfülön láthatok?* Ez egy HTML fájl \<title\> eleme. Ezt a markdown YAML fejlécének a `title` paraméterében lehet szerkeszteni. A kezdőlap címét a `config.toml` fájl `title` paramétere határozza meg. De hogyan állíthatnék be másik címet a magyar oldalhoz? Esetleg a `config/_default/languages.toml` fájlban? Megér egy próbát. És voilá, működik. (Lásd a fájlokat a [website](https://github.com/hermanp/website) GitHub repómban.) Az egyes paraméterek újradefiniálási lehetőségeit lásd lentebb a szerzői jogi fordítási pontban.
- *Hogyan jelenítsek meg magyar slug-ot egy magyar bejegyzés URL-jében?* Létre akartam hozni az első kétnyelvű tartalmat és összekapcsolni őket (ezt hívják *translation linking*-nek). Ha ez az összekapcsolás érvényben van, akkor látható a nyelvváltó. Ahhoz, hogy egy magyar poszt URL-jében magyar slug legyen látható, ékezetek (vagy másnéven *diakritikus jelek*) nélkül, a `slug` paramétert ennek megfelelően kell beállítani a front matter-ben. Fontos az [összekapcsolásnál](https://gohugo.io/content-management/multilingual/#translation-by-content-directory): *"By having the same path and basename (relative to their language content directory), the content pieces are linked together as translated pages"*, vagyis megegyező (adott nyelvi könyvtárhoz képesti) relatív elérési út és fájlnév szükséges.

### Interfész fordítás
Ennek a feladatnak két részét nevezném meg: **string lokalizáció** és **lábléc fordítás**.

A string-ek (azok az állandó weboldal elemek, amelyek különféle működések közben jelennek meg, mint pl. Keresés vagy Találat) lokalizálása egyszerű, hiszen csak a megfelelő (internationalization, rövidítve *i18n* a szóközi betűk száma alapján) nyelvi fájlt kell a weboldal gyökérkönyvtárának `/i18n` mappájában elhelyezni (és ezzel felülírni a téma alapbeállítását). Lásd: [Hugo Multilingual Part 2: Strings localization](https://regisphilibert.com/blog/2018/08/hugo-multilingual-part-2-i18n-string-localization/) és Wowchemy dokumentáció [Language and translation](https://wowchemy.com/docs/language/). Az eredeti problémám a light/dark/automatic felületek neveinek lefordítása volt, amit egy Wowchemy fórumbeszélgetés javaslata oldott meg [Light/Dark/Automatic translation #1891](https://github.com/wowchemy/wowchemy-hugo-modules/discussions/1891). Ez alapján meg kellett találnom és átmásolnom az eredeti `hu.yaml` i18n fájlt az `/i18n` gyökérbeli könyvtárba, majd frissítenem az angol `en.yaml` fájlnak megfelelően.

A lábléc fordítását ebben a szakaszban tárgyalom, a tartalomtól való elkülönülése miatt. Kicsit trükkösebb, mint az i18n fájlok, mivel *partial*-okkal kell dolgozni. Röviden: át kell másolni egy partial HTML fájlját (<PARTIALNAME>.html) a téma `theme/<THEME>/layouts/partials/` mappájából a weboldal gyökér `layouts/partials/` mappájába a további testreszabás (és az eredeti felülírása) érdekében. Lásd: [Partial Templates](https://gohugo.io/templates/partials/) és Wowchemy dokumentáció [Customization](https://wowchemy.com/docs/customization). Az eredeti problémám az volt, hogyan fordítsam le a lábléc szerzői jogi (copyright) és közreműködői (credits) szövegét.

- copyright fordítás: A `config.toml` fájlban a `copyright` paramétert üresre állítottam, csak a Creative Commons opciót használom (eredetileg a `params.toml` fájlban). Azonban utóbbiban szerepel egy string paraméter, amelyet le kell fordítani. Hogyan adhatom hozzá a fordítást? Hogyan érvényesíthetőek a nyelvfüggő opciók? Ezt a Wowchemy repó egy 2016-os (!) többnyelvűségi kérdéséhez fűzött [megjegyzés](https://github.com/wowchemy/wowchemy-hugo-modules/issues/67#issuecomment-279551652) alapján oldottam meg. Röviden: *"It seems that Hugo allows you to put both the core Hugo variables like `title = "My blog"` and the Academic `[params]` variables (like `name = "My name in Russian"`) under the `[languages.X]` configuration section."* Magyarul: "Úgy tűnik, hogy a Hugo lehetővé teszi, hogy mind az alapvető Hugo változókat, például a `title = "My blog"`, mind az Academic `[params]` változókat (például `name = "My name in Russian"`) a `[languages.X]` konfigurációs szakasz alá lehessen helyezni."
- credits fordítás: A láblécben szerettem volna lefordítani a Wowchemy közreműködői jegyzetét, amelyet a `site_footer.html` fájlban egy if-else feltételen keresztül lehet megtenni. Ez a Wowchemy fórumbeszélgetés [How can I add credits by the end of the page? #1886](https://github.com/wowchemy/wowchemy-hugo-modules/discussions/1886) egy példával mutatott rá.
- copyright ikonok: a Creative Commons ikonok weblinkjei látszólag érvénytelenné váltak, ezért nem jelentek meg. Frissítenem kellett őket a `site_footer_license.html` fájlban.

## Használat
### Automatikus üzembehelyezés
Miután megírod a tartalmat és közzé kívánod tenni, a weboldalt a forrásfájljaiból fel kell építeni. Ez létrehoz egy `/public` mappát a gyökérmappában. Ezután ezeket a fájlokat át kell másolni a weboldal könyvtárába egy tárhelyszolgáltatón. Ez fáradságos és előttem mások is túl akartak jutni rajta különféle automatizálással:

- shell szkriptek ([Deploying a hugo-based website on GitHub user pages | Marina Varfolomeeva](https://varmara.github.io/post/2019-01-15-deploying-a-hugo-based-website-on-github-user-pages/) és [Making a Website Using Blogdown, Hugo, and GitHub Pages | Amber Thomas](https://amber.rbind.io/2016/12/19/website/))
- GitHubon kívüli folyamatos integrációs/üzembehelyezési (continuous integration/deployment, CI/CD) szolgáltatások igénybevételével, amelyek közül néhány tárhelyszolgáltatóként is működik (mint a Netlify). Például [Hugo on GitHub Pages using Travis-CI for deployment](https://creaturesurvive.github.io/repo/blog/hugo-on-github-pages-using-travis-ci-for-deployment/) vagy lásd a blogdown könyv [3. Deployment](https://bookdown.org/yihui/blogdown/deployment.html) fejezetét a témával kapcsolatos részletes leírásért.

Amikor nem olyan régen a GitHub Actions megszületett, minden lehetővé vált a GitHubon belül. A GitHub Actions egy beépített CI/CD szolgáltatás a GitHub-ban, ezért mindent meg lehet csinálni a GitHubon belül. Az alábbi bejegyzések alapján voltam képes elvégezni a weboldalam automatikus üzembehelyezését:

- [Automate Deployment of Wowchemy Website onto GitHub Pages](https://www.jameswright.xyz/post/deploy-hugo-academic-using-githubio/)
- [Getting Started With Hugo Academic and Github Pages](https://lakemper.eu/blog/getting-started-with-hugo-academic-and-github-pages/)
- [Automatically Deploying a Hugo Website via GitHub Actions](https://www.morling.dev/blog/automatically-deploying-hugo-website-via-github-actions/)
- [Hugo: Deploy Static Site using GitHub Actions](https://ruddra.com/hugo-deploy-static-page-using-github-actions/)

Megjegyzés: Hallottam az [forestry.io](https://forestry.io/)-ról, amely lehetővé teszi a forrásfájlok online szerkesztését és onnan való közzétételét. Parancssori felület nélküli lehetőség a webhely kezelésére.

### Aktuális munkafolyamat
1. Megnyitom a (git verziókezelt) weboldal projektet az RStudio-ban.
2. Létrehozok egy új bejegyzést a "New Post" bővítmény segítségével.
3. Írom a tartalmat.
4. Commit-olom a változásokat.
5. Feltolom (push) a GitHubra a [forrás repóba](https://github.com/hermanp/website).
6. Hagyom, hogy a GitHub Actions elvégezze a dolgát: építse fel a weboldalt és telepítse a `public` mappát a [GitHub Pages repóba](https://github.com/hermanp/hermanp.github.io).

### Az weboldal működtetése
Próbálom a munkám a repó [Projects](https://github.com/hermanp/website/projects) oldala alapján kezelni. Ez egy [Trello](https://trello.com/)-hoz hasonlító tábla, ahol a feladatok nyomon követhetők. Ha valami eszembe jut, akkor egy Note-ot (jegyzetet) készítek róla a To Do listán belül. Ha felér magában egy feladattal, akkor átalakítom Issue-vá. Ha elkezdek dolgozni egy Note-on vagy Issue-n (azzal a céllal, hogy le is zárjam), akkor áthelyezem az In Progress listába. A nyitott Issue-k automatikusan lezárhatók egy git push-sal, a [dokumentációnak](https://docs.github.com/en/free-pro-team@latest/github/managing-your-work-on-github/linking-a-pull-request-to-an-issue#linking-a-pull-request-to-an-issue-using-a-keyword) megfelelően.

# Tanulságok
Két stratégiát látok, de nem zárják ki egymást:

- gondos dokumentáció olvasás és lassú, folyamatos munka: néha MUSZÁJ elolvasni
- mindent a lehető leggyorsabban kipróbálni és ha problémák merülnek fel, új iteráció indul (néha újratelepítéssel): nem szabad sokáig hezitálni, a lehető legtöbbet ki kell hozni az értékes időből

Ne stresszeld magad, ha nem tudod olyan gyorsan beindítani, mint mások. Hiszen sok bejegyzés található a telepítés közbeni félresiklásokról is! Ha szerencséd van, nem ragadsz bele a mocsárba. De a szerencse azok oldalán áll, akik tesznek is érte. :wink:

{{% callout note %}}
Ez a poszt az [angol változat](/en/post/how-this-blogdown-site-was-created/) fordításaként készült.
{{% /callout %}}
