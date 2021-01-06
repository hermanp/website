---
title: About the bookmarks
author: Peter Herman
date: '2021-01-05'
slug: about-the-bookmarks
categories: []
tags:
  - bookmarks
  - setup
subtitle: ''
summary: ''
authors: []
lastmod: '2021-01-05T10:18:19+01:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

My [bookmarks](/en/resources/bookmarks/) is published under the Resources tab. I currently use Mozilla Firefox, formerly Google Chrome for browsing. I bookmark websites from the beginning. But why do I?

## Characteristics
### Saving

It’s typical for my browsing that I don’t like to leave many tabs open. If there is not enough information on a given tab, I will close it. If it contains useful info, I usually bookmark it. Because the number of bookmarks is growing rapidly this way (which was a problem for Chrome, for example), I regularly *export* (save) them to my computer. Then I have the opportunity to weed out, to refresh them. So the number of my bookmarks is growing and shrinking according to how much I find their topic worth preserving. It also happens that the topic is worth preserving, but I feel it is necessary to prune them. This is when I usually delete entire folders.

### Organizing
I organize the bookmarks into *folders* by topic. I recently came up with a rule that I try to stick to: don’t embed folders deeper than three levels. For example, R => Plot => Tools. If I feel the need to create a fourth level, I will consider moving, deleting to adhere to my principle if possible. This keeps it clearer.

### Languages
My bookmarks mostly include *Hungarian* and *English* pages. Since I organize them according to the topic, their language is irrelevant to me. For this reason, the Hungarian and English pages may be mixed within a given topic. Because I feel it is unnecessary to translate them into the other language, they are also mixed in this way on the Resources page.

About two-thirds of all my bookmarks are visible within the Resources page. These are mostly related to work and my narrower area of ​​interest.

## Creating the entry

When I was thinking about compiling the page, it popped to my mind to display the bookmark favicons. However, due to the difficulty of the accompanying work (especially automation), I discarded it. Instead, I use a simple multi-level unordered list. I also chose this solution because of the large number of bookmarks and their nested nature, I found it necessary to include a table of contents aside to make them more transparent.

The arduous process of creating the site is well illustrated by the accompanying GitHub issue [Make a treeview of bookmarks in Resources menu](https://github.com/hermanp/website/issues/2). I will try to summarize this briefly below:
- **goal**: Display some of my bookmarks within the Resources page as automatically as possible. By doing so, I force myself to sort them, make them available to others, and I can link to them on my website.
- **initial idea**: I was reminded of a tree graph of the folders displayed by Windows Explorer. In English this is called a *treeview*. A similar effect could be achieved with the *accordion* element, which also forms an expandable list. It would be good to explain each bookmark: why that particular page is interesting. It would also be a good idea to display *favicons* next to the bookmark title.
- **research**: I searched Google for terms that included the environment (Hugo), preferred technology (HTML, CSS to make it as simple as possible) and automation.
- **breakdown**: after ruling out options due to their complexity and not finding a ready (simple) solution to the problem, I was forced to experiment with the simplest functional version. This process is also well illustrated by the two Stack Overflow posts I published on the subject: [Convert Firefox bookmarks JSON file to markdown](https://stackoverflow.com/q/65111588/14261671) and [Keep newline character in string during gsub](https://stackoverflow.com/q/65143495/14261671)
- **solution**: simple nested unordered list. The many bookmarks would require a table of contents. Hugo can generate this by itself from header elements, but therefore I am forced to convert folder names to appropriate level header elements. Markdown allows to combine style elements.
- **refinement**: I only wanted to keep the markers (bullet points) for certain list items, but unfortunately I don't have the option to do so according to the current state of CSS. That's why I removed all of it.

## General considerations

A good way to keep my bookmarks in check is to place a group that covers a specific topic separately within the Resources menu. This way, they get out from the bookmarks, reducing their number, yet you have the opportunity to expand them. Exploration on the topic can be continued with additional links and they can be explained. These can be seen as antecedents of posts.

If we look at the phenomenon from a distance, we can actually ask the following question: *How can we deal with the things that come to our attention while browsing?* This contains:
- **saving** (later access), bookmarks are appropriate for this
- **organizing** (in the light of the above, grouped or labeled so that they are clear or easy to find), bookmarks are also good for this. Especially in Firefox, because Chrome bookmarks can't be tagged.
- **note taking** (what I was thinking when I saved it),
- **annotating** (there may be only one interesting sentence throughout the page).

*Annotation tools* ([alternatives](https://alternativeto.net/software/memex/)) try to provide solutions for the above tasks, such as:
- [Memex](https://getmemex.com/). I tried to use this for a while but found it a bit cumbersome. This is also due to the changeover. The company’s philosophy itself is exemplary, it’s worth reading their blog.
- [Pocket](getpocket.com). I started using this too, but it’s not comfortable either. I haven’t dealt with exporting the data yet (but it doesn’t seem friendly).

Reviewing my bookmarks, I may be able to distinguish the following types:
- forums, e.g. [Stack Overflow](https://stackoverflow.com/), [Quora](http://www.quora.com/)
- databases, collections, search engines, e.g. [Internet Archive](https://archive.org/index.php), [Hungaricana](https://hungaricana.hu/hu/)
- tools, e.g. [Trello](https://trello.com/), [Leaflet](https://leafletjs.com/)
- posts, articles, e.g. [Medium](https://medium.com/) posts, [Index](https://index.hu/tech/helpdeszka/2019/03/05/netbiztonsagi_kalauz_kiberbiztonsag_adatvedelem_jelszo_adathalaszat_titkositas/) articles
- books, e.g. [Happy Git and GitHub for the useR](http://happygitwithr.com/), [ELTE IK ekönyvek](https://www.inf.elte.hu/etananyag)
- blogs, personal websites, e.g. [Hope in Source](https://hopeinsource.com/), [Yan Holtz](https://www.yan-holtz.com/)
- separate pages, e.g. [EU GDPR](https://gdpr.eu/)

If I look through these, I can see that there is an overlap, for example I often search on Stack Overflow as well. I can also look at them as pages on which
- no new content is generated or only a small amount, so it is easy to comprehend
- new content is created or discovered (in larger amounts), thus rapidly increasing the number of bookmarks.

The situation above raises these questions: is it worth categorizing and managing bookmarks under that page? Is it possible to manage them through the page to which they belong? Doesn’t it make them harder to review and harder to access if I manage them through a particular page and not through bookmarks? For example, should I organize Medium posts through Medium? Should I handle Stack Overflow questions through their site? If that was the case, I would only keep them in one place: either in the bookmarks or in the system of that page, because I don’t want to do double work. Another alternative would be to use the annotation applications mentioned above, in which the quickly generated content could be saved and managed regardless of their origin, from which only a few would be included in the bookmarks. A third alternative is to take notes on them, even on this blog and thereby process them. Then it is not necessary to save the page itself, but notes will arise and need to be maintained...

The situation is plastic and will change in the future.
