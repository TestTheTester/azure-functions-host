﻿// Copyright (c) .NET Foundation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Azure.WebJobs.Script.Configuration;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;

namespace Microsoft.Azure.WebJobs.Script.WebHost.Configuration
{
    public class HostEasyAuthOptionsSetup : IConfigureOptions<HostEasyAuthOptions>
    {
        private readonly IEnvironment _env;

        public HostEasyAuthOptionsSetup(IEnvironment env)
        {
            _env = env;
        }

        public void Configure(HostEasyAuthOptions options)
        {
            options.SiteAuthEnabled = Convert.ToBoolean(_env.GetEnvironmentVariable(EnvironmentSettingNames.EasyAuthEnabled));
            options.SiteAuthClientId = _env.GetEnvironmentVariable(EnvironmentSettingNames.EasyAuthClientId);
        }
    }
}
