FROM erlang:20.2.2-slim

MAINTAINER Vitor Enes <vitorenesduarte@gmail.com>

ENV NAME=/kuberlex

COPY _build/default/rel/$NAME $NAME

WORKDIR $NAME

CMD ["bin/kuberlex"]
