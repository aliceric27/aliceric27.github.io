---
title: JS 的 Even Loop 是什麼？
date: 2024-09-10 17:22:10
tags:
  - [Front-end]
categories:
  - [Front-end]
---

解釋 JS 中的 Even Loop 機制

<!-- more -->
------


## 概述

簡單來說 JS 是單執行緒的機制，為了支援非同步的任務，而在**JS引擎**中引入的一個機制

機制內分為不同區塊 Stack、Queue、Heap

- JS 程式碼在執行時會依序將任務放入 Stack ，中並按照順序執行。
- 當一個任務呼叫為**非同步**任務時則會放在 Queue 內，待 Stack 內的任務完成後，會將 Queue 的任務放到 Stack 內最後按順序執行


## Macrotask Queue、Microtask Queue

Callback Queue 又分為 Macrotask Queue 和 Microtask Queue

### Macrotask Queue

- 從`<script src="...">`外部下載的 script
- DOM event handlers，例如 mousemove event 的 callback function handler
- 各種 Web APIs，例如 setTimeout 的 callback function
- ajax callback function

![marcotask](https://gcdeng.com/assets/images/Screen_Shot_2021-05-16_at_10.37.11_PM-82dd3d3de0ac10d80cccff54a783ea5e.png)

### Microtask Queue​

- promise `.then/catch/finally` 中的 callback function
- `queueMicrotask(func)` 中的 func

簡單來說，像是 Promise.then 在非同步任務中是屬於 Microtask Queue​ ，在 Even Loop 則會被分配到優先執行的 Microtask Queue​

每個 Macrotask 執行結束後會先將 Microtask queue 中的任務全部執行完，才會繼續執行瀏覽器渲染跟其他 Macrotask。

> 舉例
這個執行印出答案為 1,3,4,2
Macrotask​ 為 console.log(1)
Microtask queue 為 Promise.then()
Macrotask Queue 為 setTimeout()


```js

console.log(1);

setTimeout(function () {
  console.log(2);
}, 0);

Promise.resolve()
  .then(function () {
    console.log(3);
  })
  .then(function () {
    console.log(4);
  });

```
------

附上更詳細的解釋，有影片和圖片解釋寫的非常完整

[JavaScript Event Loop解說：單執行緒還能異步運算？](https://www.youtube.com/watch?v=z4S6ZxRD2rA&pp=ygUKRXZlbnQgTG9vcA%3D%3D)

[深入了解事件迴圈(Event Loop)，Macrotask跟Microtask是什麼？](https://gcdeng.com/series/Javascript/javascript-deep-dive-into-event-loop)

[請說明瀏覽器中的事件循環 (Event Loop)](https://www.explainthis.io/zh-hant/swe/what-is-event-loop)

