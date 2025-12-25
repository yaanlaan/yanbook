% ------------------------------------------------------------
% yanbook - Yan 书籍模板
% 基于 Alex M Zhang 的 amznotes

\ProvidesClass{yanbook}[2025/12/23 yanbook]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[12pt]{report}

% ------------------------------------------------------------
% 处理选项

\RequirePackage{kvoptions}
\DeclareBoolOption{math}        % 启用 thmbox 和数学宏
\DeclareBoolOption{code}        % 启用 codebox, amzcode, 和 \amzinputcode
\DeclareBoolOption{fastcompile} % 关闭部分特性以加快编译速度

\ProcessKeyvalOptions{yanbook}

% ------------------------------------------------------------
% 加载必要的宏包

\RequirePackage[margin=1in]{geometry}   % 设置页边距
\RequirePackage{fontspec}               % 设置主要字体
\RequirePackage{unicode-math}           % 设置数学字体; 替代 amssymb
\RequirePackage[dvipsnames]{xcolor}     % 漂亮的颜色
\RequirePackage{hyperref}               % PDF 阅读器中的超链接; 仅在 PDF 阅读器中显示下划线
\RequirePackage{fancyhdr}               % 花哨的页眉
\RequirePackage{lastpage}               % "X / Y" 页脚
\RequirePackage{parskip}                % 段落后换行且不缩进
\RequirePackage{setspace}               % 1.5 倍行距
\RequirePackage[explicit]{titlesec}     % 章节样式
\RequirePackage[most]{tcolorbox}        % 漂亮的盒子
\RequirePackage{ifthen}                 % 禁用未使用的索引条目
\RequirePackage{multicol}
\RequirePackage{enumitem}                           % 自定义列表间距
\RequirePackage{xfrac}                              % 小型分数
\RequirePackage[textsize=scriptsize]{todonotes}     % 待办事项注释
\RequirePackage{tabularx}
\RequirePackage[some]{background}
\RequirePackage{eso-pic}
\RequirePackage{tikz}
\usetikzlibrary{shadows, calc}

% 新特性宏包
\RequirePackage{epigraph}           % 章节引用
\RequirePackage{nomencl}            % 术语表/词汇表
\makenomenclature                   % 初始化术语表

\ifyanbook@math
    \RequirePackage{mathtools}          % 用于数学宏; 同时也加载 amsmath
    \RequirePackage{amsthm}
    \newcommand{\squoval}{\openbox}
    \renewcommand\qedsymbol{$\squoval$}
    \RequirePackage{derivative}
\fi

\ifyanbook@code
    \RequirePackage{minted}             % 代码语法高亮
    \tcbuselibrary{minted}
\fi

% ------------------------------------------------------------
% 字体

% 注意: 确保您的系统中安装了这些字体
% 使用标准 Windows 字体以保证兼容性
\setmainfont{Times New Roman}
\setmathfont{Cambria Math}
\setmonofont{Consolas}

% 中文支持
\RequirePackage{xeCJK}
\setCJKmainfont{SimSun}
\setCJKsansfont{SimHei}
\setCJKmonofont{FangSong}

% ------------------------------------------------------------
% 页面布局

\onehalfspacing
\renewcommand{\arraystretch}{1.25}

% ------------------------------------------------------------
% 颜色

% 调色板来自 https://flatuicolors.com/palette/us
\definecolor{amzchaptercolor}{HTML}{0984e3}
\definecolor{amzdfnboxcolor}{HTML}{0984e3}
\definecolor{amzthmboxcolor}{HTML}{6c5ce7}
\definecolor{amzexboxcolor}{HTML}{fdcb6e}
\definecolor{amzgenboxcolor}{HTML}{00b894}
\definecolor{amztecboxcolor}{HTML}{e17055}
\definecolor{amzcodeboxcolor}{HTML}{2d3436}
\definecolor{amznoteboxcolor}{HTML}{d63031}
% 新增封面颜色定义
\definecolor{yancovercolor}{HTML}{055796}

% ------------------------------------------------------------
% 链接

\hypersetup{
    colorlinks=false,
    linkbordercolor=black,
    urlbordercolor=blue,
    pdfborderstyle={/S/U/W 1}   % 下划线链接; 仅在 PDF 阅读器中显示, 打印时不显示
}

% ------------------------------------------------------------
% 章节样式

