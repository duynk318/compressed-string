FROM duynk318/alpine:3.9.5-golang AS build
WORKDIR /app
ADD . /app/
RUN CGO_ENABLED=1 GOOS=linux go build -o compressed-string

FROM alpine:3.9.5
WORKDIR /var/log/
RUN apk add --no-cache ca-certificates tzdata && cp /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
COPY --from=build /app/compressed-string /usr/bin/compressed-string
ENTRYPOINT [ "/usr/bin/compressed-string" ]
