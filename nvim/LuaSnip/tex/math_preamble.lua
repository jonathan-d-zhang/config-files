-- Abbreviations used in the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local conditions = require("luasnip.extras.expand_conditions")

local preamble = [[\documentclass[12pt]{article}

% For importing graphics
% \usepackage{graphicx}
% \graphicspath{{images/}}

%\usepackage{pgfplots}
%\pgfplotsset{compat=1.18}

%\usepackage{longtable}
%\usepackage{booktabs}

%\usepackage{siunitx}
%\DeclareSIUnit{\parsec}{pc}
%\DeclareSIUnit{\arcsec}{as}
%\DeclareSIUnit{\atmosphere}{atm}

% colors
% \usepackage[dvipsnames, svgnames, x11names]{xcolor}
% \usepackage{soul}

% Math symbols
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}

\renewcommand\qedsymbol{$\blacksquare$}

\theoremstyle{plain}
\newtheorem{thm}{Theorem}[section]
\newtheorem{lem}[thm]{Lemma}
\newtheorem{prop}[thm]{Proposition}
\newtheorem{cor}[thm]{Corollary}

\theoremstyle{definition}
\newtheorem{defn}{Definition}[section]
\newtheorem{exmp}{Example}[section]
\newtheorem{exer}[exmp]{Exercise}

\theoremstyle{remark}
\newtheorem*{rem}{Remark}
\newtheorem*{note}{Note}
\newtheorem*{notation}{Notation}
\newtheorem{case}{Case}

% Date labels
\newcommand{\dsection}[2]{\section{#1 \hfill \normalfont{\small{\textit{#2}}}}}

% Fancy lists
\usepackage[shortlabels]{enumitem}

% Makes delimiters always resizable.
\newcommand{\pbound}[1]{\left( #1 \right)}
\newcommand{\bbound}[1]{\left[ #1 \right]}

% d/dx
\newcommand{\dv}[1]{\frac{\textrm{d}}{\textrm{d} #1}}

% vectors
\newcommand{\ihat}{\boldsymbol{\hat{\textbf{\i}}}}
\newcommand{\jhat}{\boldsymbol{\hat{\textbf{\j}}}}

% mean
\newcommand*\mean[1]{\bar{#1}}

% Referencing External Documents
% \usepackage{xr}
% \makeatletter
% \newcommand*{\addFileDependency}[1]{
%   \typeout{(#1)}
%   \@addtofilelist{#1}
%   \IfFileExists{#1}{}{\typeout{No file #1.}}
% }
% \makeatother
% \newcommand*{\myexternaldocument}[1]{
%     \externaldocument{#1}
%     \addFileDependency{#1.tex}
%     \addFileDependency{#1.aux}
% }
% \myexternaldocument{}

\setlength{\parindent}{0pt}

\counterwithin{figure}{section}

\title{<>}
\author{Jonathan Zhang}

\begin{document}
\maketitle

<>

\end{document}
]]

return {

s(
    "mpre",
    fmta(preamble, {
        i(1),
        i(0),
    }),
    { condition = conditions.line_begin }
)

}
