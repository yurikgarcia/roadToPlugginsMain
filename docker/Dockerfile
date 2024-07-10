FROM harbor.hulk.beast-code.com/base-images/alpine3-19:latest

ARG USERNAME=benjo
ARG GROUPNAME=benjo
ARG UID=1001
ARG GID=1001

USER root

# aspnet dependencies and utils
RUN apk add -q --no-cache \
  bash \
  curl \
  wget \
  dumb-init \
  icu-libs \
  krb5-libs \
  libgcc \
  libintl \
  libssl3 \
  libstdc++ \
  zlib

# .NET runtime
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && \
  chmod +x ./dotnet-install.sh && \
  ./dotnet-install.sh --channel 8.0 --runtime aspnetcore --install-dir /usr/share/.dotnet && \
  ln -s /usr/share/.dotnet/dotnet /usr/bin/dotnet && \
  rm dotnet-install.sh

COPY release/ /app

# setup user
RUN addgroup --gid $GID $GROUPNAME && \
  adduser --ingroup $GROUPNAME --disabled-password --no-create-home --uid $UID $USERNAME && \
  chown root:root /usr/bin/dumb-init && \
  chown -R $UID:$GID /app/*

USER $UID:$GID
WORKDIR /app

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["dotnet", "App.Backend.dll"]

ENV DOTNET_URLS http://*:9001
EXPOSE 9001