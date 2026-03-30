![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![LaTeX](https://img.shields.io/badge/language-LaTeX-orange)

# Yanbook

## 简介

一个LaTeX书籍模板，受 [amznotes](https://github.com/alexmingzhang/latex-notes-template)风格启发

中文字体使用[LXGW WenKai](https://github.com/lxgw/LxgwWenKai)，英文和数学字体使用[libertinus](https://github.com/alerque/libertinus)，请你自行下载并安装

## 预览

![](assets/page_1.png)
![](assets/page_2.png)
![](assets/page_3.png)
![](assets/page_4.png)
![](assets/page_5.png)
![](assets/page_6.png)
![](assets/page_7.png)
![](assets/page_8.png)
![](assets/page_9.png)
![](assets/page_10.png)
![](assets/page_11.png)
![](assets/page_12.png)
![](assets/page_13.png)
![](assets/page_14.png)


## Tips
### 一些用法提示

- 标题为中文副标题为英文会有一些视觉上的不对齐问题，[查看 cover.tex 第 31 行](contents/cover.tex#L31)
- box的用法和对应ref的用法[查看 yanbook.cls 第 323 行](yanbook.cls#323)
- 公式字体

### 一些ai技巧
建议这样组织文件，便于分章节编译查看（这是我经常给ai的要求）

prompt：我希望在chapters下创建chapter_heads文件夹，放入各个章节的章节引入头文件，章节引入头文件里的内容是引入章节的各个section文件，一个章节一个章节引入头文件；
各个章节被放在chapters文件夹下对应名称的文件夹下，文件夹内是按照section组织的，一个section是一个tex文件；
充分理解yanbook.cls的风格和语法；
你能理解这些要求吗？

通过注释/input{...}、目录、封面等，就可以只编译某一个部分，实现局部调节。最后你就可以以某某身份自居让ai生成粗略的大纲了。
