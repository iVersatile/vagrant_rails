maintainer        "Rabble Media, LLC"
maintainer_email  "dave@rabblemedia.net"
license           "Apache 2.0"
description       "Installs passenger for nginx"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.99"

recipe "passenger_nginx", "Installs Passenger as an nginx module"
recipe "passenger_nginx::msource", "Installs Passenger as an nginx module, allowing for other modules to be compiled in"

depends "build-essential"

%w{ redhat centos ubuntu debian arch }.each do |os|
  supports os
end
