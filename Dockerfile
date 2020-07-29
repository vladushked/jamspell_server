FROM ubuntu:latest

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y gcc build-essential cmake tar swig3.0 git

RUN git clone https://github.com/bakwc/JamSpell.git /jamspell
WORKDIR /jamspell
RUN mkdir build \
    && cd build \
    && cmake .. \
    && make

RUN git clone https://github.com/vladushked/jamspell_server.git /jamspell_server
WORKDIR /jamspell_server
RUN tar -xzf jamspell_ru_model.tar.gz

EXPOSE 8080
ENTRYPOINT "./web_server/web_server /jamspell_server/jamspell_ru_model/jamspell_ru_model.bin localhost 8080"

