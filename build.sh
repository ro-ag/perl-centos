docker build --build-arg PERL_VERSION=5.32.1 -t rodagurto/centos-perl:5.32 .
docker build --build-arg PERL_VERSION=5.34.1 -t rodagurto/centos-perl:5.34 .

docker push rodagurto/centos-perl:5.34
docker push rodagurto/centos-perl:5.32