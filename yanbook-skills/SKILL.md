---
name: "yanbook-skills"
description: "Yan Book LaTeX 书籍模板使用指南。用于创建高质量技术书籍、笔记和文档。包含丰富的自定义环境、代码高亮、数学公式支持和美观的视觉设计。"
---
# Yan Book LaTeX 模板使用指南

## 一、模板概述

Yan Book 是一个基于 LaTeX 的书籍/笔记模板，专为技术文档设计。它提供了丰富的自定义环境、美观的视觉设计和完善的编译流程。

### 1.1 项目结构

```
project/
├── main.tex                              # 第1层：书籍入口
├── yanbook.cls                           # 模板类文件
├── Makefile                              # 编译脚本
├── contents/
│   └── cover.tex                         # 封面
├── chapters/
│   ├── chapterhead/                      # 第2层：章节头文件集合
│   │   ├── ch01_basic_concepts.tex
│   │   ├── ch02_advanced_topics.tex
│   │   └── ...
│   ├── ch01_basic_concepts/              # 第3层：第1章内容
│   │   ├── sec01_introduction.tex
│   │   ├── sec02_fundamentals.tex
│   │   └── ...
│   ├── ch02_advanced_topics/             # 第3层：第2章内容
│   │   └── ...
├── assets/                               # 资源文件（图片等）
├── output/                               # 输出目录（PDF）
└── build/                                # 构建目录（中间文件）
```

### 1.2 模板特性

| 类别         | 特性                                            |
| ------------ | ----------------------------------------------- |
| **排版**     | 1.5倍行距、首段缩进、美观的章节样式             |
| **字体**     | Libertinus Serif/Math + LXGW WenKai 中文支持    |
| **颜色**     | Flat UI 配色方案，专业的视觉设计                |
| **盒子环境** | dfnbox, exbox, tecbox, genbox, notebox, algobox |
| **代码高亮** | Mac 风格代码块（浅色/深色）、算法盒子           |
| **数学支持** | 丰富的数学宏、定理环境、数学字体                |
| **编译流程** | Makefile 自动化编译，支持 BibTeX                |
| **其他**     | 封面设计、页眉页脚、目录、引用块                |

---

## 二、快速开始

### 2.1 编译命令

```bash
# 完整构建（含 BibTeX）
make build

# 生成 PDF 到 output 目录
make output

# 完整流程（构建 + 清理 + 输出）
make all

# 快速编译（不处理 BibTeX）
make xelatex

# 清理临时文件
make clean

# 清理所有文件（含 PDF）
make clean-all
```

### 2.2 主文件配置

```latex
\documentclass[math]{yanbook}

\usepackage{lipsum}
\usepackage{booktabs}
\usepackage{subcaption}
\usepackage{pgfplots}

% 封面配置（所有字段均可选）
\title{主标题}
\subtitle{副标题}
\author{作者名}
\institute{机构名称}
\instituteen{英文机构}
\version{v1.0}
\location{地点}
\coverabstract{封面摘要内容}
\date{\today}

\setcounter{tocdepth}{1}

\begin{document}
    \input{contents/cover}
    \tableofcontents
  
    % 正文部分 - 按顺序排列章节
    \chapter{第一章标题}
    \input{chapters/chapterhead/ch01_basic_concepts}
    
    \chapter{第二章标题}
    \input{chapters/chapterhead/ch02_advanced_topics}
    
    % ... 更多章节
\end{document}
```

### 2.3 封面字段配置

| 命令               | 用途           | 示例                            |
| ------------------ | -------------- | ------------------------------- |
| `\title{}`         | 主标题（必填） | `\title{朝花夕拾}`              |
| `\subtitle{}`      | 副标题         | `\subtitle{人工智能笔记}`       |
| `\author{}`        | 作者名（必填） | `\author{张三}`                 |
| `\institute{}`     | 机构名称       | `\institute{XX 大学}`           |
| `\instituteen{}`   | 英文机构       | `\instituteen{XX University}`   |
| `\version{}`       | 版本号         | `\version{v1.0}`                |
| `\location{}`      | 地点           | `\location{City, Country}`      |
| `\coverabstract{}` | 封面摘要       | `\coverabstract{本书介绍了...}` |
| `\date{}`          | 日期           | `\date{\today}`                 |

