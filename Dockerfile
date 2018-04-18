FROM alpine:3.6

ARG version
COPY build/goexpose-linux-amd64-$version /
COPY example /etc/goexpose
RUN ln -sf /goexpose-linux-amd64-$version /goexpose


ENTRYPOINT ["/goexpose", "-format", "yaml", "-config", "/etc/goexpose/config.yaml", "-logtostderr"]
