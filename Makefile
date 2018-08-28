FILE = doutorado

all :
	pdflatex $(FILE).tex
	makeindex $(FILE).nlo -s nomencl.ist -o $(FILE).nls
	biber $(FILE)
	pdflatex $(FILE).tex
	pdflatex $(FILE).tex
	make clean

draft:
	pdflatex -interaction=batchmode $(FILE).tex
	make clean

clean:
	rm -rf *.aux *.bbl *.toc *.out *.log *.nls *.nlo *.lof *.lot *.blg *.ilg
