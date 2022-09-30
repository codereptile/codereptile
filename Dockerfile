FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get install -y texlive-full
RUN apt-get install -y texlive-lang-cyrillic

CMD cd /resume && pdflatex ./resume_artem_ageev.tex
