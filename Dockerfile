FROM golang:1.17-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY src/*.go ./

RUN go build -o /poroscope-api

EXPOSE 8080

CMD ["/poroscope-api"]