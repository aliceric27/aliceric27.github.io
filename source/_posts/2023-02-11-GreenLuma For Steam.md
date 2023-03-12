---
title: GreenLuma For Steam
date: 2023-02-11 15:52
tags:
  - [steam]
categories:
  - [Others]
---

# GreenLuma For Steam

這款由俄國人開發專門解鎖 Steam 上遊戲與成就，繞過 Steam 啟動器驗證機制，讓我們可以執行乾淨的遊戲檔案。

該程式並不是直接破解遊戲本身，相反的是藉由繞過 Steam 啟動的驗證機制達到"類破解"的效果，放在 Steam 資料夾的遊戲還是正版遊戲，直接執行會沒辦法遊玩，藉由這款工具就可以直接啟動。

<!-- more -->

## 解決痛點

此應用解決了我的痛點

* B 帳號遊戲，可以使用 A 帳號遊玩
* 可以在 A 帳號保存雲端存檔
* 可以在 A 帳號保存成就
* 遊戲檔案乾淨非破解版遊戲檔案
* 可以隨時使用 B 帳號更新遊戲檔案

## GreenLuma 2023 Features

* Unlock not owned games
* Unlock not owned DLC
* Low Violence bypass
* Unlock Stats and Achievements in not owned games
* Use Steam Cloud in not owned games
* Create cracked dedicated online servers in many games
* Denuvo Support (If app ownership ticket (Decrypted + Encrypted) is available)
* SteamStub Support (If app ownership ticket (Decrypted) is available)
* LumaCEG plugin support
* Family Sharing restrictions bypass
* Region lock bypass
* Stealth mode
* Support for x64 and x86 games
* Support for official Steam client

## Stealth mode features

* Unlock not owned Games
* Unlock not owned DLC
* Low Violence bypass
* Use Steam Cloud in not owned games
* Family Sharing restrictions bypass
* Region lock bypass

