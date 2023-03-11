---
title: hexo文檔
tags:
---

https://theme-next.iissnan.com/

[Hexo + NexT 的特殊標籤 | Miles' Blog (mileschou.me)](https://mileschou.me/blog/hexo-next-note-1/)

#### 使用方式

```html
{% note class_name %} Content (md partial supported) {% endnote %}
```

其中，`class_name` 可以是以下列表中的一个值：

{% raw %}{% endraw %}

{% note default %}內容{% endnote %}

{% note primary%}內容{% endnote %}

{% note success%}內容{% endnote %}

{% note info%}內容{% endnote %}

{% note warning%}內容{% endnote %}

{% note danger%}內容{% endnote %}

- `default`
- `primary`
- `success`
- `info`
- `warning`
- `danger`

#### 效果示例:

![image-20230220172419422](https://i.imgur.com/9LkC8J4.png)

## 文本居中的引用

此标签将生成一个带上下分割线的引用，同时引用内文本将自动居中。 文本居中时，多行文本若长度不等，视觉上会显得不对称，因此建议在引用单行文本的场景下使用。 例如作为文章开篇引用 或者 结束语之前的总结引用。

#### 使用方式

- HTML方式：使用这种方式时，给 `img` 添加属性 `class="blockquote-center"` 即可。
- 标签方式：使用 `centerquote` 或者 简写 `cq`。

此标签要求 NexT 的版本在 **0.4.5** 或以上。 若你正在使用的版本比较低，可以选择使用 `HTML` 方式。

 **标签调用方法**

```html
<!-- HTML方式: 直接在 Markdown 文件中编写 HTML 来调用 -->
<!-- 其中 class="blockquote-center" 是必须的 -->
<blockquote class="blockquote-center">blah blah blah</blockquote>

<!-- 标签 方式，要求版本在0.4.5或以上 -->
{% centerquote %}blah blah blah{% endcenterquote %}

<!-- 标签别名 -->
{% cq %} blah blah blah {% endcq %}
```
