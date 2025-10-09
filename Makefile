# FundiWaEV Droidcon Presentation - Makefile

# Main file name (without extension)
MAIN = fundiwaev_droidcon

# Default build target
all: slides

# Build PDF using xelatex with minted highlighting
slides:
	xelatex -shell-escape $(MAIN).tex

# Clean up LaTeX build files
clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.fls *.fdb_latexmk *.synctex.gz

# Clean and rebuild from scratch
rebuild: clean slides

# View the PDF (Linux only)
view: slides
	xdg-open $(MAIN).pdf

