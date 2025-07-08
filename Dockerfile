FROM node:22.17.0-alpine AS build

WORKDIR /usr/src/app

COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json
COPY ./tsconfig.json ./tsconfig.json
COPY ./src ./src

RUN npm i
RUN npm run build
RUN npm i --omit=dev

FROM node:22.17.0-alpine

WORKDIR /usr/src/app

COPY --from=build ./usr/src/app/package.json ./package.json
COPY --from=build ./usr/src/app/package-lock.json ./package-lock.json
COPY --from=build ./usr/src/app/node_modules ./node_modules
COPY --from=build ./usr/src/app/dist ./dist

CMD ["npm", "run", "start:prod"]
