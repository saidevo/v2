FROM httpd:latest
LABEL Author="Tejaswini"
LABEL Project="oxer"
COPY ./oxer-html /usr/local/apache2/htdocs


