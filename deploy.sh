#!/bin/bash
current_date_time=$(date "+%Y-%m-%d %H:%M:%S")
sed -i "s/message: \"[^\"]*\"/message: \"Update blog - $current_date_time\"/" _config.yml
hexo clean && hexo g && hexo deploy
git add .
git commit -m "Update blog - $current_date_time"
git push origin main