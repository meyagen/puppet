# [WIP] Puppet

Sample [puppet](https://docs.puppet.com/) config for setting up [idea-kickstarter](https://github.com/meyagen/idea-kickstarter), a very simple and generic Rails project I built last year.

Still a WIP.

## Setup

[Setup](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-masterless-puppet-environment-on-ubuntu-14-04) masterless puppet and git on the server.

Install `r10k` (or not... this should be included in the puppet config later)

Clone the repo in `/etc/puppet`.

```lang=bash
$ cd /etc/puppet
$ sudo r10k puppetfile install  # should be executed by puppet in the future...
$ sudo puppet apply manifests/site.pp
```
