# LinkFinder action

This action uses [LinkFinder](https://github.com/GerbenJavado/LinkFinder) to fetch JavaScript files, extract URLs from them and store extracted URLs on the file system.

Combined with [Checkout](https://github.com/actions/checkout), [git-auto-commit](https://github.com/stefanzweifel/git-auto-commit-action) and GitHub push notifications this action may serve as email notifier for new endpoints. Each notification will send you a link to git commit which will show (potentially) added / removed endpoints at your target. As nice bonus all endpoints will be stored in commit history. See [Example usage](#example-usage) section for an example. 

Inspired by [The poor man's bug bounty monitoring setup](https://edoverflow.com/2018/the-poor-mans-monitoring-setup/) and [GitHub Actions](https://github.com/features/actions).

## Inputs

### `domains`

**Required if `urls` not specified** Space separated list of domains. Default is empty string.

### `urls`

**Required if `domains` not specified** Space separated list of URLs to JavaScript files. Default is empty string.

### `cookies`

This will be passed to `-c --cookies` LinkFinder's parameter. Default is empty string.

## Example usage

Create an empty repository with `.github/workflows/google.yml` file:

```
name: Extract endpoints from JavaScript files for Google

on:
  schedule:
    - cron:  '37 13 * * *'

jobs:
  fetch-push:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: nikitastupin/linkfinder-action@master
      with:
        domains: 'www.google.com mail.google.com'
    - uses: stefanzweifel/git-auto-commit-action@v4
      with:
        commit_message: Add new endpoints for Google!
        file_pattern: "*.txt"
```

This action will extract endpoints from JavaScript files linked at `www.google.com`, `mail.google.com` and push them to the same repo every day at 13:37 UTC. In order to enable email notifictations nagivate to `Settings -> Notifications` in your repository.
