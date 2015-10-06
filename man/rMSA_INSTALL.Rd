\name{rMSA_INSTALL}
\alias{rMSA_INSTALL}
\alias{rMSA_install}
\title{Installing Third-Party Software for rMSA}
\description{How to install third-party software for rMSA for Linux, OS X and
Windows.}
\section{Linux (Ubuntu/Debian)}{
Use the package manager to install packages:
\itemize{
\item clustal
\item kalign
\item mafft
\item muscle
\item boxshade (also needs package ghostscript)
}
}

\section{OS X}{
\itemize{
\item ClustalW: Install from \url{http://www.clustal.org/}.
\item Kalign: Install from \url{http://msa.sbc.su.se/cgi-bin/msa.cgi} by downloading
    and installing the source of Kalign (current).
\item MAFFT: Install from \url{http://mafft.cbrc.jp/alignment/software/}.
\item MUSCLE: Install from \url{http://www.drive5.com/muscle/}.
\item Boxshade is currenly not available for OS X (you can download it from
    \url{http://boxshade.sourceforge.net/} and compile it with the
    free pascal compiler and install ghostscript).
}
}

\section{Windows}{
\itemize{
\item ClustalW: Install from \url{http://www.clustal.org/}.
\item Kalign: Download \samp{kalign.exe} from
    \url{http://www.tcoffee.org/Packages/Binaries/windows/}.
\item MAFFT: Download \samp{mafft.exe} from
    \url{http://www.tcoffee.org/Packages/Binaries/windows/}.
\item MUSCLE: Install from \url{http://www.drive5.com/muscle/}.
\item Boxshade is currenly not available for Windows
}

Setting the PATH variable for Windows
\enumerate{
\item From the Desktop, right-click My Computer and click Properties.
\item  Click Advanced System Settings link in the left column.
\item  In the System Properties window click the Environment Variables button.
\item  Add the folder(s) with the executables to the PATH variable
	(separated by ;)
\item  Restart your R session.
\item  Try the following in R: \code{Sys.which("clustalw")}
	This should show you where it found the executable
}
}
%\keyword{model}
