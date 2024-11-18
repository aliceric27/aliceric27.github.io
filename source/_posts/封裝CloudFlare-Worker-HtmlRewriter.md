---
title: 封裝 HtmlRewriter API
date: 2024-11-18 14:54:37
tags:
  - [Backend]
  - [Tools]
categories: 
  - [Backend]
  - [Tools]
---

將 CloudFlare Worker 的 HtmlRewriter 封裝成類似 jQuery 的 DOM 操作

<!-- more -->

------



# DOMHelper

## 原始碼（貼在 Worker 最上方）

```javascript
class ElementWrapper {
  constructor(selector) {
    this.selector = selector;
    this._innerText = null;
    this._innerHTML = null;
    this._attributes = {};
    this._removed = false;
  }

  // 文字操作
  get innerText() {
    return new Promise(resolve => {
      let text = '';
      const rewriter = new HTMLRewriter()
        .on(this.selector, {
          text(chunk) {
            text += chunk.text;
          }
        });
      resolve(text);
    });
  }

  setInnerText(value) {
    this._innerText = value;
    return this;
  }

  // HTML 操作
  get innerHTML() {
    return new Promise(resolve => {
      let html = '';
      const rewriter = new HTMLRewriter()
        .on(this.selector, {
          element(element) {
            element.onEndTag(endTag => {
              resolve(html);
            });
          },
          text(chunk) {
            html += chunk.text;
          }
        });
      resolve(html);
    });
  }

  setInnerHTML(value) {
    this._innerHTML = value;
    return this;
  }

  // 屬性操作
  getAttribute(name) {
    return new Promise(resolve => {
      const rewriter = new HTMLRewriter()
        .on(this.selector, {
          element(element) {
            resolve(element.getAttribute(name));
          }
        });
    });
  }

  setAttribute(name, value) {
    this._attributes[name] = value;
    return this;
  }

  removeAttribute(name) {
    this._attributes[name] = null;
    return this;
  }

  hasAttribute(name) {
    return new Promise(resolve => {
      const rewriter = new HTMLRewriter()
        .on(this.selector, {
          element(element) {
            resolve(element.hasAttribute(name));
          }
        });
    });
  }

  // 內容插入
  before(content, options = {}) {
    this._before = { content, options };
    return this;
  }

  after(content, options = {}) {
    this._after = { content, options };
    return this;
  }

  prepend(content, options = {}) {
    this._prepend = { content, options };
    return this;
  }

  append(content, options = {}) {
    this._append = { content, options };
    return this;
  }

  // 元素操作
  remove() {
    this._removed = true;
    return this;
  }

  removeAndKeepContent() {
    this._removeAndKeepContent = true;
    return this;
  }

  replace(content, options = {}) {
    this._replace = { content, options };
    return this;
  }
}

class DOMHelper {
  constructor(response) {
    this.response = response;
    this.rewriter = new HTMLRewriter();
    this.modifications = [];
    this.documentHandler = null;
  }

  querySelector(selector) {
    const wrapper = new ElementWrapper(selector);
    this.modifications.push({
      selector,
      wrapper
    });
    return wrapper;
  }

  onDocument(handler) {
    this.documentHandler = handler;
    return this;
  }

  transform() {
    // 處理文檔層級的修改
    if (this.documentHandler) {
      this.rewriter.onDocument(this.documentHandler);
    }

    // 處理元素層級的修改
    for (const mod of this.modifications) {
      this.rewriter.on(mod.selector, {
        element(element) {
          const wrapper = mod.wrapper;

          // 處理屬性
          for (const [name, value] of Object.entries(wrapper._attributes)) {
            if (value === null) {
              element.removeAttribute(name);
            } else {
              element.setAttribute(name, value);
            }
          }

          // 處理內容插入
          if (wrapper._before) {
            element.before(wrapper._before.content, wrapper._before.options);
          }
          if (wrapper._after) {
            element.after(wrapper._after.content, wrapper._after.options);
          }
          if (wrapper._prepend) {
            element.prepend(wrapper._prepend.content, wrapper._prepend.options);
          }
          if (wrapper._append) {
            element.append(wrapper._append.content, wrapper._append.options);
          }

          // 處理內容替換
          if (wrapper._innerText !== null) {
            element.setInnerContent(wrapper._innerText);
          }
          if (wrapper._innerHTML !== null) {
            element.setInnerContent(wrapper._innerHTML, { html: true });
          }

          // 處理元素移除
          if (wrapper._removed) {
            element.remove();
          }
          if (wrapper._removeAndKeepContent) {
            element.removeAndKeepContent();
          }
          if (wrapper._replace) {
            element.replace(wrapper._replace.content, wrapper._replace.options);
          }
        },

        comments(comment) {
          // 處理註釋節點
        },

        text(text) {
          // 處理文字節點
        }
      });
    }

    return this.rewriter.transform(this.response);
  }
}

```


## 簡介
DOMHelper 是一個基於 Cloudflare Worker HTMLRewriter API 的封裝工具，提供簡單直觀的 DOM 操作介面。主要用於在 Worker 環境中修改 HTML 內容。