### 2.4 封面设计说明

封面采用左右分栏设计：

- **右侧面板**：渐变背景 + 竖排诗句装饰
- **左侧面板**：白底 + 标题、摘要、作者信息表格
- **装饰元素**：右上角几何图形装饰

所有封面内容通过上述配置命令动态生成，无需修改 `contents/cover.tex` 文件。

### 2.5 类选项

| 选项          | 说明                         |
| ------------- | ---------------------------- |
| `math`        | 启用数学宏和定理环境（推荐） |
| `code`        | 启用 minted 代码高亮         |
| `fastcompile` | 关闭部分特性加速编译         |

---

## 三、核心环境

### 3.0 盒子与非盒子编排原则

本模板同时提供**盒子环境**（带阴影和彩色边框的 tcolorbox）和**非盒子环境**（plain amsthm 样式）。合理混用二者可以显著提升阅读体验。

**核心原则：盒子只用于最重要的内容，次要内容使用非盒子环境。**

| 类别 | 使用场景 | 环境名称 |
|------|---------|---------|
| **盒子（重点突出）** | 核心定理、重要定义、关键技巧、需要视觉强调的内容 | `thmbox`, `dfnbox`, `exbox`, `tecbox`, `lembox` |
| **非盒子（常规内容）** | 一般性定理、辅助命题、简单推论、备注、普通定义 | `theorem`, `definition`, `proposition`, `corollary`, `remark`, `lemma`, `example` |

**判断标准：** 问自己"这个定理是否值得读者一眼看到？"——如果去掉盒子，读者需要花额外精力才能注意到它，那么它值得用盒子；如果它只是推导过程中的一个普通步骤，用非盒子即可。

**编排建议：**
- 盒子与非盒子交错排列，避免连续多个盒子造成视觉疲劳
- 盒子之间至少插入一段叙述性文字或一个非盒子环境
- 证明（`proof`）环境统一使用非盒子样式，即使定理本身用了盒子
- 一页中建议不超过 2-3 个盒子

### 3.1 定义环境 (dfnbox)

```latex
\begin{dfnbox}[标题]{标签}
    定义内容...
\end{dfnbox}

% 无编号版本（仅标题，无标签）
\begin{dfnbox*}{标题}
    定义内容...
\end{dfnbox*}
```

### 3.2 示例环境 (exbox)

```latex
\begin{exbox}[标题]{标签}
    示例内容...
\end{exbox}
```

### 3.3 技术环境 (tecbox)

```latex
\begin{tecbox}[标题]{标签}
    技术说明...
\end{tecbox}
```

### 3.4 定理环境 (thmbox)

需要启用 `math` 选项。

```latex
\begin{thmbox}[标题]{标签}
    定理内容...
\end{thmbox}

% 无编号版本
\begin{thmbox*}{标题}
    定理内容...
\end{thmbox*}
```

### 3.5 引理环境 (lembox)

需要启用 `math` 选项。

```latex
\begin{lembox}[标题]{标签}
    引理内容...
\end{lembox}

% 无编号版本
\begin{lembox*}{标题}
    引理内容...
\end{lembox*}
```

### 3.7 通用盒子 (genbox)

绿色主题的通用盒子，支持自动跨页。

```latex
\begin{genbox}{标题}
    内容...
\end{genbox}
```

**特点**：
- 绿色边框和标题栏
- 支持自动跨页（`breakable`）
- 可用于待办列表、要点总结等

### 3.8 笔记盒子 (notebox)

