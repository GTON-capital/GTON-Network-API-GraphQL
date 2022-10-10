FROM golang:latest

RUN mkdir /app
WORKDIR /app

COPY go.mod go.sum /app/
RUN go mod download && go mod verify

COPY cmd /app/cmd
COPY doc /app/doc
COPY geodb /app/geodb
COPY internal /app/internal
COPY Makefile /app

RUN make -C /app

COPY config.json /app

CMD ["/app/build/apiserver", "-cfg", "/app/config.json"]