# Changelog

## [1.0.0-alpha.16](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.15...server-v1.0.0-alpha.16) (2024-06-03)


### 🐛 Bug Fixes

* fixes multi-platform build /4 ([a1acd5d](https://github.com/OpenCleanEnergy/emma/commit/a1acd5dfabe47d7b69197209eaa31692ea578134))

## [1.0.0-alpha.15](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.14...server-v1.0.0-alpha.15) (2024-06-03)


### 🐛 Bug Fixes

* fixes multi-platform build /3 ([660bfc1](https://github.com/OpenCleanEnergy/emma/commit/660bfc16c57db48af62d6e451414de0c8c17229a))

## [1.0.0-alpha.14](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.13...server-v1.0.0-alpha.14) (2024-06-03)


### 🐛 Bug Fixes

* fixes multi-platform build /2 ([7ac0ce9](https://github.com/OpenCleanEnergy/emma/commit/7ac0ce9aff6701de796c0ed7c492b84ce3ab9232))

## [1.0.0-alpha.13](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.12...server-v1.0.0-alpha.13) (2024-06-03)


### 🐛 Bug Fixes

* Fixes multi-platform build in pipeline. ([201ea3f](https://github.com/OpenCleanEnergy/emma/commit/201ea3f3445e6be5bb474b8439fe33c1a7778d23))

## [1.0.0-alpha.12](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.11...server-v1.0.0-alpha.12) (2024-06-03)


### 🚀 Features

* Adds multi-platform docker image. ([44c91f2](https://github.com/OpenCleanEnergy/emma/commit/44c91f28796cf128cd2d6065b228ca5d691e4612))


### 📦️ Build System, Dependencies

* **deps:** bump dotnet-ef from 8.0.5 to 8.0.6 in /server ([#49](https://github.com/OpenCleanEnergy/emma/issues/49)) ([db42f3d](https://github.com/OpenCleanEnergy/emma/commit/db42f3d1658b348a5b1aba83d04c43320fcf6edf))
* **deps:** bump Microsoft.AspNetCore.Authentication.JwtBearer from 8.0.5 to 8.0.6 in /server ([#46](https://github.com/OpenCleanEnergy/emma/issues/46)) ([75464e7](https://github.com/OpenCleanEnergy/emma/commit/75464e7a64455d636f484b0edce7949c047eff12))
* **deps:** bump Microsoft.EntityFrameworkCore.Design from 8.0.5 to 8.0.6 in /server in the ef-core group ([#45](https://github.com/OpenCleanEnergy/emma/issues/45)) ([083cf5e](https://github.com/OpenCleanEnergy/emma/commit/083cf5ed473b2a162d2421fc0a16848fee0081e1))
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
