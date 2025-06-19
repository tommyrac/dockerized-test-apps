FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the code and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Install curl, wget, and unzip (keep them available in the final image)
RUN apt-get update && \
    apt-get install -y curl wget unzip procps net-tools && \
    wget -O /tmp/aws-otel-dotnet-install.sh https://github.com/aws-observability/aws-otel-dotnet-instrumentation/releases/download/v1.7.0/aws-otel-dotnet-install.sh && \
    chmod +x /tmp/aws-otel-dotnet-install.sh && \
    /tmp/aws-otel-dotnet-install.sh && \
    rm /tmp/aws-otel-dotnet-install.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Verify curl, wget, and unzip remain available
RUN curl --version && wget --version && unzip -v
ENV OS_TYPE=linux-glibc
ENV ARCHITECTURE=x64

ENTRYPOINT ["/bin/bash", "-c", "set -euo pipefail; echo '[DEBUG] Sourcing instrument.sh...'; if [ ! -f /root/.otel-dotnet-auto/instrument.sh ]; then echo '[ERROR] instrument.sh not found!'; exit 1; fi; . /root/.otel-dotnet-auto/instrument.sh; echo '[DEBUG] Profiler envs:'; env | grep -E 'CORECLR|DOTNET_STARTUP_HOOKS|OTEL'; exec dotnet test-dotnet.dll"]
EXPOSE 8090
