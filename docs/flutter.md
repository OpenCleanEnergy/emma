# Flutter

Some information about Flutter.

## Linux

Update your `.bashrc`:

```sh
# ~/.bashrc or ~/.bashrc.d/flutter.bashrc
# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
ANDROID_PATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
export PATH="$ANDROID_PATH:$PATH"

# flutter
export CHROME_EXECUTABLE=/usr/bin/chromium-browser
export PATH="$HOME/.local/bin/flutter/bin:$PATH"
```

## [OIDC](https://pub.dev/packages/oidc)

For [OIDC](https://pub.dev/packages/oidc) to work on Linux [some packages are
required](https://bdaya-dev.github.io/oidc/oidc-getting-started/#linux)

```
sudo dnf install \
  libsecret libsecret-devel \
  jsoncpp jsoncpp-devel
```

## Troubleshooting

> [!WARNING]
> This version only understands SDK XML versions up to 3 but an SDK XML file of
> version 4 was encountered. This can happen if you use versions of Android
> Studio and the command-line tools that were released at different times.

Go to `Android Studio -> SDK Manager -> Android SDK` and make sure your SDK Platforms and SDK Tools are up to date.

---
