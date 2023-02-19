---
title: "Технічний опис цього сайту"
date: 2023-02-16T18:29:46+02:00
translationKey: "how_i_built_this_site" 
---

### Технології

Цей сайт розміщено з допомогою сервісу [github pages](https://pages.github.com/) та побудовано з використанням інструменту [hugo](https://gohugo.io/) плюс [hugo-PaperMod](https://github.com/adityatelange/hugo-PaperMod) тема.  


#### Hugo

Я обрав Hugo, тому що він швидкий та простий. Заповнення вмісту сайту в основному 
відбувається з допомогою файлів з розміткою Markdown.
Також в Hugo присутня інтернаціоналізація (можливість вести сайт на двох мовах) "з коробки",
що є великим плюсом, як на мене.

#### Github pages
Надає готовий до використання CI/CD процес завдяки, чому мій
сайт оновлюється автоматично після кожного коміту до репозиторію.[^1]


### Вартість
Я витратився лише на купівлю домену kurotych.com.
Хостинг являється безкоштовним.

### Корисні посилання

- [Hosting Hugo on Github](https://gohugo.io/hosting-and-deployment/hosting-on-github/)
- [GitHub Pages with Namecheap custom domain ](https://gist.github.com/plembo/84f80c920bb5ac6f19e53fe6f8db1ff7)

[^1]: Ви повинні мати налаштований github workflow у вашому репозиторію з сайтом. Дивись [gh-pages.yml](https://github.com/kurotych/kurotych.github.io/blob/main/.github/workflows/gh-pages.yml)
