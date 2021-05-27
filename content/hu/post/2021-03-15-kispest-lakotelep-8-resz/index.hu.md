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
lastmod: '2021-05-27'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

Ebben a részben a célom rögzíteni azokat a lépéseket, amik elvezettek a lakóépületek interaktív térképi ábrázolásáig: épületlajstrom, OpenStreetMap szerkesztés és exportálás, térképi ábrázolás és R Shiny alkalmazás.

Felhasználva a 4. részben közölt 1981-es Kispest beépítési tervet és *A budapesti célcsoportos és magánerős komplex VI. ötéves tervi lakásépítés: hálós elemzés* című többkötetes kiadvány helyszínrajzait, ezeket egybevetve a Google Maps műholdas alaptérképével, képes voltam összeírni a kispesti lakótelep lakóépületeit (zárójelben típusok szerint):

- I. ütem: 3 db 5 szintes, két különálló egységből álló épület és 8 db 10 szintes A-4 típusú pontház
- II/A ütem: 3 db 10 szintes A-4 típusú pontház, 10 db 11 szintes S-12 típusú szalagház és 5 db 4 és 5 szintes elemekből összeállított H-O típusú épület
- II/B ütem: összesen 12 db 11 emeletes S-412 típusú szalagház, 14 db 11 emeletes S-312 típusú szalagház, 10 db 11 emeletes F-90 típusú szalagház, 9 db 4 és 5 szintes elemekből összeállított H-O típusú épület és 17 db 4 vagy 5 szintes E-5 típusú épület.

Ezekről egy attribútum táblázatot állítok össze, ami tartalmazza a lakóépület típusát, címét, szintszámát és egyéb adatokat. A cél, hogy interaktív térképen ábrázoljam az *épület alapterületet* (magyarul talán így, angolul viszont *building footprint*-nek hívják). Az interaktivitást az jelenti, hogy ki/be kapcsolhatóak a megjelenített épületek az egyes jellemzők szerint.
