FROM golang:alpine AS builder

WORKDIR /build

COPY . .

RUN GOPROXY=https://goproxy.cn CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o ./bin/app .

FROM alpine

WORKDIR /build

COPY --from=builder /build/bin/app ./app

RUN chmod +x ./app

ENTRYPOINT ["./app"]