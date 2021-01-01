############ Elm Build  ################
FROM codesimple/elm:0.19 AS elm-build

WORKDIR /usr/local/elm_app
COPY . .

ARG ELM_APP_BACKEND_URL
ENV ELM_APP_BACKEND_URL=$ELM_APP_BACKEND_URL

RUN apk update && \
    apk add --no-cache npm
RUN npm install -g elm elm-test create-elm-app --unsafe-perm=true
RUN elm-test
RUN elm-app build

############ Application Build ################
FROM nginx:alpine

LABEL maintainer="loggpeter@gmail.com"

COPY --from=elm-build /usr/local/elm_app/build/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/configfile.template

ENV PORT=8080
ENV HOST=0.0.0.0

EXPOSE 8080
CMD sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/configfile.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
