\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mattcv}[2015/04/10 Personal CV style]

%%%%%%%%%%
% basics %
%%%%%%%%%%

\renewcommand{\normalsize}{%
    \fontsize{10pt}{12pt}
    \selectfont
}
\setlength{\textwidth}{6.5in}
\setlength{\textheight}{8in}
\pagenumbering{arabic}

\DeclareOption*{
    \PassOptionToClass{\CurrentOption}{article}
}
\ProcessOptions\relax

\RequirePackage[
    a4paper,
    margin = 1cm,
    head = 4cm,
    headsep = 1cm,
    includehead
]{geometry}

%%%%%%%%%%
% colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}
\definecolor{lightgray}{RGB}{192,192,192}
\definecolor{gray}{RGB}{128,128,128}
\definecolor{darkgray}{RGB}{64,64,64}
\definecolor{black}{RGB}{0,0,0}

\definecolor{pastelred}{RGB}{205,155,155}
\definecolor{pastelgreen}{RGB}{143,188,143}
\definecolor{pastelblue}{RGB}{176,196,222}
\definecolor{pastelorange}{RGB}{227,168,105}
\definecolor{pastelpurple}{RGB}{147,112,219}

%%%%%%%%%%
% header %
%%%%%%%%%%

\RequirePackage{tikz}
\usetikzlibrary{positioning}
\RequirePackage{anyfontsize}

\newcommand{\cvheader}[3]{%
    \begin{tikzpicture}[remember picture,overlay]
        \fill [black]
            (current page.north west) rectangle (\paperwidth,\topmargin + \headheight);
        \path
            (current page.north east) -- (\paperwidth,\topmargin + \headheight)
            node (cv header east edge) [midway] {};
        \node (cv header text) [align=right, left=of cv header east edge] {%
                \textcolor{gray}{\fontsize{32}{0}\selectfont \MakeLowercase{#1 \textbf{#2}}}
                \\
                \textcolor{lightgray}{\fontsize{20}{0}\selectfont \MakeLowercase{#3}}
            };
    \end{tikzpicture}
}


