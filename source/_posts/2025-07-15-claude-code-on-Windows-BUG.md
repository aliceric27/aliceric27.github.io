---
title: Claude code CLI fails on Windows with Git Bash
date: 2025-07-15 15:17:44
tags: 
    - [AI]
categories:
  - [AI]
  - [Tools]
---

Claude code 在 Windows 上使用時遇到的 BUG。

<!-- more -->

------

TL:DR

在 npm 資料夾修改 `cli.js`

1. 使用 npm 查看 global 安裝路徑：

```
npm config get prefix
// C:\Users\Alex\AppData\Roaming\npm

cd C:\Users\Alex\AppData\Roaming\npm\node_modules\@anthropic-ai\claude-code
```
2. 修改 `cli.js` 檔案，找到判斷式 `let W=Y.find((J)=>J&&Sw0(J));`

在大約第 712 行的 函數中，在 之後新增這一行：

```javascript
if(process.platform==='win32'&&!W&&v1().existsSync('C:/Program Files/Git/bin/bash.exe'))W='C:/Program Files/Git/bin/bash.exe';
```

**建議** 將bash.exe 的路徑改到沒有空白資料夾名稱的目錄，並修改上述目錄位置即可。

保存後重啟 claude 就正常了

[參考連結](https://github.com/anthropics/claude-code/issues/3461#issuecomment-3068231817)

------