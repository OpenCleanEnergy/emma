# Changelog

## [1.0.0-alpha.39](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.38...server-v1.0.0-alpha.39) (2024-11-01)


### 🚀 Features

* **Analytics:** Weekly analysis ([#251](https://github.com/OpenCleanEnergy/emma/issues/251)) ([c2246cb](https://github.com/OpenCleanEnergy/emma/commit/c2246cb755172fa166db9aba65bb56c2dd338d89))

## [1.0.0-alpha.38](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.37...server-v1.0.0-alpha.38) (2024-10-30)


### 🚀 Features

* **Analytics:** Daily power history analysis and daily, weekly, monthly and annual metrics. ([#249](https://github.com/OpenCleanEnergy/emma/issues/249)) ([269f1c1](https://github.com/OpenCleanEnergy/emma/commit/269f1c1d42ab6779a2601d81bc020be637f9caf8))


### 🐛 Bug Fixes

* Do not initialize `Producer.TotalEnergyProduction` with zero but with `null`. ([010e5d3](https://github.com/OpenCleanEnergy/emma/commit/010e5d3cc45017f3113d2564941f58421f19350b))
* Fix issue with generated client. ([12d0edd](https://github.com/OpenCleanEnergy/emma/commit/12d0edd24da79bd25ad6f46e0f4432724fc3fc6b))
* Fix logger registration ([0d7a0ee](https://github.com/OpenCleanEnergy/emma/commit/0d7a0eea982810a7b04f2fdc3b780f004d619be3))
* fix missing pipeline behavior registration ([204d559](https://github.com/OpenCleanEnergy/emma/commit/204d55982dd7690c78303296ab3698419e1e4345))


### 📦️ Build System, Dependencies

* **deps:** bump the dependencies group across 1 directory with 16 updates ([#240](https://github.com/OpenCleanEnergy/emma/issues/240)) ([248676c](https://github.com/OpenCleanEnergy/emma/commit/248676cd4bc9e43511882382f9547d028919c0be))
* **deps:** bump the dependencies group in /server with 3 updates ([#247](https://github.com/OpenCleanEnergy/emma/issues/247)) ([bb3d4b2](https://github.com/OpenCleanEnergy/emma/commit/bb3d4b208c513729fada2b787ed9377e516651d6))
* Use `pwsh` as shell in just for windows ([1d52b1f](https://github.com/OpenCleanEnergy/emma/commit/1d52b1f76c91b877b3508d0068cfa16144f506dd))

## [1.0.0-alpha.37](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.36...server-v1.0.0-alpha.37) (2024-10-02)


### 🚀 Features

* Power and energy readings of devices are `null` until first report. ([#224](https://github.com/OpenCleanEnergy/emma/issues/224)) ([f115517](https://github.com/OpenCleanEnergy/emma/commit/f115517e327146f9700eb50e18af6a3bb8e40d0c))


### 📦️ Build System, Dependencies

* **deps:** bump the dependencies group across 1 directory with 10 updates ([#218](https://github.com/OpenCleanEnergy/emma/issues/218)) ([a9b3e45](https://github.com/OpenCleanEnergy/emma/commit/a9b3e452d6abedd5c3dbc413df10a3a7c12a4bdf))
* **deps:** bump the dependencies group in /server with 2 updates ([#222](https://github.com/OpenCleanEnergy/emma/issues/222)) ([3988318](https://github.com/OpenCleanEnergy/emma/commit/398831895ec0d590d343f8b7c30f903705a88d90))

## [1.0.0-alpha.36](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.35...server-v1.0.0-alpha.36) (2024-09-29)


### 🚀 Features

* Sample devices for analytics ([#216](https://github.com/OpenCleanEnergy/emma/issues/216)) ([e87fe28](https://github.com/OpenCleanEnergy/emma/commit/e87fe28ac04fa0695c966a2d94ab8d2bc7cd4459))

## [1.0.0-alpha.35](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.34...server-v1.0.0-alpha.35) (2024-09-22)


### 🐛 Bug Fixes

* fixes shelly hosted service registration. ([8ebd9da](https://github.com/OpenCleanEnergy/emma/commit/8ebd9dad42e89586c2d37a69bd4f82193daf1b50))

## [1.0.0-alpha.34](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.33...server-v1.0.0-alpha.34) (2024-09-22)


### 🐛 Bug Fixes

* fixes dependency injection issue. ([388bdee](https://github.com/OpenCleanEnergy/emma/commit/388bdeea8f19614e273a3f45293bb9df89be0258))

## [1.0.0-alpha.33](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.32...server-v1.0.0-alpha.33) (2024-09-22)


### 🚀 Features

* Handle hardware reset of total energy reportings. ([07aa1ae](https://github.com/OpenCleanEnergy/emma/commit/07aa1aea432d98ebe966514c6a822bc1ed829295))


### 🐛 Bug Fixes

* Fixes database migration `Adds_TotalEnergy` ([421b26a](https://github.com/OpenCleanEnergy/emma/commit/421b26a21bba256a0b62e9a11f80b6332ffb02e3))


### 📦️ Build System, Dependencies

* **deps:** bump the dependencies group across 1 directory with 8 updates ([#209](https://github.com/OpenCleanEnergy/emma/issues/209)) ([5cddc1a](https://github.com/OpenCleanEnergy/emma/commit/5cddc1a2cee6211da8dd40215ffca019b6693c98))
* Remove `SimpleInjector` to simplify dependency injection ([#210](https://github.com/OpenCleanEnergy/emma/issues/210)) ([765f568](https://github.com/OpenCleanEnergy/emma/commit/765f568925ce7e6e6836c527862eb76887303a68))

## [1.0.0-alpha.32](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.31...server-v1.0.0-alpha.32) (2024-09-03)


### 📦️ Build System, Dependencies

* **deps:** bump the dependencies group in /server with 2 updates ([#193](https://github.com/OpenCleanEnergy/emma/issues/193)) ([8f292b5](https://github.com/OpenCleanEnergy/emma/commit/8f292b5f0e825b1128091adbdcdb59162d29de51))
* Rename backend server to OpenEMS ([#195](https://github.com/OpenCleanEnergy/emma/issues/195)) ([ceba24a](https://github.com/OpenCleanEnergy/emma/commit/ceba24aeb38260a46e53455596ae05874f72a504))

## [1.0.0-alpha.31](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.30...server-v1.0.0-alpha.31) (2024-09-02)


### 📦️ Build System, Dependencies

* **deps:** bump the dependencies group in /server with 7 updates ([#188](https://github.com/OpenCleanEnergy/emma/issues/188)) ([b2a29b3](https://github.com/OpenCleanEnergy/emma/commit/b2a29b33d5e1bcb75eb269910cba99cf47fdeff4))

## [1.0.0-alpha.30](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.29...server-v1.0.0-alpha.30) (2024-08-22)


### 📦️ Build System, Dependencies

* **deps:** bump the dependencies group across 1 directory with 9 updates ([#180](https://github.com/OpenCleanEnergy/emma/issues/180)) ([4db8bba](https://github.com/OpenCleanEnergy/emma/commit/4db8bbaef893a6fde9019f85b63cab6a809db8e6))

## [1.0.0-alpha.29](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.28...server-v1.0.0-alpha.29) (2024-08-11)


### 🚀 Features

* Changes domains ([#169](https://github.com/OpenCleanEnergy/emma/issues/169)) ([00f71d9](https://github.com/OpenCleanEnergy/emma/commit/00f71d9e83e40e473542487aa698126e1017ce80))


### 📦️ Build System, Dependencies

* **deps:** bump FluentAssertions.Analyzers from 0.32.0 to 0.33.0 in /server ([#153](https://github.com/OpenCleanEnergy/emma/issues/153)) ([32a4ee2](https://github.com/OpenCleanEnergy/emma/commit/32a4ee2cc66f22203822eea95566e7d313c33aec))
* **deps:** bump MediatR from 12.3.0 to 12.4.0 in /server ([#154](https://github.com/OpenCleanEnergy/emma/issues/154)) ([b128746](https://github.com/OpenCleanEnergy/emma/commit/b12874668224401c45be2189835ad4eae7dc798e))
* **deps:** bump Serilog.AspNetCore from 8.0.1 to 8.0.2 in /server ([#156](https://github.com/OpenCleanEnergy/emma/issues/156)) ([93df582](https://github.com/OpenCleanEnergy/emma/commit/93df582806a615e6f5203b454760c2bcabc04b91))
* **deps:** bump the ef-core group in /server with 2 updates ([#142](https://github.com/OpenCleanEnergy/emma/issues/142)) ([7503714](https://github.com/OpenCleanEnergy/emma/commit/7503714e8f70491a53554909f8d47d066875edd8))
* **deps:** bump the server group in /server with 8 updates ([#167](https://github.com/OpenCleanEnergy/emma/issues/167)) ([bb65bcd](https://github.com/OpenCleanEnergy/emma/commit/bb65bcdda4bb5ca7bdf7d797c4728a810f349baf))
* **deps:** bump the xunit group in /server with 2 updates ([#143](https://github.com/OpenCleanEnergy/emma/issues/143)) ([8361111](https://github.com/OpenCleanEnergy/emma/commit/8361111e64a9c5d6996c63dd1ea7bdc18ea8cce4))
* **deps:** bump Verify.Xunit from 25.0.4 to 26.0.0 in /server ([#144](https://github.com/OpenCleanEnergy/emma/issues/144)) ([9916b8d](https://github.com/OpenCleanEnergy/emma/commit/9916b8d809082df2c1f78a9875d478c5430caed4))
* **deps:** bump Vogen from 4.0.12 to 4.0.16 in /server ([#155](https://github.com/OpenCleanEnergy/emma/issues/155)) ([2597f5c](https://github.com/OpenCleanEnergy/emma/commit/2597f5c1c8945ccafbe8ecb23d63e494cf605577))

## [1.0.0-alpha.28](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.27...server-v1.0.0-alpha.28) (2024-07-17)


### 🐛 Bug Fixes

* fixes `TransactionBehavior` ([#140](https://github.com/OpenCleanEnergy/emma/issues/140)) ([73befc7](https://github.com/OpenCleanEnergy/emma/commit/73befc73d0d744b80796afc45305a7a66aebb76e))


### 📦️ Build System, Dependencies

* **deps:** bump Medo.Uuid7 from 1.9.1 to 2.0.0 in /server ([#130](https://github.com/OpenCleanEnergy/emma/issues/130)) ([64ce0cf](https://github.com/OpenCleanEnergy/emma/commit/64ce0cffddb21c2a7b2a03e04085bab780c30208))
* **deps:** bump Sentry.Serilog from 4.7.0 to 4.9.0 in /server ([#136](https://github.com/OpenCleanEnergy/emma/issues/136)) ([28a0c18](https://github.com/OpenCleanEnergy/emma/commit/28a0c18e077425502675d47ceb1449143e4b19fa))
* **deps:** bump SonarAnalyzer.CSharp from 9.27.0.93347 to 9.29.0.95321 in /server ([#137](https://github.com/OpenCleanEnergy/emma/issues/137)) ([bf3b836](https://github.com/OpenCleanEnergy/emma/commit/bf3b836cb379cb5c8cda529d11077a6291f429b7))

## [1.0.0-alpha.27](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.26...server-v1.0.0-alpha.27) (2024-06-29)


### 🐛 Bug Fixes

* do not use `TransactionBehavior` ([1095ed3](https://github.com/OpenCleanEnergy/emma/commit/1095ed3b2e063a93c4fa08950486c26aa6b1e5d2))
* Rollback to `emma:1.0.0-alpha.24` due to unknown bug. ([718e790](https://github.com/OpenCleanEnergy/emma/commit/718e79063f858ee14487237100d9c7ea166fc104))

## [1.0.0-alpha.26](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.25...server-v1.0.0-alpha.26) (2024-06-29)


### 🐛 Bug Fixes

* Fixes `ShellyStatus` serialization. ([1c78de9](https://github.com/OpenCleanEnergy/emma/commit/1c78de9b11c791d39e8b2b792ce27dc657536300))

## [1.0.0-alpha.25](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.24...server-v1.0.0-alpha.25) (2024-06-29)


### 🚀 Features

* Use managed LavinMQ instead of in-memory queue. ([#122](https://github.com/OpenCleanEnergy/emma/issues/122)) ([0803054](https://github.com/OpenCleanEnergy/emma/commit/0803054802710ac54cca558ba02a8286c9f0e948))


### 📦️ Build System, Dependencies

* **deps:** bump Riok.Mapperly from 3.5.1 to 3.6.0 in /server ([#118](https://github.com/OpenCleanEnergy/emma/issues/118)) ([74dcb60](https://github.com/OpenCleanEnergy/emma/commit/74dcb6074634b213ff4b2066fcf375d1b68385e9))
* **deps:** bump Verify.Xunit from 25.0.3 to 25.0.4 in /server ([#119](https://github.com/OpenCleanEnergy/emma/issues/119)) ([90fefd4](https://github.com/OpenCleanEnergy/emma/commit/90fefd464ff9d5d965e90716c90a508c7698a625))
* **deps:** bump Vogen from 4.0.8 to 4.0.12 in /server ([#116](https://github.com/OpenCleanEnergy/emma/issues/116)) ([33bc219](https://github.com/OpenCleanEnergy/emma/commit/33bc219e70120b8de27e95e7ce35ef053e6ff2a2))
* **deps:** bump Websocket.Client from 5.1.1 to 5.1.2 in /server ([#117](https://github.com/OpenCleanEnergy/emma/issues/117)) ([ae9d1d5](https://github.com/OpenCleanEnergy/emma/commit/ae9d1d5ab5b1a0fd53d17521d29fec97b3923e92))

## [1.0.0-alpha.24](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.23...server-v1.0.0-alpha.24) (2024-06-19)


### 🚀 Features

* Add web app for development ([#108](https://github.com/OpenCleanEnergy/emma/issues/108)) ([b2ff38b](https://github.com/OpenCleanEnergy/emma/commit/b2ff38b023e2fd95011dcbd4fbf3fba8dc4bf077))

## [1.0.0-alpha.23](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.22...server-v1.0.0-alpha.23) (2024-06-18)


### 🚀 Features

* Log app version ([#103](https://github.com/OpenCleanEnergy/emma/issues/103)) ([79463bd](https://github.com/OpenCleanEnergy/emma/commit/79463bda17ccbf3b871ca279a2d6b7abd8f9ec2b))


### 🐛 Bug Fixes

* **shelly:** Fixes failing websocket reconnect after token refresh. ([14c1f58](https://github.com/OpenCleanEnergy/emma/commit/14c1f583f8dc07982521d674af0c984271a80871))


### 📦️ Build System, Dependencies

* **deps:** bump code-butler from 3.0.1 to 3.0.2 in /server ([#101](https://github.com/OpenCleanEnergy/emma/issues/101)) ([28170ad](https://github.com/OpenCleanEnergy/emma/commit/28170adb2a164f838bbec2e12fa538e35315d456))
* **deps:** bump MediatR from 12.2.0 to 12.3.0 in /server ([#96](https://github.com/OpenCleanEnergy/emma/issues/96)) ([8eb055f](https://github.com/OpenCleanEnergy/emma/commit/8eb055fbce4b68cda1e700f64722d5f81ea87aa0))
* **deps:** bump Microsoft.NET.Test.Sdk from 17.6.0 to 17.10.0 in /server ([#98](https://github.com/OpenCleanEnergy/emma/issues/98)) ([55bf547](https://github.com/OpenCleanEnergy/emma/commit/55bf5477fdf75af1518ca46b9956e6c65cef8d7d))
* **deps:** bump Serilog from 3.1.1 to 4.0.0 in /server ([#100](https://github.com/OpenCleanEnergy/emma/issues/100)) ([7488d83](https://github.com/OpenCleanEnergy/emma/commit/7488d8318e231a22b078e3e3a2114f85ae0f117e))
* **deps:** bump SonarAnalyzer.CSharp from 9.26.0.92422 to 9.27.0.93347 in /server ([#99](https://github.com/OpenCleanEnergy/emma/issues/99)) ([b954c0a](https://github.com/OpenCleanEnergy/emma/commit/b954c0ab520a66add6f545daa63377173b8e145a))

## [1.0.0-alpha.22](https://github.com/OpenCleanEnergy/emma/compare/server-v1.0.0-alpha.21...server-v1.0.0-alpha.22) (2024-06-16)


### 🚀 Features

* Hide current power consumption if no power consumption was reported (yet) ([17f2401](https://github.com/OpenCleanEnergy/emma/commit/17f240167a0822b314220dce2567b97f0d667fcd))
* Improves logging in request pipeline. ([5ed1ee4](https://github.com/OpenCleanEnergy/emma/commit/5ed1ee4c1f7b0925e79ed0672ce812ae4f4e2d37))

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
