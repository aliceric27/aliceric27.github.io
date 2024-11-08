---
title: 使用 Vue 設定偽元素 content
date: 2024-09-03 11:49:30
tags:
  - [Front-end]
categories:
  - [Front-end]
---


Vue 從模板傳值到 CSS 偽元素 content 內容

<!-- more -->
------
## 使用 Attr()

首先在模板定義`data-*`參數，並使用 Vue 模板傳入對應值
```html
<div class="dh-header" :data-title="data.title"></div>
```

然後在 CSS 中使用`attr()`引入自訂的變數
```css
.dh-header:before {
	content:attr(data-title);
	display:block;
}
```

------

[什麼是 HTML 5 中的資料屬性（data-* attribute）](https://pjchender.dev/html/html-data-attribute/)
