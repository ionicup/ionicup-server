# Use the official Swift image to build the application
FROM swift:latest as builder

# Create and set the working directory
RUN mkdir /workspace
WORKDIR /workspace

# Copy the current directory contents into the container
COPY . /workspace

# Build the Swift application
RUN swift build -c release --static-swift-stdlib

# Use a compatible runtime image
FROM swift:slim

# Copy the built executable from the builder stage
COPY --from=builder /workspace/.build/release/IonicupServer /

# Run the executable
ENTRYPOINT ["/IonicupServer"]