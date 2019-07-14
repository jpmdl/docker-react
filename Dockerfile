# Build Phase

# Tag phase 'as' <name> and all instructions below are tagged also
FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

# CMD should be final, if it's an intermediate step, should be RUN
RUN npm run build

# Start Phase
# Just naming a FROM statement again, terminates previous step
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

# No need to override CMD, the default nginx command will do