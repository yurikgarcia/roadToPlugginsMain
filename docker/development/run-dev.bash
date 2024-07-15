#!/bin/bash

# Ensures .NET can reach nuget.org in Kubernetes environments.
echo "$(dig +short api.nuget.org | tail -n1) api.nuget.org" >> /etc/hosts

# Installs the Visual Studio Debugger for remote debugging capabilities.
curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l ~/vsdbg

# Restores .NET packages and installs NPM dependencies.
dotnet restore ./backend/VueNetApp.sln
npm i --prefix ./frontend

# Starts supervisord to manage development processes.
supervisord -c /root/supervisord.conf
