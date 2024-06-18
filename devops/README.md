# DevOps

## SSH Key

**Production**

```bash
ssh-keygen -b 4096 -C '' -N '' -f "$HOME/.ssh/emma-production"
esc env set emma-production emma:public-key "$(cat ~/.ssh/emma-production.pub)"
esc env set emma-production emma:private-key-base64 "$(cat ~/.ssh/emma-production | base64 -w 0)" --secret
```

## Android keystore

```bash
keytool -genkey -v -keystore ~/workspace/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias release
esc env set emma-android keystore.file-base64 "$(cat ~/workspace/key.jks | base64 -w 0)" --secret
esc env set emma-android keystore.password '<keystore password>'
```
