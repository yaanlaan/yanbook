---
name: "yanbook-template"
description: "Yan Book LaTeX 书籍模板使用指南。用于创建高质量技术书籍、笔记和文档。包含丰富的自定义环境、代码高亮、数学公式支持和美观的视觉设计。"
---

# Yan Book LaTeX 模板使用指南

## 一、模板概述

Yan Book 是一个基于 LaTeX 的书籍/笔记模板，专为技术文档设计。它提供了丰富的自定义环境、美观的视觉设计和完善的编译流程。

### 1.1 项目结构

```
ailearning/
├── main.tex                    # 主入口文件
├── yanbook.cls                 # 核心类文件（样式定义）
├── Makefile                    # 编译脚本
├── contents/
│   └── cover.tex              # 封面设计
├── chapters/
│   ├── chapterhead/            # 章节头文件（管理小节引用）
│   │   ├── ch01_xxx.tex
│   │   └── ...
│   ├── ch01_xxx/              # 章节内容目录
│   │   ├── sec01_xxx.tex
│   │   └── ...
│   └── ...
├── output/                    # 输出目录（PDF）
└── build/                     # 构建目录（中间文件）
```

### 1.2 模板特性

| 类别 | 特性 |
|------|------|
| **排版** | 1.5倍行距、首段缩进、美观的章节样式 |
| **字体** | Libertinus Serif/Math + LXGW WenKai 中文支持 |
| **颜色** | Flat UI 配色方案，专业的视觉设计 |
| **盒子环境** | dfnbox, exbox, tecbox, genbox, notebox, algobox |
| **代码高亮** | Mac 风格代码块（浅色/深色）、算法盒子 |
| **数学支持** | 丰富的数学宏、定理环境、数学字体 |
| **编译流程** | Makefile 自动化编译，支持 BibTeX |
| **其他** | 封面设计、页眉页脚、目录、引用块 |

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
\usepackage{float}

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
    
    \chapter{第一章标题}
    \input{chapters/chapterhead/ch01_xxx}
\end{document}
```

### 2.3 封面字段配置

| 命令 | 用途 | 示例 |
|------|------|------|
| `\title{}` | 主标题（必填） | `\title{朝花夕拾}` |
| `\subtitle{}` | 副标题 | `\subtitle{人工智能笔记}` |
| `\author{}` | 作者名（必填） | `\author{张三}` |
| `\institute{}` | 机构名称 | `\institute{安徽大学}` |
| `\instituteen{}` | 英文机构 | `\instituteen{Anhui University}` |
| `\version{}` | 版本号 | `\version{v1.0}` |
| `\location{}` | 地点 | `\location{Hefei, China}` |
| `\coverabstract{}` | 封面摘要 | `\coverabstract{本书介绍了...}` |
| `\date{}` | 日期 | `\date{\today}` |

### 2.4 封面设计说明

封面采用左右分栏设计：

- **右侧面板**：渐变背景 + 竖排诗句装饰
- **左侧面板**：白底 + 标题、摘要、作者信息表格
- **装饰元素**：右上角几何图形装饰

所有封面内容通过上述配置命令动态生成，无需修改 `contents/cover.tex` 文件。

### 2.5 类选项

| 选项 | 说明 |
|------|------|
| `math` | 启用数学宏和定理环境（推荐） |
| `code` | 启用 minted 代码高亮 |
| `fastcompile` | 关闭部分特性加速编译 |

---

## 三、核心环境

### 3.1 定义环境 (dfnbox)

```latex
\begin{dfnbox}{定义名称}{标签}
    定义内容...
\end{dfnbox}

% 无编号版本
\begin{dfnbox*}{定义名称}
    定义内容...
\end{dfnbox*}
```

### 3.2 示例环境 (exbox)

```latex
\begin{exbox}{示例名称}{标签}
    示例内容...
\end{exbox}
```

### 3.3 技术环境 (tecbox)

```latex
\begin{tecbox}{技术名称}{标签}
    技术说明...
\end{tecbox}
```

### 3.4 通用盒子 (genbox)

```latex
\begin{genbox}{标题}
    内容...
\end{genbox}
```

### 3.5 笔记盒子 (notebox)

```latex
\begin{notebox}
    重要笔记内容...
\end{notebox}
```

### 3.6 算法盒子 (algobox)

```latex
\begin{algobox}{算法名称}
    \begin{lstlisting}[language=Python]
    def hello():
        print("Hello World")
    \end{lstlisting}
\end{algobox}
```

### 3.7 对比环境 (comparison)

```latex
\begin{comparison}
    \begin{tcblower}
    左侧内容
    \end{tcblower}
    右侧内容
\end{comparison}
```

### 3.8 引用块 (epigraph)

```latex
\epigraph{引用内容}{作者}
```

---

## 四、代码块

### 4.1 Mac 风格浅色代码块

```latex
\begin{maccode}[Python]{文件名称.py}
def function():
    pass
