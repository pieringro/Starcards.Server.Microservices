# Pull base image.
FROM mongo

# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Define default command.
# CMD ["mongod"]
# Custom command for replSet
CMD ["mongod", "--replSet", "my-replica"]


# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017
#EXPOSE 28017