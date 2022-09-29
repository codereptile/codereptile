\DeclareOption{academicons}{\@academiconstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome}

\RequirePackage{xcolor}

\definecolor{Greenish}{HTML}{015848}
\definecolor{SlateGrey}{HTML}{2E2E2E}
\definecolor{LightGrey}{HTML}{444444}
\definecolor{LightBlue}{HTML}{01415f}
\colorlet{heading}{SlateGrey}
\colorlet{accent}{LightBlue}
\colorlet{emphasis}{Greenish}
\colorlet{body}{LightGrey}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
% \RequirePackage{marginfix}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}


\newcommand{\printinfo}[2]{\mbox{\textcolor{accent}{#1}\hspace{0.5em}#2\hspace{2em}}}

\newcommand{\email}[1]{\printinfo{\faAt}{#1}}
\newcommand{\phone}[1]{\printinfo{\faPhone}{#1}}
\newcommand{\location}[1]{\printinfo{\faMapMarker}{#1}}
\newcommand{\youtube}[1]{\printinfo{\faYoutube}{#1}}
\newcommand{\github}[1]{\printinfo{\faGithub}{#1}}
\newcommand{\vk}[1]{\printinfo{\faVk}{#1}}


\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}


\newcommand{\makecvheader}{%
	\begingroup
		\ifdef{\@photodiameter}{
			\begin{minipage}{\dimexpr\linewidth - \@photodiameter - 2em}
		}{}%
		\raggedright\color{black}%
		{\Huge\bfseries\MakeUppercase{\@name}\par}\color{emphasis}
		\medskip
		{\large\bfseries\color{accent}\@tagline\par}
		\medskip
		{\footnotesize\bfseries\@personalinfo\par}
		\ifdef{\@photodiameter}{
			\end{minipage}\hfill
			\begin{minipage}{\@photodiameter}
				\tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
			\end{minipage}
		}{}
	\endgroup\medskip
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvsection}[2][]{%
	\bigskip%
	\ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}% 
	{\color{heading}\LARGE\bfseries\MakeUppercase{#2}}\\[-1ex]%
	{\color{heading}\rule{\linewidth}{2pt}\par}\medskip
}

\newcommand{\cvsubsection}[1]{%
	\smallskip%
	{\color{emphasis}\large\bfseries{#1}\par}\medskip
}

\newcommand{\cvevent}[4]{%
	{\large\color{emphasis}#1\par}
	\smallskip
	\textbf{\color{accent}#2}\par
	\smallskip
	{\small\makebox[0.5\linewidth][l]{\faCalendar \hspace{0.5em}#3}%
		\ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}#4}}\par}
	\medskip
}

\newcommand{\cveventlight}[3]{%
	{\large\color{emphasis}#1\par}
	\smallskip
	\textbf{\color{accent}#2}\par
	\smallskip
	#3
	\medskip
}

\newcommand{\cvachievement}[3]{%
	\begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
		\multirow{2}{*}{\Large\color{accent}#1} & \bfseries\textcolor{emphasis}{#2}\\
		& #3
	\end{tabularx}%
	\smallskip
}

\newcommand{\cvtag}[1]{%
	\tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{\textcolor{accent}{#1}};
}

\newcommand{\cvskill}[2]{%
	\textcolor{emphasis}{\textbf{#1}}\hfill
	\foreach \x in {1,...,5}{%
		\space{\ifnumgreater{\x}{#2}{\color{body!30}}{\color{accent}}\faCircle}}\par%
}

% Adapted from @Jake's answer at http://tex.stackexchange.com/a/82729/226
\newcommand{\wheelchart}[3]{%
	\begingroup\centering
	\def\innerradius{#2}%
	\def\outerradius{#1}%
	% Calculate total
	\pgfmathsetmacro{\totalnum}{0}%
	\foreach \value/\colour/\name in {#3} {%
		\pgfmathparse{\value+\totalnum}%
		\global\let\totalnum=\pgfmathresult%
	}%
	\begin{tikzpicture}
		
		% Calculate the thickness and the middle line of the wheel
		\pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
		\pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
		
		% Rotate so we start from the top
		\begin{scope}[rotate=-90]
			
			% Loop through each value set. \cumnum keeps track of where we are in the wheel
			\pgfmathsetmacro{\cumnum}{0}
			\foreach \value/\width/\colour/\name in {#3} {
				\pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}
				
				% Calculate the percent value
				\pgfmathsetmacro{\percentage}{\value/\totalnum*100}
				% Calculate the mid angle of the colour segments to place the labels
				\pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}
				
				% This is necessary for the labels to align nicely
				\pgfmathparse{
					(-\midangle>180?"west":"east")
				} \edef\textanchor{\pgfmathresult}
				\pgfmathparse{
					(-\midangle>180?"flush left":"flush right")
				} \edef\textalign{\pgfmathresult}
				\pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}
				
				% Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
				\filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
				(-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;
				
				% Draw the data labels
				\draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\name};
				% Set the old cumulated angle to the new value
				\global\let\cumnum=\newcumnum
			}
		\end{scope}
		%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
	\end{tikzpicture}\par
	\endgroup
}

\newcommand{\cvref}[3]{%
	\smallskip
	\textcolor{emphasis}{\textbf{#1}}\par
	\begin{description}[font=\color{accent},style=multiline,leftmargin=1.25em]
		\item[\faAt] #2
		\item[\small\mailsymbol] #3
	\end{description}
	%   \medskip
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}

\RequirePackage[backend=biber,style=authoryear,sorting=ydnt]{biblatex}
\defbibheading{pubtype}{\cvsubsection{#1}}
\renewcommand{\bibsetup}{\vspace*{-\baselineskip}}
\AtEveryBibitem{\makebox[\bibhang][l]{\itemmarker}}
\setlength{\bibitemsep}{0.25\baselineskip}

\AtBeginDocument{%
	\pagestyle{empty}
	\color{body}
	\raggedright
}
