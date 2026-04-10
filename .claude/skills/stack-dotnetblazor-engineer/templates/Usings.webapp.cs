// Copyright (c) {Projeto}. All rights reserved.
// Licensed under the Apache version 2.0: LICENSE file.

global using System;
global using System.Collections.Generic;
global using System.IO;
global using System.Linq;
global using System.Threading;
global using System.Threading.Tasks;
global using System.Net.Http;
global using System.Net.Http.Json;

global using Microsoft.AspNetCore.Builder;
global using Microsoft.AspNetCore.Http;
global using Microsoft.AspNetCore.Routing;
global using Microsoft.AspNetCore.Components.Forms;
global using Microsoft.AspNetCore.Components.Routing;
global using Microsoft.AspNetCore.Components.Web;

global using static Microsoft.AspNetCore.Components.Web.RenderMode;
global using Microsoft.AspNetCore.Components.Web.Virtualization;
global using Microsoft.JSInterop;

global using Microsoft.Extensions.Configuration;
global using Microsoft.Extensions.DependencyInjection;
global using Microsoft.Extensions.Hosting;
global using Microsoft.Extensions.Logging;

global using TheCleanArch.Core;
global using TheCleanArch.Core.Patterns.GuardClauses;

global using {Prefix}.InterfaceAdapters.UI.WebApp;
global using {Prefix}.InterfaceAdapters.UI.WebApp.Components;
global using {Prefix}.InterfaceAdapters.UI.WebApp.Components.Layout;