[cs.rin.ru](https://cs.rin.ru/forum/viewtopic.php?f=10&t=103709)

[必要檔案下載](https://gofile.io/d/9GMj9n)

解壓縮密碼：cs.rin.ru

---

> GreenLuma 以下簡稱 GL

需要注意的是 Denuvo 加密類型的遊戲，還是必需要有該遊戲執行的 **Ownership Ticket**，這個東西是在執行遊戲時由 Steam 自動產生的驗證檔案(類似 Token )，需要有一個正版授權的帳號，登入並執行一次遊戲後，讓其產生 Ticket ，在透過 [SteamLite](https://cs.rin.ru/forum/viewtopic.php?f=29&t=68783) 提取出該解密後 Ticket ，放入 Steam 資料夾，在執行 GL 會自動帶入 Ticket 通過驗證並執行遊戲，不過 Denuvo 加密似乎非常嚴謹，每次更新 Windows 系統都會讓該 Ticket 失效，需要開原本帳號重新啟動產生新的 Ticket。

{% note warning %} 新版的 D 加密似乎又失效，這兩天反覆嘗試都沒辦法正常啟動。
建議 D 加密的遊戲使用好友分享遊玩 {% endnote %}

還有一個比較有意思的功能是繞過家庭共享限制，通常 Steam 家庭共享下的限制一次僅同時可以在一台電腦上啟動，使用 GL 就可以解除這個限制。

## 事前準備

首先依照自己遊玩的遊戲需要準備下述資料
基本上分為兩種狀況

1. B 帳號擁有該遊戲，想讓遊戲也在 A 帳號啟動遊玩

* 登入 B 帳號下載該遊戲，B 帳號進入遊戲確認版本語言正確
* 視情況提取 Ticket ( Denuvo 加密)
* 關閉後使用 GL 開啟A帳號，進入遊玩

2. A帳號不擁有該遊戲

* 需要該遊戲乾淨檔案(無任何破解且非 Denuvo 加密)
[cs.ru檔案分享區](https://cs.rin.ru/forum/viewforum.php?f=22)
[cs.ru貼心整理下載區](https://cs.rin.ru/forum/viewtopic.php?f=10&t=95461)
* 使用 GL 開啟A帳號，進入遊玩

我會建議使用 1 方式搭配使用，因為其他人分享的檔案很多不包含中文語言檔，使用正版遊戲的帳號不僅可以更新遊戲到最新版本，且也可以預先下載語言檔案。

沒朋友建議使用方法：

1. 淘寶購買離線版帳號，下載完再使用 GL 使用自己的帳號開啟。
2. 買遊戲下載完退款。(不太建議這樣幹)

怕有疑慮也可以創一個新的 Steam 帳號專門使用 GL。

---

## 安裝 GL

### 分離式安裝(建議使用此方法)

1. 解壓縮到電腦任意地方
![](https://i.imgur.com/6WxBDLw.png)

2. 執行GreenLumaSettings_2023.exe
![](https://i.imgur.com/6sSEPT5.png)

3. 輸入 2 並填入 Steam 路徑，然後 enter

![](https://i.imgur.com/1nyDKm9.png)

4. 填入剛剛解壓縮 GL 的地方，並且 enter

![](https://i.imgur.com/KLKBoxU.png)

5. 完成後再 GL 資料夾新增 applist

![](https://i.imgur.com/umRBEnH.png)

6. 按照下面格式新增0~N的文字檔，內容為要解鎖的 AppID

![](https://i.imgur.com/AIXKTfi.png)

7. AppID 可以在 Steam 頁面的網址列上找到
![](https://i.imgur.com/SD5i4Tm.png)

8. 輸入完畢儲存即可(一個檔案僅能存在一個ID)
需要同時解鎖多個遊戲或 DLC 則需要往0後面依序新增
![](https://i.imgur.com/P1M5NMw.png)

---

### 直接安裝

1. 備份 steam\bin\x64launcher.exe

![備份launcher](https://i.imgur.com/2yS8X2x.png)

2. 將 NormalMode 資料夾的內容貼到 steam 資料夾覆蓋
(Win10可能判定為有毒，需自行斟酌暫時關閉防毒或新增排除)

![](https://i.imgur.com/aksKqRq.png)

3. 新增一個資料夾名稱為 applist

![](https://i.imgur.com/egf77gf.png)

4. 按照下面格式新增0~N的文字檔，內容為要解鎖的 AppID

![](https://i.imgur.com/BwuYoMK.png)

5. AppID 可以在 Steam 頁面的網址列上找到
![](https://i.imgur.com/SD5i4Tm.png)

6. 輸入完畢儲存即可(一個檔案僅能存在一個ID)
需要同時解鎖多個遊戲或 DLC 則需要往0後面依序新增
![](https://i.imgur.com/P1M5NMw.png)

---

## 提取 Ticket (非必要)

下載 [SteamLite](https://gofile.io/d/Um8mS2)
密碼:cs.rin.ru

1. 將所有檔案解壓縮到 steam 資料夾底下
2. 執行 SteamLite.exe
3. 使用方向鍵控制選擇第四個選項
![](https://i.imgur.com/9x9eH1A.png)
4. 輸入 steam 遊戲擁有者帳號
(該帳號需要本機 steam 登入過有記錄才行)
![](https://i.imgur.com/hN7m0VV.png)

5. 登入成功後選擇 14 並 enter
![](https://i.imgur.com/AJaloAi.png)

6. 輸入 2 enter

7. 輸入上方想要提取的 Ticket 遊戲ID

![](https://i.imgur.com/fj60J6D.png)

8. 輸入 3 enter

9. 輸入上方想要提取的 Ticket 遊戲ID

10. 完成提取，提取出的檔案會放在 steam 資料夾內自動讀取

---

## 使用 GL

1. 執行 DLLInjector.exe

2. 選擇是
  ![](https://i.imgur.com/IAkGQOV.png)

3. 如果遊戲有安裝且 applist 有正確輸入ID，可以在左側遊戲欄看到遊戲
  (有時候 steam 會更新，這時需要再重啟動一次才會正常讀取到)

沒有遊戲也可以正常開始遊玩
![](https://i.imgur.com/KaV3AXC.png)
