all: tex copy

tex:
	R CMD Sweave rMSA.Rnw
	texi2dvi --pdf rMSA.tex

copy:
	cp rMSA.pdf ../vignettes/rMSA_vignette.pdf
