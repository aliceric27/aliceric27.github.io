#!/bin/bash
hexo clean && hexo g && hexo deploy
git add .
git commit -m "Update blog"
git push origin main