```latex
\begin{notebox}
    重要笔记内容...
\end{notebox}
```

### 3.9 算法盒子 (algobox)

标题会自动添加 `Algorithm:` 前缀。

```latex
\begin{algobox}{欧几里得算法}
    \begin{lstlisting}[language=Python]
    def hello():
        print("Hello World")
    \end{lstlisting}
\end{algobox}
```

输出效果：标题显示为 "Algorithm: 欧几里得算法"

### 3.10 对比环境 (comparison)

```latex
\begin{comparison}
    左侧内容
    \tcblower
    右侧内容
\end{comparison}
```

### 3.11 引用块 (epigraph)

```latex
\epigraph{引用内容}{作者}
```

---

## 四、代码块

### 4.1 Mac 风格浅色代码块

模拟 macOS 窗口风格的代码块，带有红黄绿三色按钮和文件名标题。

```latex
\begin{maccode}[Python]{文件名称.py}
def function():
    pass
\end{maccode}
```

**特点**：
- 圆角窗口边框 + 阴影效果
- 左上角红黄绿三色按钮
- 顶部标题栏显示文件名
- 支持自动跨页

### 4.2 Mac 风格深色代码块

深色主题的 Mac 风格代码块。

```latex
\begin{macdarkcode}[Python]{文件名称.py}
def function():
    pass
\end{macdarkcode}
```

### 4.3 Listings 代码块

基础的 Listings 代码块，带有边框和行号。

```latex
\begin{lstlisting}[language=Python]
def function():
    pass
\end{lstlisting}
```

**样式说明**：
- 圆角边框 + 浅灰色背景
- 左侧行号（等宽字体，灰色）
- 行号与代码间距 10pt
- 支持自动换行

### 4.4 代码样式说明

| 样式名称        | 用途                   | 边框 | 背景色 |
| --------------- | ---------------------- | ---- | ------ |
| `mystyle`       | 浅色 Listings 代码块   | 有   | 浅灰   |
| `darkstyle`     | 深色 Listings 代码块   | 有   | 深灰   |
| `maclightstyle` | Mac 浅色代码块内部使用 | 无   | 透明   |
| `macdarkstyle`  | Mac 深色代码块内部使用 | 无   | 透明   |

### 4.5 从文件读取代码

启用 `code` 选项后，可以使用 `\amzinputcode` 命令从文件读取代码：

```latex
\amzinputcode{python}{path/to/code.py}
```

### 4.6 代码高亮样式

| 元素   | 颜色   |
| ------ | ------ |
| 关键字 | 品红色 |
| 注释   | 绿色   |
| 字符串 | 紫色   |
| 数字   | 蓝色   |
| 行号   | 灰色   |

---

## 五、数学支持

### 5.1 数学字体

- **主字体**: Libertinus Math
- **支持**: Unicode 数学符号

### 5.2 数学宏

```latex
% 数字集合
\N  % 自然数
\Z  % 整数
\Q  % 有理数
\R  % 实数
\C  % 复数
\F  % 有限域

% 运算符
\abs{x}        % 绝对值
\norm{x}       % 范数
\ceil{x}       % 上取整
\floor{x}      % 下取整
\bigO{n}       % 大O符号

% 函数限制（在某点的取值）
\restrict{f}{x=0}  % f 在 x=0 处的值

% 对称差
A \symdiff B  % 集合 A 和 B 的对称差

% 生成代数
\alg{S}       % 由集合 S 生成的代数

% 数学算子
\laplace{f}   % Laplace 变换
\proj{u}{v}   % 向量 u 在 v 上的投影
\comp{A}{B}   % 集合 A 在 B 中的补集

% 微分（使用 derivative 宏包）
\frac{d}{dx}
```

### 5.3 定理环境（非盒子）

本模板提供两类定理环境：**盒子版**（`thmbox`, `lembox`，见第3.4-3.5节）和**非盒子版**（plain amsthm）。非盒子版适用于一般性定理、辅助命题和简单推论，视觉上更轻量。

