FROM golang:1.17-alpine as build

WORKDIR /go/app

COPY build/app .

RUN go mod download

RUN go env -w CGO_ENABLED=0

RUN go build -o /go/bin/app

# RUN-STAGE
FROM gcr.io/distroless/static-debian11

COPY --from=build /go/bin/app .

EXPOSE 8080

CMD ["./app"]