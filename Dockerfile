FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update                                  \
    && apt-get install -y texlive-latex-base        \
                          texlive-fonts-recommended \
                          texlive-fonts-extra       \
                          texlive-latex-extra       \
                          texlive-bibtex-extra      \
                          biber

CMD pdflatex                                        \
    -interaction=nonstopmode                        \
    -halt-on-error                                  \
    -output-directory /resume                       \
    /resume/resume_artem_ageev.tex

