FROM golang:1.23

WORKDIR /app
COPY . .
RUN go mod tidy
RUN go build -o server .

ENV PORT=":3000"

ENTRYPOINT [ "/app/server" ]
