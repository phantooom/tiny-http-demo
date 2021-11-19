FROM golang:latest as builder
WORKDIR /root
RUN git clone https://github.com/phantooom/tiny-http-demo.git
WORKDIR /root/tiny-http-demo
RUN pwd && ls && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o tiny-http-server /root/tiny-http-demo/cmd/tiny-http-server

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /root/tiny-http-demo/tiny-http-server .
CMD ["./tiny-http-server"]

