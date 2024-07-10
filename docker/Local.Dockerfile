# BUILD
FROM harbor.hulk.beast-code.com/base-images/alpine3-19-net8-node20:latest AS build

WORKDIR /app
COPY . .

WORKDIR /app/frontend
RUN npm i && npm run clean && npm run build

WORKDIR /app/backend
RUN dotnet publish -c Release -o ../release --nologo App.Backend

# RELEASE
FROM harbor.hulk.beast-code.com/base-images/alpine3-19:latest

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

WORKDIR /app
COPY --from=build /app/release/ .

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["dotnet", "App.Backend.dll"]

ENV DOTNET_URLS http://*:9001
EXPOSE 9001