```latex
% 支持可选标题和交叉引用标签
\begin{theorem}[标题]{标签}
    定理内容
\end{theorem}

\begin{lemma}[标题]{标签}
    引理内容
\end{lemma}

\begin{proposition}[标题]{标签}
    命题内容
\end{proposition}

\begin{corollary}[标题]{标签}
    推论内容
\end{corollary}

\begin{remark}[标题]{标签}
    备注内容
\end{remark}

\begin{example}[标题]{标签}
    示例内容
\end{example}

\begin{definition}[标题]{标签}
    定义内容
\end{definition}
```

**使用建议：**
- **`theorem`**：一般性定理，如"卷积的性质"、"弱收敛序列的有界性"
- **`proposition`**：辅助性命题，如"内积诱导的范数"、"正交补的性质"
- **`corollary`**：从主要定理直接推出的结论
- **`remark`**：补充说明、注意事项
- **`definition`**：普通定义（非核心概念）
- **`example`**：例证说明

**何时用盒子（`thmbox`）vs 非盒子（`theorem`）：**
- 核心基础定理 → 用 `thmbox`（如 Cauchy-Schwarz 不等式、正交投影定理）
- 推导过程中的辅助定理 → 用 `theorem`（如极化恒等式、Bessel 不等式）
- 判断标准：如果去掉盒子后读者仍能轻松定位该定理，则用非盒子即可

**交叉引用：** 所有环境均支持 `\label` 和 `\ref`，用法统一：
```latex
\begin{theorem}[标题]{thm:my_label}
    内容...
\end{theorem}
引用：\ref{thm:my_label}
```

---

## 六、章节组织

### 6.1 三层 Input 架构

本模板采用**三层 Input 结构**，实现内容与结构的完全解耦：

```
main.tex                              (第1层：书籍入口)
    │
    ├── \input{contents/cover}        (封面)
    ├── \tableofcontents               (目录)
    │
    ├── \chapter{第1章标题}            (章节声明)
    │   └── \input{chapters/chapterhead/ch01_xxx.tex}  (第2层：章节头)
    │           ├── \input{chapters/ch01_xxx/sec01_xxx.tex}  (第3层：小节)
    │           ├── \input{chapters/ch01_xxx/sec02_xxx.tex}
    │           └── ...
    │
    ├── \chapter{第2章标题}
    │   └── \input{chapters/chapterhead/ch02_xxx.tex}
    │           └── ...
    └── ...
```

### 6.2 各层职责说明

#### 第1层：main.tex（书籍入口）

**职责**:

- 文档类声明与选项配置
- 全局宏包加载
- 元信息设置（标题、作者、日期）
- 书籍整体结构编排
- 章节顺序控制

```latex
\documentclass[math]{yanbook}

% 全局宏包
\usepackage{booktabs}
\usepackage{pgfplots}

% 元信息
\title{书籍标题}
\author{作者名}
\date{\today}

\begin{document}
    % 前置部分
    \input{contents/cover}
    \tableofcontents
    
    % 正文部分 - 按顺序排列章节
    \chapter{第一章标题}
    \input{chapters/chapterhead/ch01_xxx}
    
    \chapter{第二章标题}
    \input{chapters/chapterhead/ch02_xxx}
    
    % ... 更多章节
\end{document}
```

**关键点**:

- `\chapter{}` 只定义章节标题，不包含内容
- 章节内容通过 `\input{章节头文件}` 引入
- 章节顺序由 `main.tex` 中的排列顺序决定
- 调整章节顺序只需移动两行代码

#### 第2层：章节头文件（chapterhead）

**目录**: `chapters/chapterhead/`

**命名规则**: `chXX_章节名.tex`

**职责**:

- 管理本章节的所有小节
- 控制小节的显示顺序
- 作为章节内容的"索引文件"