\end{maccode}
```

### 4.2 Mac 风格深色代码块

```latex
\begin{macdarkcode}[Python]{文件名称.py}
def function():
    pass
\end{macdarkcode}
```

### 4.3 Listings 代码块

```latex
\begin{lstlisting}[language=Python, style=mystyle]
def function():
    pass
\end{lstlisting}
```

### 4.4 代码高亮样式

| 元素 | 颜色 |
|------|------|
| 关键字 | 品红色 |
| 注释 | 绿色 |
| 字符串 | 紫色 |
| 数字 | 蓝色 |
| 背景 | 浅灰色 |

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

% 运算符
\abs{x}        % 绝对值
\norm{x}       % 范数
\ceil{x}       % 上取整
\floor{x}      % 下取整
\bigO{n}       % 大O符号

% 微分
\frac{d}{dx}   % 使用 derivative 宏包
```

### 5.3 定理环境

```latex
\begin{theorem}
    定理内容
\end{theorem}

\begin{lemma}
    引理内容
\end{lemma}

\begin{proposition}
    命题内容
\end{proposition}

\begin{corollary}
    推论内容
\end{corollary}

\begin{remark}
    备注内容
\end{remark}
```

---

## 六、Input 结构与章节组织

### 6.1 三层 Input 架构

本模板采用**三层 Input 结构**，实现内容与结构的完全解耦：

```
main.tex                          (第1层：书籍入口)
    │
    ├── \input{contents/cover}    (封面)
    ├── \tableofcontents           (目录)
    │
    ├── \chapter{第1章标题}        (章节声明)
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

**文件**: [main.tex](file:///c:/code_workbench/tex_workspace/ailearning/main.tex)

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

**目录**: [chapterhead/](file:///c:/code_workbench/tex_workspace/ailearning/chapters/chapterhead/)

**命名规则**: `chXX_章节名.tex`

**职责**:
- 管理本章节的所有小节
- 控制小节的显示顺序
- 作为章节内容的"索引文件"

```latex
% chapters/chapterhead/ch01_linear_neural_networks.tex
\input{chapters/ch01_linear_neural_networks/sec01_linear_regression}
\input{chapters/ch01_linear_neural_networks/sec02_gradient_descent}
\input{chapters/ch01_linear_neural_networks/sec03_linear_classification}
\input{chapters/ch01_linear_neural_networks/sec04_perceptron}
\input{chapters/ch01_linear_neural_networks/sec05_multilayer_perceptron}
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
% chapters/ch01_linear_neural_networks/sec01_linear_regression.tex
\section{线性回归}

线性回归是最简单的监督学习模型，用于预测连续值。

\subsection{模型定义}

\begin{dfnbox*}{线性回归模型}
\[
y = \mathbf{w}^T \mathbf{x} + b
\]
\end{dfnbox*}

\subsection{损失函数}

均方误差（MSE）：
\[
\mathcal{L} = \frac{1}{n} \sum_{i=1}^{n} (y_i - \hat{y}_i)^2
\]
```

**关键点**:
- 每个文件一个 `\section{}`
- 内部可以有 `\subsection{}`, `\subsubsection{}`
- 文件就是最小的内容单元

### 6.3 目录结构总览

```
ailearning/
├── main.tex                          # 第1层：书籍入口
├── yanbook.cls                       # 模板类文件
│
├── contents/
│   └── cover.tex                     # 封面
│
└── chapters/
    ├── chapterhead/                  # 第2层：章节头文件集合
    │   ├── ch01_linear_neural_networks.tex
    │   ├── ch02_multilayer_perceptron_advanced.tex
    │   ├── ch03_reinforcement_learning.tex
    │   ├── ch04_modern_convolutional_neural_networks.tex
    │   └── ...
    │
    ├── ch01_linear_neural_networks/   # 第3层：第1章内容
    │   ├── sec01_linear_regression.tex
    │   ├── sec02_gradient_descent.tex
    │   ├── sec03_linear_classification.tex
    │   └── ...
    │
    ├── ch02_multilayer_perceptron_advanced/  # 第3层：第2章内容
    │   ├── sec01_multilayer_perceptron_advanced.tex
    │   ├── sec02_evolution_of_activation_functions.tex
    │   └── ...
    │
    └── ...
