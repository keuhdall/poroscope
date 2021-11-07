FROM haskell:8.10.7

WORKDIR /poroscope-api

COPY *.md ./
COPY stack.yaml ./
COPY package.yaml ./
COPY app/Main.hs ./app/
COPY src/*.hs ./src/
COPY test/*.hs ./test/

RUN apt-get update
RUN apt-get install -y python-dev
RUN apt-get install -y libpq-dev
RUN stack build
RUN stack install

EXPOSE 8080

CMD ["poroscope-exe"]