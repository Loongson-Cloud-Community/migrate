FROM cr.loongnix.cn/library/golang:1.19-alpine AS builder

ARG VERSION

RUN apk add --no-cache git gcc musl-dev make

WORKDIR /go/src/github.com/golang-migrate/migrate

ENV GO111MODULE=on

COPY go.mod go.sum ./

ENV GOPROXY=https://goproxy.cn

RUN go mod download

COPY . ./

RUN make build-docker

FROM cr.loongnix.cn/library/alpine:3.11

RUN apk add --no-cache ca-certificates


#RUN wget -O /usr/local/bin/migrate https://github.com/Loongson-Cloud-Community/migrate/releases/download/v4.15.1/migrate 
COPY --from=builder /go/src/github.com/golang-migrate/migrate/build/migrate.linux-loongarch64 /usr/local/bin/migrate
#COPY --from=builder migrate /usr/local/bin/migrate
RUN ln -s /usr/local/bin/migrate /migrate

ENTRYPOINT ["migrate"]
CMD ["--help"]
