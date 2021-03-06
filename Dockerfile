# Stage 1 - the build process
FROM node:8.12.0-alpine as build-deps
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
#RUN yarn
COPY . ./
#RUN yarn build
RUN npm run build

# Stage 2 - the production environment
FROM nginx:1.15.5-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
