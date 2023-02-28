FROM node:19-buster 

RUN apt update && apt install --yes --no-install-recommends tini

COPY ./entrypoints/entrypoint.sh /entrypoint.sh

WORKDIR /app
COPY . .

RUN npm install && npm run build

ENV NODE_ENV production

# default ports
#
#      web
#       ↓
EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "npx", "serve", "build" ]