## 特點
- 類 jQuery 的鏈式操作
- 支援非同步讀取操作
- 支援 HTML 內容修改
- 支援 CSS 選擇器

### 選擇器支援
支援標準 CSS 選擇器語法：
- ID 選擇器: `#id`
- 類別選擇器: `.class`
- 標籤選擇器: `div`
- 屬性選擇器: `[attr="value"]`
- 複合選擇器: `div.class[attr="value"]`



### 文字操作

#### `.innerText`
> 取得元素的純文字內容
> 返回: `Promise<string>`

```javascript
const text = await dom.querySelector('.Header_YMD').innerText;
```

#### `.setInnerText(value)`
> 設定元素的純文字內容
> 參數: `value` (string)
> 返回: `this`

```javascript
dom.querySelector('#dateHeader').setInnerText('2024年3月15日');
```

### HTML 操作

#### `.innerHTML` 
> 取得元素的 HTML 內容
> 返回: `Promise<string>`

```javascript
const html = await dom.querySelector('#Table').innerHTML;
```

#### `.setInnerHTML(value)`
> 設定元素的 HTML 內容
> 參數: `value` (string)
> 返回: `this`

```javascript
dom.querySelector('#northTable').setInnerHTML(`
  <tr>
    <td class="text-center">台北市</td>
    <td class="text-center">正常上班上課</td>
  </tr>
`);
```

### 屬性操作

#### `.getAttribute(name)`
> 取得元素屬性值
> 參數: `name` (string)
> 返回: `Promise<string>`

```javascript
const theme = await dom.querySelector('body').getAttribute('class');
```

#### `.setAttribute(name, value)`
> 設定元素屬性
> 參數: `name` (string), `value` (string)
> 返回: `this`

```javascript
dom.querySelector('body').setAttribute('class', 'dark-theme');
```

### 元素操作

#### `.remove()`
> 移除元素
> 返回: `this`

```javascript
dom.querySelector('#loading').remove();
```

#### `.before(content, options)`
> 在元素之前插入內容
> 參數: `content` (string), `options` (object)
> 返回: `this`

```javascript
dom.querySelector('.container').before('<div class="alert">最新通知</div>', { html: true });
```

#### `.after(content, options)`
> 在元素之後插入內容
> 參數: `content` (string), `options` (object)
> 返回: `this`

```javascript
dom.querySelector('.table').after('<div class="footer">資料來源：人事行政總處</div>', { html: true });
```
### `options` 參數

> `{ html: Boolean }` 控制 HTMLRewriter 處理插入內容的方式。
> 如果 `html` 布林值設定為 `true`，則內容將被視為原始 HTML。
> 如果 `html` 布林值設定為 `false` 或未提供，內容將被視為文本，並將對其套用正確的 HTML 轉義。


## 實際應用範例

### 修改部落格網站

```javascript

const getHtml = async (url = "https://aliceric27.github.io/") => {
const response = await fetch(url);    
const dom = new DOMHelper(response);

    // 修改網站標題
    dom.querySelector('title')
       .setInnerText("修改後的網站標題");
  
    // 修改 meta 描述
    dom.querySelector('meta[name="description"]')
       .setAttribute('content', '新的網站描述');
    // 修改所有 p 標籤字體顏色
    dom.querySelector('p')
       .setAttribute('style', 'color: red;');
  
    // 修改 header 標題
    dom.querySelector('.site-title')
       .setInnerText('新的部落格標題');
    
    // 修改副標題
    dom.querySelector('.site-subtitle')
       .setInnerText('新的副標題');
  
    // 修改作者資訊
    dom.querySelector('.site-author-name')
       .setInnerText('新作者名稱');
  
    // 修改文章數量
    dom.querySelector('.site-state-item-count')
       .setInnerText('99');
  
    // 修改 GitHub 連結
    dom.querySelector('.github-corner')
       .setAttribute('href', 'https://github.com/newuser');
  
    // 新增自訂 CSS
    dom.querySelector('head')
       .append('<style>.custom-style { color: red; }</style>', { html: true });
  
    // 移除特定元素
    dom.querySelector('.post-button') //假設移除閱讀全文按鈕
       .remove();
  
    // 在特定位置插入內容
    dom.querySelector('.main-inner')
       .prepend('<div class="custom-header">自訂頁首</div>', { html: true });
  
    // 修改 footer
    dom.querySelector('.footer-inner')
       .setInnerHTML('<div>自訂頁尾內容</div>');
  
    return dom.transform();
}
export default {
  async fetch(request, env, ctx) {
    const result = await getHtml()
    return result;
    // return new Response('Hello World!');
  }
}

```


## 注意事項

1. 所有讀取操作(innerText, innerHTML, getAttribute)都是非同步的,需要使用 await
2. 修改操作(setInnerText, setInnerHTML, setAttribute)是同步的,可以鏈式呼叫
3. 必須在最後呼叫 transform() 來應用所有修改
4. 僅適用於 Cloudflare Worker 環境


## 錯誤處理
```javascript
try {
  const dom = new DOMHelper(response);
  // DOM 操作
  return dom.transform();
} catch (error) {
  console.error('DOM 處理錯誤:', error);
  return new Response('處理錯誤', { status: 500 });
}
```