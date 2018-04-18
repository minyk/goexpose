PWD := `pwd`
VERSION := `grep -F "VERSION = " settings.go | cut -d\" -f2`

default: build

build: clean
	docker run --rm -v $(PWD):/go/src/goexpose -w /go/src/goexpose golang:1.10.1 /go/src/goexpose/make.sh
	docker build --build-arg version=$(VERSION) -t harbor.ajway.kr/test/goexpose:dev .

push: build
	docker tag harbor.ajway.kr/test/goexpose:dev harbor.ajway.kr/test/goexpose:$(VERSION)
	docker push harbor.ajway.kr/test/goexpose:$(VERSION)

test: build
	docker run -it --rm -p9900:9900 harbor.ajway.kr/test/goexpose:dev

clean:
	rm  -rf ./build | true
	docker rmi harbor.ajway.kr/test/goexpose:dev | true
