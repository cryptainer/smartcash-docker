[![Docker Build Status](https://img.shields.io/docker/build/cryptainer/smartcash.svg?style=for-the-badge)](https://hub.docker.com/r/cryptainer/smartcash/)
[![Docker Stars](https://img.shields.io/docker/stars/cryptainer/smartcash.svg?style=for-the-badge)](https://hub.docker.com/r/cryptainer/smartcash/)
[![Docker Pulls](https://img.shields.io/docker/pulls/cryptainer/smartcash.svg?style=for-the-badge)](https://hub.docker.com/r/cryptainer/smartcash/)

# smartcash-docker
This is a fully featured docker image for running a SmartCash wallet. It's initial purpose is the operation of a SmartCash SmartNode.

## Usage

A typical `cryptainer/smartcash` SmartNode container can be started as follows:
```bash
docker run \
  -e conf_rpcuser=changeme \
  -e conf_rpcpassword=changeme \
  -e conf_rpcallowip=::/0 \
  -e conf_rpcport=22350 \
  -e conf_port=9678 \
  -e conf_listen=1 \
  -e conf_server=1 \
  -e conf_smartnode=1 \
  -e conf_txindex=1 \
  -e conf_smartnodeprivkey=<your smartnode privatekey> \
  -e conf_printtoconsole=1 \
  -v /path/to/data:/data \
  cryptainer/smartcash
```

### Volumes
* `/data`: The `.smartcash` directory (blocks, chainstate,...)

### Configuration
The `smartcash.conf` gets generated on each container start based on the given environment variables prefixed with `conf_`.
For example, to set `smartnode=1` you need to run the container as follows:
```bash
docker run -e conf_smartnode=1 cryptainer/smartcash
```

### Troubleshooting
Set `DEBUG=1` in order to have all configuration printed to stdout during container startup.

## Contribute
n order to contribute a patch, the workflow is as follows:

Fork repository
Create feature branch
Commit patches
Submit pull request
In general commits should be atomic and diffs should be easy to read. For this reason do not mix any formatting fixes or code moves with actual code changes.

Commit messages should be verbose by default, consisting of a short subject line (50 chars max), a blank line and detailed explanatory text as separate paragraph(s); unless the title alone is self-explanatory (like "Corrected typo in main.cpp") then a single title line is sufficient. Commit messages should be helpful to people reading your code in the future, so explain the reasoning for your decisions. Further explanation [here](http://chris.beams.io/posts/git-commit/).

## License
Released under the MIT license, under the same terms as [SmartCash](https://github.com/SmartCash/smartcash) itself. See [LICENSE](LICENSE) for more info.

## Donations
Do you like this project and want to say thanks? Your donation is always welcome:

SmartCash: `SgZcMNzgVQD9TRQArtJ6a1LTZr5U93dj53`

Bitcoin: `1LHq6uYsqMX23tx2hDripE4zktX6yxfrUF`
