#!/bin/bash
hexo clean && hexo g && hexo deploy
git add .
current_date_time=$(date "+%Y-%m-%d %H:%M:%S")
git commit -m "Update blog - $current_date_time"
git push origin main