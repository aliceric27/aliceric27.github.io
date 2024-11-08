#!/bin/bash

# 獲取當前日期和時間
current_date_time=$(date "+%Y-%m-%d %H:%M:%S")

# 使用 sed 進行就地替換
# 對於 macOS 的 sed，我們需要給 -i 選項一個空的擴展名參數 ('')
# 對於 GNU sed（Linux），不需要額外的擴展名，所以這裡使用了一個條件判斷來兼容 macOS 和 Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/message: \"[^\"]*\"/message: \"Update blog - $current_date_time\"/" _config.yml
else
  sed -i "s/message: \"[^\"]*\"/message: \"Update blog - $current_date_time\"/" _config.yml
fi

# 清理、生成和部署網站
hexo clean && hexo g && hexo deploy

# 添加變更到 Git，提交和推送
git add .
git commit -m "Update blog - $current_date_time"
git push origin main