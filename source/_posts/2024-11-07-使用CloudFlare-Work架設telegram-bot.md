---
title: 架設 Telegram Bot 的免費方案
date: 2024-11-07 21:20:20
tags:
  - [Tools]
categories:
  - [Tools]
---


使用 CloudFlare 免費提供的 Worker 服務作為 Telegram Bot 的 Server

<!-- more -->

![image.7sn87x1wid.webp](https://github.com/aliceric27/picx-images-hosting/raw/master/image.7sn87x1wid.webp)

------

## 登入/註冊 CloudFlare

到 [CloudFlare](https://dash.cloudflare.com/login) 登入/註冊

註冊後就會開通免費方案，可以開始使用

## 安裝node.js

到 [nodejs.org](https://nodejs.org/en) 下載對應版本安裝

確認是否安裝成功

```bash
node -v
```

## 建立wrangler專案

1. 擇一使用npm、pnpm、yarn安裝wrangler(官方推薦使用npm)

```bash
npm install wrangler
```

2. 使用wrangler建立專案

專案名稱可以隨意命名，會新增一個專案資料夾

```bash
npm create cloudflare@latest <你的專案名稱>
```

3. 到這邊記得選 `Template from a GitHub repo`

![image.39l740kpx2.webp](https://github.com/aliceric27/picx-images-hosting/raw/master/image.39l740kpx2.webp)

4. 貼上好心人開源的模板

```
https://github.com/m-sarabi/cloudflare-telegram-bot
```

5. 選擇TypeScript

6. 詢問是否使用 Git 選Yes

7. 最後會詢問是否要部屬，選No

![image.3uuuqbmo97.webp](https://github.com/aliceric27/picx-images-hosting/raw/master/image.3uuuqbmo97.webp)

到這邊專案就建立完成了

------

## 設定Telegram Bot

1. 到 [BotFather](https://t.me/botfather) 建立Bot

2. 輸入 `/newbot` 並按照指示操作

3. 記得Bot Token，等等會用到

------

## 專案環境設定

1. 找到 wrangler.toml 設定環境變數

- SECRET: 將 <SECRET> 替換為一個隨機的 token，以確保請求來自你設定的 webhook。
它可以是 1 到 256 個字串，包括 A-Z、a-z、0-9、_ 和 -。
- API_TOKEN: 將 <API_TOKEN> 替換為你 @BotFather 獲得的 API token。

解開註解，填入剛剛記得的Bot Token
SECRET 隨意填寫，TOKEN 填入剛剛記得的Bot Token


```toml
[vars]
SECRET = "tg-bot"
TOKEN = "<API_TOKEN>"
```

2. 保存後在終端機輸入

```bash
npm run cf-typegen
```
這個指令會重新生成 worker-configuration.d.ts 文件，反映你剛剛設定的變數。

## 修改專案

現在，讓我們進入有趣的部分——編寫機器人代碼！在這個例子中，我們將創建以下功能：

**情境**：當使用者發送 `/start` 指令時，機器人會顯示一條帶有按鈕的訊息。當按下按鈕後，機器人會移除該按鈕並回傳訊息。

### 處理 `/start` 指令

所有的更新處理函數都位於 `src/Telegram/handlers` 目錄中。

我們將從回應 `/start` 指令並發送一條訊息與內聯按鈕開始。請按如下方式修改 `src/Telegram/handlers/handleMessage.ts`：

```typescript
import { tg } from '../lib/methods';

export async function handleMessage(message: tgTypes.Message) {
    const messageText = message.text;
    const chatId = message.chat.id;
    if (messageText === '/start') {
        await tg.sendMessage({
            text: 'Welcome to my bot! Press the button to accept my rules!',
            chat_id: chatId,
            reply_markup: {
                inline_keyboard: [[{ text: 'I Accept', callback_data: 'accept_rules' }]]
            }
        });
    }
}
```

這段程式碼使用 `tg.sendMessage` 方法發送一條帶有內聯鍵盤按鈕的訊息。

### 處理內聯按鈕點擊

當使用者點擊內聯按鈕時，我們希望機器人能夠確認這個動作。請修改 `src/Telegram/handlers/handleCallbackQuery.ts`：

```typescript
import { tg } from '../lib/methods';

export async function handleCallbackQuery(callbackQuery: tgTypes.CallbackQuery) {
    const data = callbackQuery.data;
    const messageId = callbackQuery.message?.message_id;
    const chatId = callbackQuery.message?.chat.id;
    if (messageId && chatId) {
        if (data === 'accept_rules') {
            await tg.editMessageReplyMarkup({
                chat_id: chatId,
                message_id: messageId,
                reply_markup: undefined
            });
            await tg.sendMessage({
                chat_id: chatId,
                text: 'Thanks for accepting my rules.'
            });
        }
    }
}
```

這段程式碼會監聽 `accept_rules` 的數據查詢，並在匹配時移除內聯按鈕，然後使用 `tg.editMessageReplyMarkup` 方法發送一條跟進訊息。

### 🔗 註冊你的 Webhook

在設置好機器人的邏輯後，現在是部署 Worker 並通過 Webhook 連接到 Telegram 的時候了。

1. 執行 `npm wrangler deploy ` 或 `wrangler deploy` 來部署你的 Worker。
2. 前往你的 Cloudflare 控制台並選擇 Workers & Pages。

![image.4n7q82irf3.webp](https://github.com/aliceric27/picx-images-hosting/raw/master/image.4n7q82irf3.webp)

3. 在你的專案名稱旁邊，點擊 `造訪`。
4. 在 URL 連結後面添加 `/registerWebhook`（例如 `https://my-project.my-username.workers.dev/registerWebhook`）並按下 Enter。如果你看到 “Webhook registered”，表示你已正確完成設置！
5. 一旦部署並註冊完成，你可以在 Telegram 上與你的機器人互動。首先點擊 Start（或發送 `/start`），你應該會看到帶有內聯按鈕的歡迎訊息。



## 本機開發

如果要在本機開發機器人，建議使用 ngrok 來建立一個公開的 URL
因為 Telegram 需要 Webhook 的需求 URL 是 https 開頭的

1. 到 [ngrok](https://ngrok.com/) 註冊帳號

2. 取得 ngrok 的 authtoken

![image.70acpa5g8u.webp](https://github.com/aliceric27/picx-images-hosting/raw/master/image.70acpa5g8u.webp)

3. 到終端機輸入

```bash
ngrok config add-authtoken <your-authtoken>
```

4. 首先修改 `package.json`，添加開發腳本：

```json
{
  "scripts": {
    "dev": "wrangler dev --local",
    "tunnel": "ngrok http 8787"
  }
}
```
5. 修改 `src/index.ts` 中的 webhook 註冊邏輯：

```typescript
const isDev = url.hostname === 'localhost' || url.hostname.includes('ngrok');

if (url.pathname === REGISTER) {
    try {
        const webhookUrl = isDev 
            ? `https://${url.hostname}${WEBHOOK}`  // ngrok URL
            : `${url.protocol}//${url.hostname}${WEBHOOK}`; // production URL
            
        const result = await tg.setWebhook({
            url: webhookUrl,
            secret_token: env.SECRET,
        });
        if (result) return new Response('Webhook registered.');
        else return new Response('Failed to register webhook.');
    } catch (error) {
        return new Response(`Error: ${error}`);
    }
}
```

6. 開發流程：

這邊會需要開到兩個終端機

```bash
# 終端機 1：啟動 wrangler
npm run dev

# 終端機 2：啟動 ngrok
npm run tunnel
```

7. 到瀏覽器輸入 ngrok 提供的 URL 來註冊 webhook：

```
https://<ngrok-url>/registerWebhook
```



## 🔗 參考資源

- [Cloudflare Workers 文檔](https://developers.cloudflare.com/workers/)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [模板的 GitHub 倉庫](https://github.com/m-sarabi/cloudflare-telegram-bot)