```latex
% chapters/chapterhead/ch01_basic_concepts.tex
\input{chapters/ch01_basic_concepts/sec01_introduction}
\input{chapters/ch01_basic_concepts/sec02_fundamentals}
\input{chapters/ch01_basic_concepts/sec03_key_definitions}
\input{chapters/ch01_basic_concepts/sec04_important_properties}
\input{chapters/ch01_basic_concepts/sec05_examples}
```

**为什么需要这一层？**

1. **解耦**: `main.tex` 不需要知道每个章节有多少小节
2. **易维护**: 添加/删除/重排小节只需修改章节头文件
3. **清晰**: 一眼就能看出章节包含哪些内容
4. **复用**: 同一章节可以被不同书籍引用

#### 第3层：小节文件（section）

**目录**: `chapters/chXX_章节名/`

**命名规则**: `secXX_小节名.tex`

**职责**:

- 单个小节的完整内容
- 包含标题、正文、公式、代码等

```latex
% chapters/ch01_basic_concepts/sec01_introduction.tex
\section{引言}

本章介绍本书的核心概念和基本框架，为后续章节奠定基础。

\subsection{研究背景}

随着技术的发展，相关领域的研究日益深入。

\subsection{本书贡献}

\begin{genbox}{主要贡献}
\begin{itemize}
    \item 提出了新的理论框架
    \item 提供了完整的实现方法
    \item 通过实验验证了有效性
\end{itemize}
\end{genbox}
```

**关键点**:

- 每个文件一个 `\section{}`
- 内部可以有 `\subsection{}`, `\subsubsection{}`
- 文件就是最小的内容单元

### 6.3 目录结构总览

```
project/
├── main.tex                              # 第1层：书籍入口
├── yanbook.cls                           # 模板类文件
├── Makefile                              # 编译脚本
│
├── contents/
│   └── cover.tex                         # 封面
│
└── chapters/
    ├── chapterhead/                      # 第2层：章节头文件集合
    │   ├── ch01_basic_concepts.tex
    │   ├── ch02_advanced_topics.tex
    │   ├── ch03_practical_applications.tex
    │   ├── ch04_case_studies.tex
    │   └── ...
    │
    ├── ch01_basic_concepts/              # 第3层：第1章内容
    │   ├── sec01_introduction.tex
    │   ├── sec02_fundamentals.tex
    │   ├── sec03_key_definitions.tex
    │   └── ...
    │
    ├── ch02_advanced_topics/             # 第3层：第2章内容
    │   ├── sec01_advanced_concepts.tex
    │   ├── sec02_implementation_details.tex
    │   └── ...
    │
    └── ...
```

### 6.4 编号约定

| 层级   | 前缀     | 示例                      | 说明             |
| ------ | -------- | ------------------------- | ---------------- |
| 章     | `chXX_`  | `ch01_`, `ch02_`          | 两位数，从01开始 |
| 节     | `secXX_` | `sec01_`, `sec02_`        | 两位数，从01开始 |
| 子目录 | -        | `ch01_core_environments/` | 与章节头同名     |

### 6.5 工作流程

**添加新章节的步骤**:

1. 创建章节目录
   ```
   chapters/chXX_new_chapter/
   ```

2. 创建小节文件
   ```
   chapters/chXX_new_chapter/sec01_introduction.tex
   chapters/chXX_new_chapter/sec02_core_content.tex
   chapters/chXX_new_chapter/sec03_examples.tex
   chapters/chXX_new_chapter/sec04_summary.tex
   ```

3. 创建章节头文件
   ```
   chapters/chapterhead/chXX_new_chapter.tex
   ```
   内容：
   ```latex
   \input{chapters/chXX_new_chapter/sec01_introduction}
   \input{chapters/chXX_new_chapter/sec02_core_content}
   \input{chapters/chXX_new_chapter/sec03_examples}
   \input{chapters/chXX_new_chapter/sec04_summary}
   ```

