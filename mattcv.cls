\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mattcv}[2019/11/28 Personal CV style]

%%%%%%%%%%
% basics %
%%%%%%%%%%

\LoadClassWithOptions{article}

\renewcommand{\normalsize}{%
    \fontsize{10pt}{12pt}
    \selectfont
}
\pagenumbering{arabic}

\DeclareOption*{
    \PassOptionToClass{\CurrentOption}{article}
}
\ProcessOptions\relax

\RequirePackage{bbding}

\RequirePackage{calc}
\newlength{\cvhdr}
\setlength{\cvhdr}{48mm}
\newlength{\cvmargin}
\setlength{\cvmargin}{8mm}

\RequirePackage[
    a4paper,
    margin = \cvmargin,
    top = \cvhdr + \cvmargin
]{geometry}

\RequirePackage{enumitem}
\setlist{nosep, leftmargin=\cvmargin}

\RequirePackage{hyperref}

\def\basiceval#1{\the\numexpr#1\relax}

\RequirePackage{fp}
\def\calcLength(#1,#2)#3{%
  \pgfpointdiff{\pgfpointanchor{#1}{center}}%
  {\pgfpointanchor{#2}{center}}%
  \pgf@xa=\pgf@x%
  \pgf@ya=\pgf@y%
  \FPeval\@temp@a{\pgfmath@tonumber{\pgf@xa}}%
  \FPeval\@temp@b{\pgfmath@tonumber{\pgf@ya}}%
  \FPeval\@temp@sum{(\@temp@a*\@temp@a+\@temp@b*\@temp@b)}%
  \FProot{\FPMathLen}{\@temp@sum}{2}%
  \FPround\FPMathLen\FPMathLen5\relax
  \global\expandafter\edef\csname #3\endcsname{\FPMathLen}
}

%%%%%%%%%%
% colors %
%%%%%%%%%%

\RequirePackage[table]{xcolor}

\definecolor{header}{RGB}{42,52,57}
\definecolor{name}{RGB}{229,228,226}
\definecolor{job}{RGB}{192,192,192}
\definecolor{contact-info}{RGB}{192,192,192}

\definecolor{page}{RGB}{236,240,241}
\definecolor{section}{RGB}{250,250,250}
\definecolor{timeline}{RGB}{255,255,255}
\definecolor{title}{RGB}{236,240,241}

\RequirePackage{pagecolor}
\pagecolor{page}

%%%%%%%%%
% fonts %
%%%%%%%%%

\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}

%%%%%%%%%%
% header %
%%%%%%%%%%

\RequirePackage{anyfontsize}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{calc}

% arguments:
% 1. eps picture filepath
% 2. first name(s)
% 3. last name
% 4. job title
% 5. location
% 6. phone
% 7. email
% 8. website
\newcommand{\cvheader}[8]{%
  \begin{tikzpicture}[
    remember picture,
    overlay,
    node distance=0,
    outer sep=0
  ]
  \tikzset{shift={(current page.north west)}, yshift=-\cvhdr}
  \path
    (\paperwidth,0) -- (\paperwidth,\cvhdr)
        node (cv header east edge) [midway] {};
  \path
    (0,0) -- (0,\cvhdr)
      node (cv header west edge) [midway] {};
  \path
    (0,\cvhdr) -- (\paperwidth,\cvhdr)
      node (cv header south edge) [midway] {};
  \fill [header]
    (0,0) rectangle (\paperwidth,\cvhdr);
  \node (cv header pic background) [
    right=of cv header west edge,
    minimum height=0.99\cvhdr,
    minimum width=0.99\cvhdr
  ] {};
  \node (cv header pic) at (cv header pic background) [
    % no style
  ] {%
    \includegraphics[height=0.95\cvhdr]{#1}
  };
  \fill [header, even odd rule]
    (cv header pic background) circle (0.33\cvhdr)
    (cv header pic background.north west)
      rectangle
        (cv header pic background.south east);
  \node (cv header name anchor) [
    left=of cv header east edge,
    minimum width=1mm,
    minimum height=0.3\cvhdr
  ] {};
  \node (cv header job anchor) [
    below=of cv header name anchor,
    minimum width=1mm,
    minimum height=0.2\cvhdr
  ] {};
  \node (cv header contact anchor) [
    below=of cv header job anchor,
    minimum width=1mm,
    minimum height=0.1\cvhdr
  ] {};
  \node (cv header name) [
    align=flush right,
    left=of cv header name anchor,
    minimum width=0.75\paperwidth
  ] {%
    \resizebox {0.75\paperwidth}{!}{%
      \textcolor{name}{%
        \mbox{#2 \textbf{#3}}%
      }%
    }%
  };
  \node (cv header job) [
    align=flush right,
    left=of cv header job anchor,
    minimum width=0.25\paperwidth
  ] {%
    \resizebox {0.25\paperwidth}{!}{%
      \textcolor{job}{%
        \MakeLowercase{\textbf{#4}}%
      }%
    }%
  };
  \node (cv header contact) [
    align=flush right,
    left=of cv header contact anchor,
    minimum width=0.75\paperwidth
  ] {%
    \resizebox {0.75\paperwidth}{!}{%
      \textcolor{contact-info}{%
        \mbox{\FilledHut\hspace{1mm}#5}%
        \hspace{2mm}%
        \mbox{\Phone\hspace{1mm}#6}%
        \hspace{2mm}%
        \mbox{\Letter\hspace{1mm}#7}%
        \hspace{2mm}%
        \mbox{\href{#8}{#8}}%
      }%
    }%
  };
  \end{tikzpicture}
}

%%%%%%%%%%%%
% sections %
%%%%%%%%%%%%

\RequirePackage[most]{tcolorbox}

% arguments:
% 1. section title
% 2. section color
% 3. formatted text
\newcommand{\cvsection}[3]{%
  \begin{tcolorbox}[
    arc=0mm,
    colback=section,
    colframe=#2,
    coltitle=title,
    boxrule=0pt,
    title={\fontsize{14}{0}\selectfont\MakeLowercase{\textbf{#1}}},
    bottomtitle=1mm,
    toptitle=1mm,
    bottom=1mm,
    top=1mm
  ]
    #3
  \end{tcolorbox}
}

\tcbuselibrary{hooks}

% arguments:
% 1. section title
% 2. section color
% 3. date from
% 4. date to
% 5. formatted text
\newcommand{\cvtimeline}[5]{%
  \colorlet{darker-back}{#2!80!black}
  \begin{tcolorbox}[
    enhanced,
    arc=0mm,
    bicolor,
    colback=darker-back,
    colbacklower=timeline,
    colframe=#2,
    coltitle=title,
    colupper=title,
    boxrule=0pt,
    title={\fontsize{14}{0}\selectfont\textbf{#1}},
    bottomtitle=1mm,
    toptitle=1mm,
    bottom=1mm,
    top=1mm,
    sidebyside,
    left=4mm,
    right=4mm,
    lefthand width=12mm, % the timeline column (+ text width?)
    overlay={
      \begin{tcbclipinterior}
        \coordinate (arrow box north west) at (interior.north west);
        \coordinate
          [right=22mm]
            (arrow box north east) at (arrow box north west);
        \coordinate
          (arrow box north middle)
            at ($(arrow box north west)!0.5!(arrow box north east)$);
        \coordinate (arrow box south west) at (interior.south west);
        \coordinate
          [right=22mm]
            (arrow box south east) at (arrow box south west);
        \coordinate
          (arrow box south middle)
            at ($(arrow box south west)!0.5!(arrow box south east)$);
        \path
          (arrow box north west) -- (arrow box north east)
            node (arrow north edge) [] {};
        \path
          (arrow box south west) -- (arrow box south east)
            node (arrow south edge) [] {};
        \path
          (arrow box north west) -- (arrow box south west)
            node (arrow west edge) [] {};
        \path
          (arrow box north east) -- (arrow box south east)
            node (arrow east edge) [] {};
        \calcLength
          (arrow box north west,arrow box north east)
            {arrowboxwidth};
        \draw
          [
            color=#2,
            line width=\arrowboxwidth,
            {Triangle Cap[reversed,cap angle=140]}-{Triangle Cap [cap angle=140]}
          ]
          (arrow box south middle) -- (arrow box north middle);
      \end{tcbclipinterior}
    }
  ]
    \begin{tabular}{ c }
        \newline \\
        \fontsize{10}{0}\selectfont\textbf{#4} \\
        \newline \\
        \fontsize{10}{0}\selectfont\textbf{#3} \\
        \newline \\
    \end{tabular}
    \tcblower
    #5
  \end{tcolorbox}
}

