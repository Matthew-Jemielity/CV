# need to compile aux, then recompile the desired format
aux:
	latex cv.tex

dvi: aux
	latex cv.tex

pdf: aux
	pdflatex cv.tex

clean:
	@rm -f *.aux *.dvi *.log *.pdf
