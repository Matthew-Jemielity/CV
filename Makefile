all: cv.pdf

cv.pdf: cv.aux | pdflatex
	@echo "compiling $@"
	@pdflatex cv.tex 2>&1 >> build.log

# need to compile aux, then recompile the desired format
cv.aux: | latex
	@echo "compiling $@"
	@latex cv.tex 2>&1 >> build.log

cv.dvi: cv.aux | latex
	@echo "compiling $@"
	@latex cv.tex 2>&1 >> build.log

cv.ps: cv.dvi cv.aux | dvi2ps
	@echo "compiling $@"
	@dvi2ps -c cv.ps cv.dvi 2>&1 >> build.log

#always check for software
pdflatex: | latex
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
