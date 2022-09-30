FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get install -y texlive-full
RUN apt-get install -y texlive-lang-cyrillic

CMD pdflatex                                        \
    -interaction=nonstopmode                        \
    -halt-on-error                                  \
    -output-directory /resume                       \
    /resume/resume_artem_ageev.tex

