% Intro Options
\ProvidesClass{deedy-resume-openfont}[2014/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\RequirePackage[hmargin=1cm, vmargin=0.75cm]{geometry}
\RequirePackage[hidelinks]{hyperref}

% Publications
\RequirePackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
\RequirePackage[usenames,dvipsnames]{xcolor} 
\definecolor{date}{HTML}{666666} 
\definecolor{primary}{HTML}{2B2B2B} 
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}
\definecolor{contactbox}{HTML}{D5D5D5}

% Set main fonts
\RequirePackage{fontspec}
\setmainfont[Color=primary, Path = fonts/lato/,BoldItalicFont=Lato-RegIta,BoldFont=Lato-Reg,ItalicFont=Lato-LigIta]{Lato-Lig}
\setsansfont[Scale=MatchLowercase,Mapping=tex-text, Path = fonts/raleway/]{Raleway-ExtraLight}
\defaultfontfeatures{Ligatures=TeX}

% Include icon fonts for contact box
\newfontfamily{\FA}[Path=fonts/]{FontAwesome}
\input{fonts/fontawesomesymbols-xeluatex.tex}

% Name command
\newcommand{\namesection}[2]{
\centering{
\fontsize{40pt}{60pt}
\fontspec[Path = fonts/lato/]{Lato-Hai}\selectfont #1 
\fontspec[Path = fonts/lato/]{Lato-Lig}\selectfont #2
}
\noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.4pt}}
\vspace{-15pt}
}

% Section seperators 
\RequirePackage{titlesec}
\titlespacing{\section}{0pt}{0pt}{0pt} 
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\newcommand{\sectionsep}{\vspace{8pt}}

% Headings command
\titleformat{\section}{\color{headings}
\scshape\fontspec[Path = fonts/lato/]{Lato-Lig}\fontsize{16pt}{24pt}\selectfont \raggedright\uppercase}{}{0em}{}

% Subeadings command
\titleformat{\subsection}{
\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Bol}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{
\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Bol}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase {#1} \normalfont}

% Descriptors command
\newcommand{\descript}[2][]{
\color{subheadings}\raggedright\scshape\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{11pt}{13pt}\selectfont {#2}\ifstrempty{#1}{\\}{#1} \normalfont}

% Location command
\newcommand{\location}[1]{
\color{headings}\raggedright\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{10pt}{12pt}\selectfont {#1\\} \normalfont}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{
\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}
{\end{itemize}\vspace{-\topsep}}

% Command to specify name and location of where you worked/gave a presentation
\newcommand{\nameandloc}[2]{\runsubsection{#1}\location{| #2}}

% Command to specify title & date of a presentation or title & dates of a job
\newcommand{\titleandtime}[3]{\descript[\hfill]{#1}\ifstrempty{#3}{\location{#2}}{\location{#2 --- #3}}}

% Command to specify an educational degree
\newcommand{\degree}[5]{\subsection{#1}\descript{#3, #4}\location{#2 | #5}}

% The below was taken from Nicola Fontana's tccv LaTeX template and rejiggered slightly
% to work in this template: https://github.com/ntd/tccv
\RequirePackage{needspace,tabularx,etoolbox,pifont}
% Creates an unordered list of keys (optionals) and values (i.e. a
% description text) inside a colored box. See the `\personal` command
% for a real use case.
%
%     \begin{keyvaluelist}{color}
%         \item[key text] value text...
%         ...
%     \end{keyvaluelist}
\newcounter{KEYVALUECOUNTER}%
\newenvironment{keyvaluelist}[1]{%
	\newcommand\KEYVALUECOLOR{#1}%
	\renewcommand\item[1][]{%
		\stepcounter{KEYVALUECOUNTER}%
		\ifnumequal{\value{KEYVALUECOUNTER}}{1}{}{\smallskip\cr}%
		##1 & }%
	\newdimen\boxwidth\boxwidth=\dimexpr\linewidth-2\fboxsep\relax%
	% Tried to use \savebox and lrbox environment without success:
	% both fail complaining about some phantom } missing. I'm too
	% tired to guess what LaTeX wants... falling back to TeX here.
	\setbox0=\hbox\bgroup%
	\tabularx{0.95\boxwidth}{c|X}}
{\endtabularx\egroup\colorbox{\KEYVALUECOLOR}{\box0}%
	\setcounter{KEYVALUECOUNTER}{0}}

% Renders a personal data box:
%
%     \personal
%         {email}
%         {(opt) phone number}
%         {(opt) github name}
%         {(opt) linkedin url section - the part after linkedin.com/in/}
%         {(opt) website - no https:// prefix}
%         {(opt) street address}
\newcommand\personal[6]{%
	\newcommand\SYMBOL[1]{\raisebox{-2pt}{\Large\ding{##1}}}%
	\needspace{0.5\textheight}%
	\begin{keyvaluelist}{contactbox}
		\item[\large\faEnvelopeO] \href{mailto:#1}{#1}\vspace{-1.5\topsep} % Comment out vspace if your email isn't ridiculously long
		\ifstrempty{#2}{}{\item[\large\faPhone] \href{tel:#2}{#2}}
		\ifstrempty{#3}{}{\item[\Large\faGithubAlt] \href{https://github.com/#3}{#3}}
		\ifstrempty{#4}{}{\item[\large\faLinkedin] \href{https://www.linkedin.com/in/#4}{#4}}
		\ifstrempty{#5}{}{\item[\large\faDesktop] \href{https://#5}{#5}}
		\ifstrempty{#6}{}{\item[\large\faMapMarker] #6}
	\end{keyvaluelist}}
