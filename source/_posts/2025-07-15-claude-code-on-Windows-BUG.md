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

![IMG_0348](https://i.imgur.com/Q6ChNvg.png)

進環境變數新增變數 `CLAUDE_CODE_GIT_BASH_PATH`

指定位置 `C:\Program Files\Git\git-bash.exe`


保存後重啟 終端 執行`claude` 就正常了

[參考連結](https://github.com/anthropics/claude-code/issues/3461#issuecomment-3068231817)

------