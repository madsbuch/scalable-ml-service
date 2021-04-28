# ========= BUILD =========
FROM node:14-alpine as builder

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN yarn install --production

COPY . .

RUN yarn build

# ========= RUN =========
FROM nginx:1.17

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/build /usr/share/nginx/html