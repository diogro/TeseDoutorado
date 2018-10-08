FILE = doutorado

all :
	pdflatex $(FILE).tex
	makeindex $(FILE).nlo -s nomencl.ist -o $(FILE).nls
	biber $(FILE)
	pdflatex $(FILE).tex
	pdflatex $(FILE).tex
	make clean
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=main.pdf $(FILE).pdf
draft:
	pdflatex -interaction=batchmode $(FILE).tex
	make clean

clean:
	rm -rf *.aux *.bbl *.toc *.out *.log *.nls *.nlo *.lof *.lot *.blg *.ilg *.run.xml *.bcf
up:
	rsync -avz main.pdf lem.ib.usp.br:/usr/share/nginx/www/diogro/static