4. 在 `main.tex` 中添加章节
   ```latex
   \chapter{新章节标题}
   \input{chapters/chapterhead/chXX_new_chapter}
   ```

**重排小节的步骤**:

只需修改章节头文件中的顺序：

```latex
% 修改前
\input{chapters/chXX_topic/sec01_introduction}
\input{chapters/chXX_topic/sec02_fundamentals}
\input{chapters/chXX_topic/sec03_advanced}

% 修改后
\input{chapters/chXX_topic/sec03_advanced}
\input{chapters/chXX_topic/sec01_introduction}
\input{chapters/chXX_topic/sec02_fundamentals}
```

### 6.6 设计优势

| 优势         | 说明                         |
| ------------ | ---------------------------- |
| **模块化**   | 每个小节独立成文件，互不干扰 |
| **可维护**   | 修改单个小节不影响其他内容   |
| **可复用**   | 章节可以被多个项目引用       |
| **清晰**     | 目录结构直接反映书籍结构     |
| **协作友好** | 多人协作时减少文件冲突       |
| **Git友好**  | 小文件更容易进行版本对比     |
| **灵活重组** | 调整章节顺序只需改两行       |

---

## 七、封面设计

### 7.1 封面配置

封面文件位于 `contents/cover.tex`，包含：

- 左侧面板：书籍标题、副标题、作者信息
- 右侧面板：竖排装饰文字
- 装饰元素：圆形图案

### 7.2 自定义封面

```latex
\begin{titlepage}
    \newgeometry{margin=0pt}
    \thispagestyle{empty}
  
    \begin{tikzpicture}[remember picture, overlay]
        % 自定义背景
        \shade[left color=blue!80, right color=blue!40] 
            (current page.north west) rectangle (current page.south east);
      
        % 自定义内容
        \node[text=white, font=\Huge\bfseries] at (current page.center) {
            我的书籍
        };
    \end{tikzpicture}
    \restoregeometry
\end{titlepage}
```

---

## 八、颜色方案

### 8.1 预设颜色

| 颜色名称          | 用途                   |
| ----------------- | ---------------------- |
| `amzchaptercolor` | 章节标题、算法盒子边框 |
| `amzdfnboxcolor`  | 定义盒子边框           |
| `amzthmboxcolor`  | 定理盒子边框           |
| `amzexboxcolor`   | 示例盒子边框           |
| `amzgenboxcolor`  | 通用盒子边框           |
| `amztecboxcolor`  | 技术盒子边框           |
| `amzcodeboxcolor` | 代码盒子背景           |
| `amznoteboxcolor` | 笔记盒子左侧边框       |

### 8.2 自定义颜色

```latex
\definecolor{mycolor}{HTML}{123456}
```

---

## 九、页眉页脚

### 9.1 默认样式

- **左页眉**: 当前章节标题
- **右页眉**: 当前小节标题
- **页脚**: 页码 / 总页数

### 9.2 修改页眉页脚

```latex
\pagestyle{fancy}
\lhead{左侧内容}
\rhead{右侧内容}
\cfoot{页脚内容}
```

---

## 十、高级特性

### 10.1 全页背景

```latex
% 不透明度默认为 1（完全不透明）
\fullpagebg{background-image.png}

% 指定不透明度（0.5 表示半透明）
\fullpagebg[0.5]{background-image.png}
```

### 10.2 术语表

```latex
\nomenclature{符号}{说明}
\printnomenclature
```

### 10.3 待办事项

**推荐方式**：使用 `genbox` 环境创建内联待办列表，支持自动跨页。

```latex
\begin{genbox}{待办列表}
\begin{itemize}
    \item \textcolor{orange}{[ ]} 第一项待办内容
    \item \textcolor{orange}{[ ]} 第二项待办内容
    \item \textcolor{orange}{[ ]} 第三项待办内容
\end{itemize}
\end{genbox}
```

**边距注释方式**（适合少量简短待办）：

