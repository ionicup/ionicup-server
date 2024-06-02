# Use the official Swift image to build the application
FROM swift:latest as builder

# Create and set the working directory
RUN mkdir /ionicup-server
WORKDIR /ionicup-server

# Copy the current directory contents into the container
COPY . /ionicup-server

# Build the Swift application
RUN swift build -c release --static-swift-stdlib

# Use a compatible runtime image
FROM swift:slim

# Copy the built executable from the builder stage
COPY --from=builder /ionicup-server/.build/release/IonicupServer /

# Run the executable
ENTRYPOINT ["/IonicupServer"]
