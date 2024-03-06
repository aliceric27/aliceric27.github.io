#!/bin/bash
current_date_time=$(date "+%Y-%m-%d %H:%M:%S")
#sed -i "s/message: \"[^\"]*\"/message: \"Update blog - $current_date_time\"/" _config.yml
git status
git commit -m "Update blog - $current_date_time"
git push origin main
hexo clean && hexo g && hexo deploy