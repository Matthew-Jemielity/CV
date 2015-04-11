\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mattcv}[2015/04/10 Personal CV style]

%%%%%%%%%%
% basics %
%%%%%%%%%%

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
\newlength{\cvhead}
\setlength{\cvhead}{3.5cm}
\newlength{\cvmargin}
\setlength{\cvmargin}{0.5cm}

\RequirePackage[
    a4paper,
    margin = \cvmargin,
    top = \cvhead
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
        \tikzset{shift={(current page.north west)}, yshift=-\cvhead}
        \fill [black]
            (0,0) rectangle (\paperwidth,\cvhead);
        \path
            (\paperwidth,0) -- (\paperwidth,\cvhead)
            node (cv header east edge) [midway] {};
        \path
            (0,0) -- (0,\cvhead)
            node (cv header west edge) [midway] {};
        \node (cv header text) [align=right, left=of cv header east edge] {%
            \textcolor{gray}{\fontsize{#3}{0}\selectfont \MakeLowercase{#1 \textbf{#2}}}
            \\
            \textcolor{lightgray}{\fontsize{#5}{0}\selectfont \MakeLowercase{\textbf{#4}}}
        };
        \node (cv header pic background) [
            right=of cv header west edge,
            minimum height=0.95\cvhead,
            minimum width=0.95\cvhead
        ] {};
        \node (cv header pic) at (cv header pic background) [] {%
            \includegraphics[height=0.9\cvhead]{#6}
        };
        \fill [black, even odd rule]
            (cv header pic background) circle (0.33\cvhead)
            (cv header pic background.north west) rectangle (cv header pic background.south east);
    \end{tikzpicture}
}

% arguments:
% 1. section name
% 2. section color
% 3. date from
% 4. date to
% 5. formatted text
\newcommand{\cvtimeline}[5]{%
}

