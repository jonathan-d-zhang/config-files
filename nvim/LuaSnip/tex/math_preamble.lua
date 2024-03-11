-- Abbreviations used in the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local conditions = require("luasnip.extras.expand_conditions")

local preamble = [=[
\documentclass[12pt]{article}

% For importing graphics
% \usepackage{graphicx}
% \graphicspath{{images/}}

%\usepackage{pgfplots}
%\pgfplotsset{compat=1.18}

%\usepackage{longtable}
%\usepackage{booktabs}

%\usepackage{siunitx}
%\DeclareSIUnit{\parsec}{pc}
%\DeclareSIUnit{\atmosphere}{atm}

% colors
% \usepackage[dvipsnames, svgnames, x11names]{xcolor}
% \usepackage{soul}

% Math symbols
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{physics}
\usepackage{mathtools}


\usepackage[colorlinks,allcolors=blue]{hyperref}
\usepackage[nameinlink,noabbrev]{cleveref}

% Augmented matrices. https://tex.stackexchange.com/a/2244
\makeatletter
\renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
    \hskip -\arraycolsep
    \let\@ifnextchar\new@ifnextchar
    \array{#1}}
\makeatother

% Plurals
\crefname{thm}{theorem}{theorems}
\crefname{defn}{definition}{definitions}
\crefname{lem}{lemma}{lemmas} % or 'lemmata'?
\crefname{cor}{corollary}{corollaries}
\crefname{conj}{conjecture}{conjectures}
\crefname{prop}{proposition}{propositions}

\renewcommand\qedsymbol{$\blacksquare$}

\theoremstyle{plain}
\newtheorem{thm}{Theorem}[section]
\newtheorem{lem}[thm]{Lemma}
\newtheorem{prop}[thm]{Proposition}
\newtheorem{cor}[thm]{Corollary}

\theoremstyle{definition}
\newtheorem{defn}{Definition}[section]
\newtheorem{exmp}{Example}[section]
\newtheorem{exer}{Exercise}
\newtheorem{ques}{Question}

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
\newcommand{\brbound}[1]{\left\{ #1 \right\}}

% Differential
\newcommand{\diff}{\ensuremath{\operatorname{d}\!}}

% vectors
\newcommand{\ihat}{\boldsymbol{\hat{\imath}}}
\newcommand{\jhat}{\boldsymbol{\hat{\jmath}}}
\newcommand{\khat}{\boldsymbol{\hat{k}}}

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

% Subfiles
\usepackage{subfiles}

\setlength{\parindent}{0pt}

\counterwithin{figure}{section}

\title{<>}
\author{Jonathan Zhang}

\begin{document}
\maketitle

<>

\end{document}
]=]

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
--[[
\usepackage{tikz}
\usetikzlibrary{automata}
\usetikzlibrary{positioning}
\usetikzlibrary{arrows.meta, arrows}
\tikzset{
    ->,
    >=stealth,
    every edge/.style={draw},
    bend angle=20,
    initial text=$ $,
}
--]]