```

### 6.4 编号约定

| 层级 | 前缀 | 示例 | 说明 |
|------|------|------|------|
| 章 | `chXX_` | `ch01_`, `ch02_` | 两位数，从01开始 |
| 节 | `secXX_` | `sec01_`, `sec02_` | 两位数，从01开始 |
| 子目录 | - | `ch01_linear_neural_networks/` | 与章节头同名 |

### 6.5 工作流程

**添加新章节的步骤**:

1. 创建章节目录
   ```
   chapters/ch13_new_topic/
   ```

2. 创建小节文件
   ```
   chapters/ch13_new_topic/sec01_introduction.tex
   chapters/ch13_new_topic/sec02_basics.tex
   chapters/ch13_new_topic/sec03_advanced.tex
   ```

3. 创建章节头文件
   ```
   chapters/chapterhead/ch13_new_topic.tex
   ```
   内容：
   ```latex
   \input{chapters/ch13_new_topic/sec01_introduction}
   \input{chapters/ch13_new_topic/sec02_basics}
   \input{chapters/ch13_new_topic/sec03_advanced}
   ```

4. 在 `main.tex` 中添加章节
   ```latex
   \chapter{新主题}
   \input{chapters/chapterhead/ch13_new_topic}
   ```

**重排小节的步骤**:

只需修改章节头文件中的顺序：
```latex
% 修改前
\input{chapters/ch01/sec01_aaa}
\input{chapters/ch01/sec02_bbb}
\input{chapters/ch01/sec03_ccc}

% 修改后
\input{chapters/ch01/sec03_ccc}
\input{chapters/ch01/sec01_aaa}
\input{chapters/ch01/sec02_bbb}
```

### 6.6 设计优势

| 优势 | 说明 |
|------|------|
| **模块化** | 每个小节独立成文件，互不干扰 |
| **可维护** | 修改单个小节不影响其他内容 |
| **可复用** | 章节可以被多个项目引用 |
| **清晰** | 目录结构直接反映书籍结构 |
| **协作友好** | 多人协作时减少文件冲突 |
| **Git友好** | 小文件更容易进行版本对比 |
| **灵活重组** | 调整章节顺序只需改两行 |

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

| 颜色名称 | 用途 |
|----------|------|
| `amzchaptercolor` | 章节标题、算法盒子边框 |
| `amzdfnboxcolor` | 定义盒子边框 |
| `amzthmboxcolor` | 定理盒子边框 |
| `amzexboxcolor` | 示例盒子边框 |
| `amzgenboxcolor` | 通用盒子边框 |
| `amztecboxcolor` | 技术盒子边框 |
| `amzcodeboxcolor` | 代码盒子背景 |
| `amznoteboxcolor` | 笔记盒子左侧边框 |

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
\fullpagebg{background-image.png}
```

### 10.2 术语表

```latex
\nomenclature{符号}{说明}
\printnomenclature
```

### 10.3 待办事项

```latex
\todo{待办内容}
\todotext{内联待办}
```

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

1. 每个章节一个目录
2. 每个小节一个文件
3. 使用章节头文件统一管理引用

### 12.2 数学公式

1. 使用 `\[...\]` 显示公式
2. 使用 `$...$` 行内公式
3. 使用 `\text{}` 在公式中插入文字

### 12.3 代码风格

1. 使用 `maccode` / `macdarkcode` 环境
2. 代码块添加标题（文件名）
3. 保持代码缩进一致

### 12.4 内容结构

```latex
\section{标题}

简介段落...

\begin{dfnbox*}{核心定义}
    定义内容...
\end{dfnbox*}

数学推导...

\[
公式...
\]

\begin{genbox}{关键要点}
    \begin{itemize}
        \item 要点1
        \item 要点2
    \end{itemize}
\end{genbox}

\begin{algobox}{代码实现}
    \begin{lstlisting}[language=Python]
    代码...
    \end{lstlisting}
\end{algobox}
```

---

## 十三、模板扩展

### 13.1 添加新盒子环境

```latex
\newamzbox{newname}{标题}{标签}{颜色}
```

### 13.2 自定义样式

在 `yanbook.cls` 中修改：
- 颜色定义
- 章节样式
- 盒子样式
- 字体设置

### 13.3 添加新章节

1. 创建章节目录：`chapters/chXX_new_topic/`
2. 创建小节文件：`sec01_xxx.tex`
3. 创建章节头文件：`chapters/chapterhead/chXX_new_topic.tex`
4. 在 `main.tex` 中引用

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

- **模板源码**: [yanbook.cls](file:///c:/code_workbench/tex_workspace/ailearning/yanbook.cls)
- **主文件**: [main.tex](file:///c:/code_workbench/tex_workspace/ailearning/main.tex)
- **Makefile**: [Makefile](file:///c:/code_workbench/tex_workspace/ailearning/Makefile)
- **封面示例**: [cover.tex](file:///c:/code_workbench/tex_workspace/ailearning/contents/cover.tex)

---

## 十六、更新日志

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0 | 2025/12/23 | 初始版本 |
| 1.1 | - | 添加 breakable 选项 |
| 1.2 | - | 添加 Mac 风格代码块 |
| 1.3 | - | 添加对比环境 |
| 1.4 | - | 添加 epigraph 引用块 |

---

**使用建议**: 本模板特别适合编写技术书籍、学术笔记、课程讲义等需要大量数学公式和代码的文档。推荐配合 VS Code + LaTeX Workshop 使用，获得最佳编辑体验。