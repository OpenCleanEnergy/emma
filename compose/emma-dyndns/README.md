# Configure dynamic DNS for Shelly integration callback

1. Create an account at a dynamic DNS service (e.g. [selfhost.de](https://selfhost.de))
2. Configure your router to use the dynamic DNS service
3. Configure your router to forward the port `80` to `8080` and the port `443` to `4443` of your computer
4. Create the file `compose/emma-dyndns/.env.local` and set the environment variable `SERVER_FQDN` to your domain (e.g. my-domain.selfhost.co)

⚠️ Make sure `Emma.Server` is not listening to `localhost` only.