```latex
\todo{简短待办内容}
```

> **注意**：边距注释方式的待办事项显示在页面右侧边距中，内容过多时可能会超出页面。建议使用 `genbox` 方式创建待办列表。

### 10.4 目录深度

```latex
\setcounter{tocdepth}{2}  % 显示到 subsection
```

### 10.5 超链接

```latex
\href{url}{文字}
\ref{标签}
\pageref{标签}
```

### 10.6 文本宏

```latex
% 斜体加粗强调
\dfntxt{关键词}

% 带缩进的列表项（用于自定义列表）
\tabitem 列表内容
```

---

## 十一、编译注意事项

### 11.1 依赖环境

- **编译器**: XeLaTeX（推荐）
- **字体**: Libertinus Serif, Libertinus Math, LXGW WenKai
- **宏包**: tcolorbox, listings, fontspec, unicode-math, hyperref

### 11.2 常见问题

**问题1**: 中文显示异常

- 确保系统安装了 LXGW WenKai 字体
- 使用 XeLaTeX 编译器

**问题2**: 代码高亮不显示

- 添加 `code` 选项：`\documentclass[code]{yanbook}`
- 确保安装了 pygments

**问题3**: 数学符号缺失

- 确保启用了 `math` 选项
- 使用 Libertinus Math 字体

**问题4**: 盒子不能自动换页

- 所有盒子环境已默认启用 `breakable` 选项

**问题5**: 编译速度慢

- 使用 `fastcompile` 选项：`\documentclass[fastcompile]{yanbook}`

### 11.3 性能优化

```latex
% 快速编译模式
\documentclass[fastcompile]{yanbook}

% 使用 draft 模式（不编译图片）
\usepackage[draft]{graphicx}
```

---

## 十二、最佳实践

### 12.1 章节组织

1. 采用三层 Input 架构，实现内容与结构解耦
2. 每个小节独立成文件（如 `sec01_introduction.tex`）
3. 通过章节头文件（`chapterhead/`）管理小节顺序
4. 通过 `main.tex` 统一管理章节顺序

### 12.2 数学公式

1. 使用 `\[...\]` 显示公式
2. 使用 `$...$` 行内公式
3. 使用 `\text{}` 在公式中插入文字

### 12.3 代码风格

1. 使用 `maccode` / `macdarkcode` 环境
2. 代码块添加标题（文件名）
3. 保持代码缩进一致

### 12.4 内容结构（盒子与非盒子混排）

**推荐模式：** 叙述文字 → 非盒子定理/命题 → 证明 → 叙述文字 → 盒子核心定理 → 证明 → 叙述文字 → 非盒子推论/例子

```latex
\section{标题}

简介段落，介绍本节的主题和背景...

\begin{definition}[基本概念]{dfn:basic}
    普通定义内容（非盒子）
\end{definition}

进一步阐述，说明该定义的意义...

\begin{theorem}[辅助定理]{thm:helper}
    一般性定理（非盒子），用于为后续核心定理做铺垫
\end{theorem}

\begin{proof}
    证明过程...
\end{proof}

过渡段落，引出核心定理...

\begin{thmbox}[核心定理]{thm:main}
    最重要的定理（盒子），本节的核心结论
\end{thmbox}

\begin{proof}
    核心定理的详细证明...
\end{proof}

\begin{corollary}[重要推论]{cor:main_app}
    从核心定理推出的推论（非盒子）
\end{corollary}

\begin{example}[应用示例]{ex:main_app}
    展示定理的应用（非盒子）
\end{example}

\begin{remark}[注记]{rem:note}
    补充说明和注意事项（非盒子）
\end{remark}
```

**布局要点：**
- **盒子密度控制**：每节不超过 2-3 个盒子，仅用于最重要的结论
- **交错排列**：盒子之间至少有一个非盒子环境或一段叙述文字
- **证明保持非盒子**：无论定理是否用盒子，`proof` 环境始终使用非盒子样式
- **视觉层次**：叙述文字 → 非盒子 → 盒子，形成"轻→中→重"的视觉节奏