\ifyanbook@fastcompile
\else

\titleformat{\chapter}[display]
{\normalfont\huge\bfseries}
{}
{20pt}
{
    \begin{tcolorbox}[
        enhanced,
        left=23mm,
        right=25mm,
        top=2mm,
        spread sidewards,
        sharp corners,
        colback=amzchaptercolor,
        colframe=amzchaptercolor,
        boxrule=1mm,
        title=\thechapter,
        attach boxed title to top right={xshift=-15mm, yshift=-4mm},
        boxed title style={
            size=small,
            colback=amzchaptercolor,
            colframe=white
        }
    ]
        \strut \textcolor{white}{#1}
    \end{tcolorbox}
}

\titleformat{name=\chapter,numberless}[display]{\normalfont\huge\bfseries}
{}
{20pt}
{
    \begin{tcolorbox}[
        enhanced,
        left=23mm,
        right=25mm,
        top=2mm,
        spread sidewards,
        sharp corners,
        colback=amzchaptercolor,
        colframe=amzchaptercolor,
        boxrule=1mm,
    ]
        \strut \textcolor{white}{#1}
    \end{tcolorbox}
}

\titlespacing*{\chapter}{0pt}{-40mm}{-10mm}

\fi %\ifyanbook@fastcompile

% ------------------------------------------------------------
% 页眉样式

\ifyanbook@fastcompile
\else

\pagestyle{fancy}
\lhead{\footnotesize\nouppercase{\leftmark}}
\rhead{\footnotesize\nouppercase{\rightmark}}
\cfoot{\thepage\ of \pageref{LastPage}}

\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}
    \cfoot[C]{\thepage\ of \pageref{LastPage}}
}

\fi %\ifyanbook@fastcompile


% ------------------------------------------------------------
% 彩色盒子
\newcommand{\macbuttons}{%
    \begin{tikzpicture}[baseline=-3pt]
        \fill[red!60] (0,0) circle (3pt);
        \fill[yellow!60] (0.4,0) circle (3pt);
        \fill[green!60] (0.8,0) circle (3pt);
    \end{tikzpicture}%
}
\newcommand{\amzcolorboxtitlesep}{\ \raisebox{2.3pt}{\scalebox{0.5}{ $\blacktriangleright$}}}

\ifyanbook@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        fonttitle=\strut\bfseries,  % 支柱用于统一标题高度
        separator sign=\amzcolorboxtitlesep,
        breakable
    },
    genboxstyle/.style={
        amzdefaultstyle,
    },
    noteboxstyle/.style={breakable},
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=6mm]frame.north west);\end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray,
        before title={\macbuttons\enspace}
    },
}

\else %\ifyanbook@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        enhanced,
        drop fuzzy shadow,
        fonttitle=\strut\bfseries,  % 支柱用于统一标题高度
        boxrule=0pt,
        frame hidden,
        separator sign=\amzcolorboxtitlesep,
        % parbox=false,               % 正常段落间距
        breakable,
    },
    genboxstyle/.style={
        amzdefaultstyle,
        frame style={fill=amzgenboxcolor!85!black},
        interior style={fill=amzgenboxcolor!5!white},
        segmentation style={solid,draw=amzgenboxcolor!50!black,opacity=0.25,line width=1pt}
    },
    noteboxstyle/.style={
        enhanced,
        boxrule=0pt,
        frame hidden,
        borderline west={4pt}{0pt}{amznoteboxcolor},
        colback=amznoteboxcolor!7!white,
        sharp corners,
    },
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=6mm]frame.north west);\end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray,
        before title={\macbuttons\enspace}
    },
    comparisonstyle/.style={
        enhanced,
        breakable,
        sidebyside,
        sidebyside align=top,
        sidebyside gap=1cm,
        boxrule=0pt,
        frame hidden,
        colback=white,
        segmentation style={solid, amzchaptercolor, line width=1.5pt},
    }
}

\fi %\ifyanbook@fastcompile

% 对照环境
\newtcolorbox{comparison}[1][]{
    comparisonstyle,
    #1
}

% 给索引编号更多空间
\renewcommand{\l@tcolorbox}{\@dottedtocline{1}{0pt}{3em}}
\setlength{\columnsep}{3em}

