FROM golang

WORKDIR /app
COPY . .

RUN echo "hello from docker"
RUN go mod tidy
RUN go build -o server .

ENV PORT=":3000"

ENTRYPOINT [ "/app/server" ]
