FROM oven/bun

WORKDIR /app
COPY . .
# COPY package.json .
# VOLUME [ "/app" ]
RUN bun i

ENTRYPOINT [ "bun", "run", "dev", "--host"]