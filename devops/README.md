# DevOps

## SSH Key

**Production**

```bash
ssh-keygen -b 4096 -C '' -N '' -f "$HOME/.ssh/openems-production"
esc env set emma-production emma:public-key "$(cat ~/.ssh/openems-production.pub)"
esc env set emma-production emma:private-key-base64 "$(cat ~/.ssh/openems-production | base64 -w 0)" --secret
```
