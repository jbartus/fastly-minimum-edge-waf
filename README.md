# minimum terraform edgewaf

## what
a bare minimum syntax example for getting a vcl+edgewaf service setup in front of a site

the vcl service is configured to pass all traffic (not cache)

the waf site is configured to log attacks (not block)

this provides traffic graphs in the fastly ui, and attack data in the sigsci ui, without affecting traffic

## howto
```
git clone https://github.com/jbartus/mtfew.git
cd mtfew/
terraform init
export FASTLY_API_KEY=
export SIGSCI_CORP=
export SIGSCI_EMAIL=
export SIGSCI_TOKEN=
terraform apply
```