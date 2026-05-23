all: pdf

# need to compile aux, then recompile the desired format
aux: latex
	@echo "compiling latex"
	@latex cv.tex 2>&1 >> build.log

dvi: latex aux
	@echo "compiling dvi"
	@latex cv.tex 2>&1 >> build.log

ps: dvi2ps aux dvi
	@echo "compiling ps"
	@dvi2ps -c cv.ps cv.dvi 2>&1 >> build.log

pdf: pdflatex aux
	@echo "compiling pdf"
	@pdflatex cv.tex 2>&1 >> build.log

pdflatex: latex
	@echo "checking for pdflatex"
	@command -v pdflatex 2>&1 >> build.log

latex:
	@echo "checking for latex"
	@command -v latex 2>&1 >> build.log

dvi2ps:
	@echo "checking for dvi2ps"
	@command -v dvi2ps 2>&1 >> build.log

clean:
	@rm -f *.aux *.dvi *.log *.out *.pdf *.ps
