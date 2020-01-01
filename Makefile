all: pdf

# need to compile aux, then recompile the desired format
aux: .latex
	@latex cv.tex

dvi: .latex aux
	@latex cv.tex

ps: dvi2ps aux dvi
	@dvi2ps -c cv.ps cv.dvi

pdf: pdflatex aux
	@pdflatex cv.tex

pdflatex: .latex

.latex:
	sudo add-apt-repository ppa:grand-edgemaster/texlive-backports
	sudo apt-get update
	sudo apt-get install texlive-full
	touch .latex

dvi2ps:
	sudo apt-get install dvi2ps

clean:
	@rm -f *.aux *.dvi *.log *.out *.pdf *.ps
