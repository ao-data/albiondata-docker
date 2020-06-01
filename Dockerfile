ARG runtime=runtime
ARG project

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
ARG project

WORKDIR /app

# copy csproj and restore as distinct layers
COPY ${project}/${project}/*.csproj ./${project}/
WORKDIR /app/${project}
RUN dotnet restore

# copy and publish app and libraries
WORKDIR /app/
COPY ${project}/${project}/. ./${project}/
WORKDIR /app/${project}
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/${runtime}:3.1 AS runtime
ARG project
WORKDIR /app
COPY --from=build /app/${project}/out ./

# This is a hack to get the project into the entrypoint. Build args
# don't make it into the entrypoint, so you need an env var and a shell
# to evaluate it.
COPY entrypoint.sh /entrypoint.sh
ENV PROJECT=${project}
ENTRYPOINT ["/entrypoint.sh"]
