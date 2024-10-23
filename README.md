## TODO

- [ ] Onboarding flow (connect github)
- [ ] we should have a feature to continuously poll stuff and figure out if they are still alive
- [ ] Healthchecks and whatnot
- [ ] Write the manifesto
- [ ] allow public network access flag is not currently doing anything

* I want a way to “stop” the processes, can maybe do this with a replicas=0 setting
* All the times need to show relative times, not absolute. It’s too hard to understand absolute times.
* Whenever something is pushed, and deployed, we need to kill all one off containers because they are no longer running the correct source code
* “Pending” should have some kind of active spinner animation just for the feels
* Rebulid metrics tabs so it works for both clusters & pods
  https://overcast.blog/zero-downtime-deployments-with-kubernetes-a-full-guide-71019397b924?gi=95ab85c45634
* Team mates features

## Potential add ons:

- [ ] Add a TODO board based on code, on each code push

## Setup

- node 18
- brew install helm
- bundle install
- cloudflared tunnel for development testing with github
- set up .env file
- run docker locally
- TODO: beef up readme

```bash
APP_HOST=canine.example.com
OMNIAUTH_GITHUB_WEBHOOK_SECRET=1234567890
OMNIAUTH_GITHUB_PUBLIC_KEY=1234567890
OMNIAUTH_GITHUB_PRIVATE_KEY=1234567890
```

#### Running

To run your application, you'll use the `bin/dev` command:

```bash
bin/dev
```