\newcommand{\amzindex}{
    \addcontentsline{toc}{chapter}{Index}
    \chapter*{Index}

    % 移除索引页眉
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}

    \begin{multicols}{2}
        \amzindexbody
    \end{multicols}
}

\newcommand{\amzindexbody}{}

\newcommand{\addindexentry}[2]{%
    \appto\amzindexbody{
        \iftoggle{#2}{
            \tcblistof[\section*]{#2}{#1}
        }{}
    }
}

%\newamzbox{environment name}{title}{ref label}{color}[tcolorbox style]
\newcounter{amzboxcounter}
\NewDocumentCommand{\newamzbox}{m m m m O{}}{
    \newtcbtheorem[use counter=amzboxcounter,number within=section,list inside={#3}]{tc#1}{#2}{
        amzdefaultstyle,
        frame style={fill=#4!85!black},
        interior style={fill=#4!5!white},
        segmentation style={solid,draw=#4!50!black,opacity=0.25,line width=1pt},
        #5
    }{#3}

    \providetoggle{#3}
    \settoggle{#3}{false}

    \newenvironment{#1}[2][]{
        \global\settoggle{#3}{true}
        \begin{tc#1}{##1}{##2}
    }{
        \end{tc#1}
    }

    \newenvironment{#1*}[1]{
        \begin{tc#1*}{##1}
    }{
        \end{tc#1*}
    }

    \addindexentry{#2s}{#3}
}

\newamzbox{dfnbox}{Definition}{dfn}{amzdfnboxcolor}
\newamzbox{exbox}{Example}{ex}{amzexboxcolor}
\newamzbox{tecbox}{Technique}{tec}{amztecboxcolor}

\newtcolorbox{genbox}[1]{amzdefaultstyle, genboxstyle, title={#1}}
\newtcolorbox{notebox}{noteboxstyle}

\ifyanbook@math
    \newamzbox{lembox}{Lemma}{lem}{amzthmboxcolor}
    \newamzbox{thmbox}{Theorem}{thm}{amzthmboxcolor}
    
    \newtheorem{theorem}{Theorem}[section]
    \newtheorem{lemma}{Lemma}[section]
    \newtheorem{definition}{Definition}[section]
    \newtheorem{proposition}{Proposition}[section]
    \newtheorem{corollary}{Corollary}[section]
    \newtheorem{remark}{Remark}[section]
    \newtheorem{example}{Example}[section]
    \newtheorem{problem}{Problem}[section]
    \newtheorem{solution}{Solution}[section]
\fi

% ------------------------------------------------------------
% 算法与代码 (Mac 风格)

\RequirePackage{listings}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}

% 代码高亮颜色
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{codeblue}{rgb}{0.25,0.5,0.35}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}
\definecolor{darkback}{rgb}{0.15,0.16,0.18}
\definecolor{lightheader}{rgb}{0.9,0.9,0.9}
\definecolor{darkheader}{rgb}{0.25,0.26,0.28}

% Listings 样式
\lstdefinestyle{mystyle}{
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2
}

\lstdefinestyle{darkstyle}{
    style=mystyle,
    basicstyle=\ttfamily\footnotesize\color{white},
    keywordstyle=\color{cyan},
    commentstyle=\color{green!60!black},
    stringstyle=\color{yellow!80!black},
    numberstyle=\tiny\color{gray},
}

\lstset{style=mystyle}

% Mac 窗口 TColorBox 样式
\tcbset{
    macwindow/.style={
        enhanced,
        colframe=gray!80!black,
        boxrule=0.5pt,
        arc=6pt,
        fonttitle=\sffamily\bfseries\small,
        title={
            \begin{tikzpicture}[baseline=-3pt]
                \fill[red!60] (0,0) circle (3pt);
                \fill[yellow!60] (0.4,0) circle (3pt);
                \fill[green!60] (0.8,0) circle (3pt);
            \end{tikzpicture}
            \hspace{0.5em} #1
        },
        attach boxed title to top left={xshift=0mm, yshift=0mm},
        boxed title style={
            empty, 
            size=small, 
            top=3pt, 
            bottom=3pt,
            left=3pt,
            right=3pt
        },
        top=1.2em, % 标题栏空间
    }
}

% 浅色 Mac 代码块
\newtcblisting{maccode}[2][]{
    macwindow,
    colback=backcolour,
    coltitle=black,
    colframe=lightheader,
    title={#2},
    listing only,
    listing options={style=mystyle, language=#1},
}

% 深色 Mac 代码块
\newtcblisting{macdarkcode}[2][]{
    macwindow,
    colback=darkback,
    coltitle=white,
    colframe=darkheader,
    title={#2},
    listing only,
    listing options={style=darkstyle, language=#1},
}

% 算法盒子
\newtcolorbox{algobox}[1]{
    enhanced,
    colback=white,
    colframe=amzchaptercolor,
    fonttitle=\bfseries,
    title={Algorithm: #1},
    attach boxed title to top left={xshift=5mm, yshift=-2mm},
    boxed title style={colback=amzchaptercolor},
    sharp corners,
    boxrule=1pt,
    top=10pt
}

\ifyanbook@code
    \renewcommand{\theFancyVerbLine}{\ttfamily\scriptsize{\arabic{FancyVerbLine}}}


    \newamzbox{codebox}{Code Snippet}{code}{amzcodeboxcolor}[codeboxstyle]

    \newenvironment{amzcode}[2][]{
        \VerbatimEnvironment
        \begin{minted}[
        linenos,            % 显示行号
        breaklines,         % 允许换行
        autogobble,         % 折叠多余空白
        xleftmargin=3.75mm,
        ]{#2}}
    {\end{minted}}

    \newcommand{\amzinputcode}[2]{\inputminted[
        linenos,            % 显示行号
        breaklines,         % 允许换行
        autogobble,         % 折叠多余空白
        xleftmargin=3.75mm,
    ]{#1}{#2}}
\fi

% ------------------------------------------------------------
% 题词设置

% 重定义 \epigraph 使其看起来像 Markdown 引用块
\renewcommand{\epigraph}[2]{
    \begin{tcolorbox}[
        enhanced,
        boxrule=0pt,
        frame hidden,
        borderline west={4pt}{0pt}{gray!50},
        colback=gray!5!white,
        sharp corners,
        breakable,
        width=\textwidth,
        parbox=false,
        top=10pt,
        bottom=10pt,
        left=10pt,
        right=10pt
    ]
        \itshape #1
        \par\vspace{0.5em}
        \hfill --- \textsc{#2}
    \end{tcolorbox}
}

% ------------------------------------------------------------
% 全页背景

\newcommand{\fullpagebg}[2][1]{%
    \AddToShipoutPictureBG*{%
        \begin{tikzpicture}[remember picture, overlay]
            \node[opacity=#1, inner sep=0pt] at (current page.center) {
                \includegraphics[width=\paperwidth, height=\paperheight]{#2}
            };
        \end{tikzpicture}%
    }%
}

% ------------------------------------------------------------
% 文本宏

\newcommand{\dfntxt}[1]{\textit{\textbf{#1}}}

% from https://tex.stackexchange.com/a/150650
\newcommand{\tabitem}{~~\llap{\textbullet}~~}

% ------------------------------------------------------------
% 数学宏

\ifyanbook@math
    \newcommand{\rel}[1]{\mathrel{\mathcal{#1}}}

    \newcommand{\N}{\mathbb{N}}
    \newcommand{\Z}{\mathbb{Z}}
    \newcommand{\Q}{\mathbb{Q}}
    \newcommand{\R}{\mathbb{R}}
    \newcommand{\C}{\mathbb{C}}
    \newcommand{\F}{\mathbb{F}}

    \DeclareMathOperator{\laplace}{\mathscr{L}}
    \DeclareMathOperator{\proj}{proj}
    \DeclareMathOperator{\comp}{comp}
    \DeclareMathOperator{\TIME}{TIME}


    \newcommand{\id}{\text{id}}
    \newcommand{\bigO}{\mathcal{O}}
    \newcommand{\symdiff}{\bigtriangleup}

    \newcommand{\alg}[1]{{\left\langle {#1} \right\rangle}}

    \DeclarePairedDelimiter\abs{\lvert}{\rvert}    \DeclarePairedDelimiter\norm{\lVert}{\rVert}
    \DeclarePairedDelimiter\ceil{\lceil}{\rceil}
    \DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

    % 函数限制
    % From https://tex.stackexchange.com/a/22255
    \newcommand\restrict[2]{{
        \left.\kern-\nulldelimiterspace
        #1
        \vphantom{\big|}
        \right|_{#2}
    }}
\fi %\ifyanbook@math
