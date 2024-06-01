#------- build -------
FROM swift:centos as builder

# set up the workspace
RUN mkdir /workspace
WORKDIR /workspace

# copy the source to the docker image
COPY . /workspace
COPY ../ionicup-models /workspace

RUN swift build -c release --static-swift-stdlib

#------- package -------
FROM centos:8
# copy executable
COPY --from=builder /workspace/.build/release/IonicupServer /

# set the entry point (application name)
CMD ["IonicupServer"]