## 十三、模板扩展

### 13.1 添加新盒子环境

```latex
\newamzbox{newname}{标题}{标签}{颜色}[可选样式]
```

参数说明：
- `newname`: 环境名称
- `标题`: 环境显示标题（如 Definition、Theorem）
- `标签`: 引用标签前缀（用于 \ref）
- `颜色`: HTML 颜色代码或预定义颜色名
- `可选样式`: 可选的 tcolorbox 样式选项

示例：
```latex
\newamzbox{mybox}{My Box}{my}{blue!50}
```

### 13.2 自定义样式

在 `yanbook.cls` 中修改：

- 颜色定义
- 章节样式
- 盒子样式
- 字体设置

### 13.3 添加新章节

按照三层 Input 架构添加新章节：

1. 创建章节目录：`chapters/chXX_new_chapter/`
2. 创建小节文件：`chapters/chXX_new_chapter/sec01_xxx.tex`
3. 创建章节头文件：`chapters/chapterhead/chXX_new_chapter.tex`
4. 在 `main.tex` 中添加章节引用：
   ```latex
   \chapter{新章节标题}
   \input{chapters/chapterhead/chXX_new_chapter}
   ```

---

## 十四、示例文档

### 14.1 完整小节示例

```latex
\section{深度学习简介}

深度学习是机器学习的一个分支，使用多层神经网络进行特征学习。

\begin{dfnbox*}{深度神经网络}
\[
\mathbf{y} = f_L(f_{L-1}(\dots f_1(\mathbf{x}) \dots))
\]

其中 $f_i$ 是第 $i$ 层的非线性变换。
\end{dfnbox*}

\begin{genbox}{深度学习的特点}
\begin{itemize}
    \item \textbf{自动特征提取}: 无需人工设计特征
    \item \textbf{多层表示}: 从简单特征到复杂特征
    \item \textbf{大规模数据}: 需要大量标注数据
\end{itemize}
\end{genbox}

\begin{algobox}{神经网络前向传播}
\begin{lstlisting}[language=Python]
def forward(x, weights, biases):
    for w, b in zip(weights, biases):
        x = relu(x @ w + b)
    return softmax(x)
\end{lstlisting}
\end{algobox}

\begin{notebox}
注意：深度学习模型需要大量计算资源，通常使用 GPU 进行训练。
\end{notebox}
```

---

## 十五、参考资源

- **模板源码**: [yanbook.cls](../yanbook.cls)
- **主文件**: [main.tex](../main.tex)
- **Makefile**: [Makefile](../Makefile)
- **封面示例**: [cover.tex](../contents/cover.tex)

---

## 十六、更新日志

| 版本 | 日期       | 更新内容                                   |
| ---- | ---------- | ------------------------------------------ |
| 1.0  | 2025/12/23 | 初始版本                                   |
| 1.1  | -          | 添加 breakable 选项                        |
| 1.2  | -          | 添加 Mac 风格代码块                        |
| 1.3  | -          | 添加对比环境                               |
| 1.4  | -          | 添加 epigraph 引用块                       |
| 1.5  | -          | 采用三层 Input 架构组织章节                |
| 1.6  | -          | 优化 Listings 代码块行号位置和边框样式     |
| 1.7  | -          | genbox 支持自动跨页                        |
| 1.8  | -          | 新增 maclightstyle / macdarkstyle 专用样式 |
| 1.9  | 2026/07/12 | 新增盒子与非盒子编排原则；补充非盒子定理环境使用指南；重构内容结构示例 |

---

**使用建议**: 本模板特别适合编写技术书籍、学术笔记、课程讲义等需要大量数学公式和代码的文档。推荐配合 VS Code + LaTeX Workshop 使用，获得最佳编辑体验。
