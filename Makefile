# need to compile aux, then recompile the desired format
aux:
	@latex cv.tex

dvi: aux
	@latex cv.tex

ps: aux dvi
	@dvi2ps -c cv.ps cv.dvi

pdf: aux
	@pdflatex cv.tex

clean:
	@rm -f *.aux *.dvi *.log *.out *.pdf *.ps
