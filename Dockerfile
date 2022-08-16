FROM golang:1.18.1-alpine as builder

ENV USER=appuser
ENV UID=10001

RUN apk update && apk add --no-cache git ca-certificates tzdata && update-ca-certificates

RUN mkdir -p /srv/caddy-me /srv/caddy-me/release
WORKDIR /srv/caddy-me
COPY . .
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags='-w -s -extldflags "-static"' -a \
        -o /srv/caddy-me/release/caddy-me

RUN adduser --disabled-password --gecos "" --home "/nonexistent" --shell "/sbin/nologin" --no-create-home  \
    --uid "${UID}" \
    "${USER}"

FROM scratch
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /srv/caddy-me/release /srv/caddy-me
USER appuser:appuser
WORKDIR /srv/caddy-me
EXPOSE 8080

ENTRYPOINT ["./caddy-me"]