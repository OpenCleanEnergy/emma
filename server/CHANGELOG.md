# Changelog

## [1.0.0-alpha.21](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.20...server-v1.0.0-alpha.21) (2024-06-16)


### 🐛 Bug Fixes

* **shelly:** Support Shelly Gen 2+ devices ([#92](https://github.com/OpenCleanEnergy/emma/issues/92)) ([64cb9de](https://github.com/OpenCleanEnergy/emma/commit/64cb9de5fd3b70c90da18534393656758c709364))

## [1.0.0-alpha.20](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.19...server-v1.0.0-alpha.20) (2024-06-16)


### 🚀 Features

* Log service name and version and ([#83](https://github.com/OpenCleanEnergy/emma/issues/83)) ([e31c233](https://github.com/OpenCleanEnergy/emma/commit/e31c233752290f7a2c22246d8ebbc8ec21074f6a))
* Log to BetterStack ([#90](https://github.com/OpenCleanEnergy/emma/issues/90)) ([c40546a](https://github.com/OpenCleanEnergy/emma/commit/c40546af82ccd11c5c6674eb907f2874d81ef15f))

## [1.0.0-alpha.19](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.18...server-v1.0.0-alpha.19) (2024-06-15)


### 🐛 Bug Fixes

* **shelly:** Log and handle exceptions for Shelly websocket connections ([#85](https://github.com/OpenCleanEnergy/emma/issues/85)) ([ce22494](https://github.com/OpenCleanEnergy/emma/commit/ce22494b40b74e02fbd93d05bb4c3bf21d1e3254))

## [1.0.0-alpha.18](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.17...server-v1.0.0-alpha.18) (2024-06-13)


### 🚀 Features

* Set log level based on request status code. ([#80](https://github.com/OpenCleanEnergy/emma/issues/80)) ([5accd53](https://github.com/OpenCleanEnergy/emma/commit/5accd531753dad827517900703980db27cbe8f7b))

## [1.0.0-alpha.17](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.16...server-v1.0.0-alpha.17) (2024-06-11)


### 🚀 Features

* Adds basic Sentry monitoring. ([342286c](https://github.com/OpenCleanEnergy/emma/commit/342286c11e14dfe7627b651120025bc39844ccce))


### 🐛 Bug Fixes

* Logs warning with invalid properties if Shelly integration configuration is invalid. ([e144f33](https://github.com/OpenCleanEnergy/emma/commit/e144f338f09ba9e1c9132e9fa06f7bb08ff4137a))

## [1.0.0-alpha.16](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.15...server-v1.0.0-alpha.16) (2024-06-11)


### 🚀 Features

* Adds `/health` check ([65d0253](https://github.com/OpenCleanEnergy/emma/commit/65d0253900574689dcc3a55c3fb8f0292fbe2d7e))

## [1.0.0-alpha.15](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.14...server-v1.0.0-alpha.15) (2024-06-11)


### 🚀 Features

* Set MSBuild property InvariantGlobalization to ensure same behavior for development and docker image. ([7e3cc16](https://github.com/OpenCleanEnergy/emma/commit/7e3cc16065f5eb3aea6961635d7bf7353e405f0d))


### 📦️ Build System, Dependencies

* deploy server ([#71](https://github.com/OpenCleanEnergy/emma/issues/71)) ([9bddff4](https://github.com/OpenCleanEnergy/emma/commit/9bddff418c59152cc39a5e345cfc2e17d40ad5bc))

## [1.0.0-alpha.14](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.13...server-v1.0.0-alpha.14) (2024-06-09)


### 🚀 Features

* Renames `CallbackBaseUri` to `CallbackBaseUrl` ([7b10790](https://github.com/OpenCleanEnergy/emma/commit/7b1079042f6098ffbb94c3a325db396ee54e71e1))
* **Shelly:** Log invalid properties on startup. ([8f3000a](https://github.com/OpenCleanEnergy/emma/commit/8f3000ae16462ab88a0c37c48a65213948de7042))

## [1.0.0-alpha.13](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.12...server-v1.0.0-alpha.13) (2024-06-09)


### 🚀 Features

* own keycloak container image to scope environment variables to entrypoint ([#59](https://github.com/OpenCleanEnergy/emma/issues/59)) ([a2dff57](https://github.com/OpenCleanEnergy/emma/commit/a2dff57e462d8a10ab9e9bc3f43d94c054a7eddc))


### 🐛 Bug Fixes

* Fixes multi-platform container image. ([11bbf3c](https://github.com/OpenCleanEnergy/emma/commit/11bbf3c0d49463535835eeec3505cc434305ceee))

## [1.0.0-alpha.12](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.11...server-v1.0.0-alpha.12) (2024-06-03)


### 🚀 Features

* Adds multi-platform docker image. ([7e3abb8](https://github.com/OpenCleanEnergy/emma/commit/7e3abb8aa1486e14eb2f79262e6df1ad65c83613))


### 📦️ Build System, Dependencies

* **deps:** bump dotnet-ef from 8.0.5 to 8.0.6 in /server ([#49](https://github.com/OpenCleanEnergy/emma/issues/49)) ([82476fd](https://github.com/OpenCleanEnergy/emma/commit/82476fdd5b5de580d93e886798106ba61fa63957))
* **deps:** bump Microsoft.AspNetCore.Authentication.JwtBearer from 8.0.5 to 8.0.6 in /server ([#46](https://github.com/OpenCleanEnergy/emma/issues/46)) ([75464e7](https://github.com/OpenCleanEnergy/emma/commit/75464e7a64455d636f484b0edce7949c047eff12))
* **deps:** bump Microsoft.EntityFrameworkCore.Design from 8.0.5 to 8.0.6 in /server in the ef-core group ([#45](https://github.com/OpenCleanEnergy/emma/issues/45)) ([1a6b5f9](https://github.com/OpenCleanEnergy/emma/commit/1a6b5f9a5ffe2ac3d9c9a5ec9a40a97b2b4cfd5d))
* **deps:** bump SonarAnalyzer.CSharp from 9.25.1.91650 to 9.26.0.92422 in /server ([#47](https://github.com/OpenCleanEnergy/emma/issues/47)) ([16d13b1](https://github.com/OpenCleanEnergy/emma/commit/16d13b14b7ccc91cd41427a5490c64b64b9764ce))
* **deps:** bump Vogen from 4.0.6 to 4.0.8 in /server ([#48](https://github.com/OpenCleanEnergy/emma/issues/48)) ([5bdee36](https://github.com/OpenCleanEnergy/emma/commit/5bdee366b0dc95054219d7c389dd17163c21010e))

## [1.0.0-alpha.11](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.10...server-v1.0.0-alpha.11) (2024-05-29)


### 🚀 Features

* Adds development integration. ([68b0733](https://github.com/OpenCleanEnergy/emma/commit/68b07331f389f12f2f80a10b9829762bc96a2e60))


### 🐛 Bug Fixes

* Do not use request body in `DELETE` methods. ([e210c43](https://github.com/OpenCleanEnergy/emma/commit/e210c43c1199c1caca9b76c0f4c8c8e1812fc815))


### 📦️ Build System, Dependencies

* **deps:** bump csharpier from 0.28.1 to 0.28.2 in /server ([#36](https://github.com/OpenCleanEnergy/emma/issues/36)) ([d7ffa25](https://github.com/OpenCleanEnergy/emma/commit/d7ffa257a8fcda1c10a56665c58a8930595dd549))
* **deps:** bump dotnet-ef from 8.0.4 to 8.0.5 in /server ([#37](https://github.com/OpenCleanEnergy/emma/issues/37)) ([164001e](https://github.com/OpenCleanEnergy/emma/commit/164001e5f8ab53faa6e1cbb3b26029f96be25778))
* **deps:** bump SimpleInjector from 5.4.5 to 5.4.6 in /server ([#38](https://github.com/OpenCleanEnergy/emma/issues/38)) ([7357910](https://github.com/OpenCleanEnergy/emma/commit/735791093d8fe55ba81616459f9ecd53ee255b21))
* **deps:** bump SonarAnalyzer.CSharp from 9.23.2.88755 to 9.25.1.91650 in /server ([#35](https://github.com/OpenCleanEnergy/emma/issues/35)) ([8ef86f6](https://github.com/OpenCleanEnergy/emma/commit/8ef86f6c7d3fdd8b111b6233a76548a6239388e4))
* **deps:** bump Vogen from 4.0.4 to 4.0.6 in /server ([#39](https://github.com/OpenCleanEnergy/emma/issues/39)) ([a5e94ef](https://github.com/OpenCleanEnergy/emma/commit/a5e94ef1a684a9a2b43a86680d93d4d91adc2853))

## [1.0.0-alpha.10](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.9...server-v1.0.0-alpha.10) (2024-05-26)


### 🐛 Bug Fixes

* Publish entities with events at the start of `DbContext.SaveChanges(Async)`to capture events of removed entities. ([b3c5967](https://github.com/OpenCleanEnergy/emma/commit/b3c5967c0559701555b115a49ac1fffcab89d4b4))

## [1.0.0-alpha.9](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.8...server-v1.0.0-alpha.9) (2024-05-23)


### 📦️ Build System, Dependencies

* Replaces nuke with bullseye. ([1e84267](https://github.com/OpenCleanEnergy/emma/commit/1e842679585a284326920e22e993437a0fdac103))

## [1.0.0-alpha.8](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.7...server-v1.0.0-alpha.8) (2024-05-22)


### 📦️ Build System, Dependencies

* Skip swagger generation in Dockerfile. ([2a63082](https://github.com/OpenCleanEnergy/emma/commit/2a63082311d25cbcfa5e5a05dc79dee32f086c03))

## [1.0.0-alpha.7](https://github.com/OpenCleanEnergy/emma/compare/emma-server-v1.0.0-alpha.6...emma-server-v1.0.0-alpha.7) (2024-05-22)


### 🐛 Bug Fixes

* Fixes VogenValueObjectConverter after Vogen update. ([668427e](https://github.com/OpenCleanEnergy/emma/commit/668427eac1ae7c602e01a4e24a7e651af04ce06c))


### 📦️ Build System, Dependencies

* Always generate swagger backend_api.json. ([119ad89](https://github.com/OpenCleanEnergy/emma/commit/119ad895b06a8d7194d472a4401f81eded1ed2bd))

## [1.0.0-alpha.6](https://github.com/OpenCleanEnergy/emma/compare/emma-server-v1.0.0-alpha.5...emma-server-v1.0.0-alpha.6) (2024-05-22)


### 🐛 Bug Fixes

* Fixes label white spaces. ([a793ca6](https://github.com/OpenCleanEnergy/emma/commit/a793ca6a66fbe40bdf72441a1887cc50383c3e22))

## [1.0.0-alpha.5](https://github.com/OpenCleanEnergy/emma/compare/emma-server-v1.0.0-alpha.4...emma-server-v1.0.0-alpha.5) (2024-05-22)


### 🚀 Features

* Adds labels to docker image. ([d0818d8](https://github.com/OpenCleanEnergy/emma/commit/d0818d871f882b7dedfc63452e7d8a7e5385d01c))

## [1.0.0-alpha.4](https://github.com/OpenCleanEnergy/emma/compare/emma-server-v1.0.0-alpha.3...emma-server-v1.0.0-alpha.4) (2024-05-22)


### 📦️ Build System, Dependencies

* Fixes docker tasks logger, improves prerelease tagging. ([eb0e32e](https://github.com/OpenCleanEnergy/emma/commit/eb0e32ed92b88d06361b57d63ec2c8fde5518231))

## [1.0.0-alpha.3](https://github.com/OpenCleanEnergy/emma/compare/emma-server-v1.0.0-alpha.2...emma-server-v1.0.0-alpha.3) (2024-05-22)


### 📦️ Build System, Dependencies

* fixes repository name - repository must be lowercase. ([14d3643](https://github.com/OpenCleanEnergy/emma/commit/14d36439c3b2893415261e31d123ed5c60b97af7))

## [1.0.0-alpha.2](https://github.com/OpenCleanEnergy/emma/compare/emma-server-v1.0.0-alpha.1...emma-server-v1.0.0-alpha.2) (2024-05-22)


### 📦️ Build System, Dependencies

* fixes docker image organization. ([cb24ecb](https://github.com/OpenCleanEnergy/emma/commit/cb24ecbd54ea2225d6cbc3f7e3ae3282467afbf4))

## [1.0.0-alpha.1](https://github.com/OpenCleanEnergy/emma/compare/emma-server-v1.0.0-alpha.0...emma-server-v1.0.0-alpha.1) (2024-05-22)


### 📦️ Build System, Dependencies

* **deps:** bump Microsoft.AspNetCore.Authentication.JwtBearer from 8.0.3 to 8.0.5 in /server ([#2](https://github.com/OpenCleanEnergy/emma/issues/2)) ([0f3a327](https://github.com/OpenCleanEnergy/emma/commit/0f3a32770d3d56ea9b0d0d73dbfb3425beb68acf))
* **deps:** bump SimpleInjector from 5.4.4 to 5.4.5 in /server ([#10](https://github.com/OpenCleanEnergy/emma/issues/10)) ([83f79d8](https://github.com/OpenCleanEnergy/emma/commit/83f79d8a23371f5f0a3db2b47816ac259a3edf22))
* **deps:** bump the ef-core group in /server with 2 updates ([#8](https://github.com/OpenCleanEnergy/emma/issues/8)) ([89a096d](https://github.com/OpenCleanEnergy/emma/commit/89a096d64379b9e45b3343a5211f69b8122e9b81))
* **deps:** bump the swagger group in /server with 2 updates ([#9](https://github.com/OpenCleanEnergy/emma/issues/9)) ([5f5ea46](https://github.com/OpenCleanEnergy/emma/commit/5f5ea46d1cbcc14f9da22680a9e2b20bd7042e27))
* **deps:** bump Vogen from 4.0.2 to 4.0.4 in /server ([#12](https://github.com/OpenCleanEnergy/emma/issues/12)) ([48b6a82](https://github.com/OpenCleanEnergy/emma/commit/48b6a8298fa0e5a2b36e6e59bc288107d3132584))
