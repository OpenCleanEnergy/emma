# Contributing Guidelines

Thank you for your interest in contributing to our project! At this time, the
project is in its early development stage and we are currently not accepting
external contributions.

## TL;DR

👋 **Thanks for your interest!** We're focused on building a stable prototype.

🚀 **Stay tuned for updates.** Once we're stable, we will provide detailed
guidelines on how you can contribute effectively.

## Why aren't we accepting contributions right now?

The project is in the early stages of development, and we are focused on
establishing a solid foundation and creating a working prototype. Accepting
external contributions at this early stage might introduce complexities that
could hinder our progress.

## When will we start accepting contributions?

We plan to open up the project to external contributions once we reach a more
stable state and have a working prototype. This will allow us to provide a
better experience for contributors and maintainers alike.

## How can you stay involved?

We understand that you may be eager to contribute, and we encourage you to stay
engaged with the project during this early phase:

1. **Star the Repository:** Keep an eye on the repository for updates, releases,
   and announcements.

2. **Spread the Word:** Help us build a community by sharing information about
   the project with others who might be interested.

## How can you contribute in the future?

Once we start accepting contributions, we will provide detailed guidelines on
how you can contribute effectively. This will include information on coding
standards, issue tracking, and the contribution process for both software and
hardware components.

We appreciate your understanding and patience as we work towards making the
project more accessible to external contributors. If you have any questions or
concerns, please feel free to reach out to us.

Thank you for your support and interest in our project!

Open Clean Energy Team

---

## Discover the project right away.

If you are eager to discover the project follow the instructions below.
The instructions describe how to get the different parts of the project running
at your system.

### Required tools

- [just - a command runner](https://github.com/casey/just#installation)
- [docker](https://docs.docker.com/engine/install/)
- [flutter for Desktop (development) and Android](https://docs.flutter.dev/get-started/install)
  - [Additional steps](#flutter) may be required.
- [Pulumi](https://www.pulumi.com/docs/install/)

#### Flutter

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

For [OIDC](https://pub.dev/packages/oidc) to work under linux [some packages are
required](https://bdaya-dev.github.io/oidc/oidc-getting-started/#linux)

```
sudo dnf install \
  libsecret libsecret-devel \
  jsoncpp jsoncpp-devel
```
