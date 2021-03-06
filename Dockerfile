FROM node:8.11

RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends sqlite3 git apt-utils apt-transport-https ca-certificates expect


RUN git clone https://gitlab.com/argit/matrix-recorder.git
ADD templates /matrix-recorder/templates

WORKDIR matrix-recorder

RUN yarn add olm node-cron
RUN yarn install --verbose --frozen-lockfile --optional

ADD scripts scripts

ENTRYPOINT ["node", "matrix-recorder.js", "w3f_matrix_log"]
