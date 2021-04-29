# Docker + Magento 2.3.5
<i>A simple Docker + Magento 2.3.5 + nginx + php-fpm (custom build with extensions) + mysql + redis + elasticsearch setup.</i>

# <b>WARNING! This is TEST SETUP! Don't use it in production.</b>

## Prerequisites
- docker
- docker-compose
- wget
- git
- tar

## Installation
To simplify setup, use attached SETUP.sh script:
```
git clone https://github.com/KryDw/Mag2Test.git
cd Mag2Test
chmod +x SETUP.sh
./SETUP.sh
docker-compose up
```

What script does:
- if magento2 files arleady exists, create backup of old setup and start new one
- download magento2.3.5-p2.tar.gz from [Official Magento GitHub](https://github.com/magento/magento2/archive/refs/tags/2.3.5-p2.tar.gz)
- unpack tar.gz to www/magento2
- fix directory permission
- basic magento2 setup

## Testing
To test if server works, open <b>localhost</b> in your browser.
You can login to admin account in <b>localhost/admin</b>.  
<b>Login: admin</b>  
<b>Pass: admin123</b>

## Setup elasticsearch
In order to configure magento2 to use elasticsearch:
1. Login to admin account in <b>localhost/admin</b>.
2. Go to: <b>Stores > Settings > Configuration > Catalog > Catalog > Catalog Search</b>.
3. Change: 
- Search Engine: <b>Elasticsearch 7.0+</b>
- Elasticsearch Server Hostname: <b>elasticsearch</b>
4. Scroll down and click <b>Test Connection</b>.
5. Click <b>Save Config</b>.

## TODO
- [ ] write how to install prerequisites
- [ ] don't use pre-made variables, instead ask user for them
- [ ] tweak security
- [ ] server optimisation
- [ ] server scaling
- [ ] write some simple tests
- [ ] write guide how to expose server outside of local network

