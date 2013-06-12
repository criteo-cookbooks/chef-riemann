name              "riemann-server"
maintainer        "Cloudbau GmbH"
maintainer_email  "fillme"
license           "fillme"
description       "installs riemann_server"
version           "1.0.0"

recipe "riemann-server", "Installs and configures the riemann-server and riemann-dash"

depends "runit"
depends "java"
depends "rbenv", "1.4.2" #riotgames
