FROM golang:latest as builder
WORKDIR /go/src/
RUN git clone https://github.com/phantooom/tiny-http-demo.git
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/tiny-http-server /go/src/github.com/phantooom/tiny-http-demo/cmd/tiny-http-server

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/bin/tiny-http-server .
CMD ["./tiny-http-server"]

