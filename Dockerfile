FROM golang:alpine AS builder

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