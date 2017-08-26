\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mattcv}[2015/04/10 Personal CV style]

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

\RequirePackage{calc}
\newlength{\cvhdr}
\setlength{\cvhdr}{3cm}
\newlength{\cvmargin}
\setlength{\cvmargin}{4mm}

\RequirePackage[
    a4paper,
    margin = \cvmargin,
    top = \cvhdr + \cvmargin
]{geometry}

\RequirePackage{enumitem}
\setlist{nosep, leftmargin=\cvmargin}

%%%%%%%%%%
% colors %
%%%%%%%%%%

\RequirePackage[table]{xcolor}

\definecolor{header}{RGB}{44,44,44}
\definecolor{job}{RGB}{236,240,241}
\definecolor{name}{RGB}{189,195,199}
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

% arguments:
% 1. first name(s)
% 2. last name
% 3. names fontsize
% 4. job title
% 5. job title fontsize
% 6. eps picture filepath
\newcommand{\cvheader}[6]{%
    \begin{tikzpicture}[remember picture,overlay]
        \tikzset{shift={(current page.north west)}, yshift=-\cvhdr}
        \fill [header]
            (0,0) rectangle (\paperwidth,\cvhdr);
        \path
            (\paperwidth,0) -- (\paperwidth,\cvhdr)
            node (cv header east edge) [midway] {};
        \path
            (0,0) -- (0,\cvhdr)
            node (cv header west edge) [midway] {};
        \node (cv header text) [align=right, left=of cv header east edge] {%
            \textcolor{name}{\fontsize{#3}{0}\selectfont \MakeLowercase{#1 \textbf{#2}}}
            \\
            \textcolor{job}{\fontsize{#5}{0}\selectfont \MakeLowercase{\textbf{#4}}}
        };
        \node (cv header pic background) [
            right=of cv header west edge,
            minimum height=0.95\cvhdr,
            minimum width=0.95\cvhdr
        ] {};
        \node (cv header pic) at (cv header pic background) [] {%
            \includegraphics[height=0.9\cvhdr]{#6}
        };
        \fill [header, even odd rule]
            (cv header pic background) circle (0.33\cvhdr)
            (cv header pic background.north west) rectangle (cv header pic background.south east);
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
    \begin{tcolorbox}[
        arc=0mm,
        bicolor,
        colback=#2,
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
        lefthand width=12mm  % width of the timeline column
    ]
        \begin{tabular}{ c }
            \fontsize{10}{0}\selectfont\textbf{#4} \\
            \fontsize{12}{0}\selectfont\textbf{$\uparrow$} \\
            \fontsize{10}{0}\selectfont\textbf{#3} \\
        \end{tabular}
        \tcblower
        #5
    \end{tcolorbox}
}

