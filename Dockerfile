FROM golang:alpine@sha256:b6ed3fd0452c0e9bcdef5597f29cc1418f61672e9d3a2f55bf02e7222c014abd AS builder

ENV GO111MODULE=on

WORKDIR /app

# Removendo a versão específica do git que estava causando erro
RUN apk update && apk add --no-cache git

COPY go.mod go.sum ./
RUN go mod tidy

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/bin/aurora

FROM scratch
COPY --from=builder /app/bin/aurora .
CMD ["./aurora"]