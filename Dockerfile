FROM centos:7

ARG PERL_VERSION=perl-5.34.1
ARG PKGS="jq wget nano gcc make which man-pages man-db man zlib readline openssl-libs openssl openssl-devel deltarpm"

RUN set -ex;\
    yum install epel-release -y;\
    yum update -y;\
    yum install -y ${PKGS};\
    yum clean all;\
    cd /tmp;\
    wget https://www.cpan.org/src/5.0/${PERL_VERSION}.tar.gz;\
    tar -xzf ${PERL_VERSION}.tar.gz;\
    cd ${PERL_VERSION};\
    ./Configure -des -Dprefix=/perl -Dusethreads;\
    make -j 16;\
    TEST_JOBS=16 make test_harness;\
    make install;\
    rm -rf /tmp/*;

# Install Extras

ENV PATH=/perl/bin:${PATH} 
RUN set -ex;\
    cd /tmp;\
    curl -fsSL https://git.io/cpm | perl - install -g App::cpm;\
    #curl -L http://cpanmin.us | perl - App::cpanminus;\
    cpm install --show-build-log-on-failure App::cpanminus;\
    cpm install --show-build-log-on-failure Log::Log4perl;\ 
    cpm install --show-build-log-on-failure Term::ReadLine::Perl;\ 
    cpm install --show-build-log-on-failure Modern::Perl;\
    cpm install --show-build-log-on-failure Parallel::ForkManager;\
    cpm install --show-build-log-on-failure Task::Kensho::CLI;\
    cpm install --show-build-log-on-failure Task::Kensho::Config;\
    cpm install --show-build-log-on-failure Task::Kensho::DBDev;\
    cpm install --show-build-log-on-failure Task::Kensho::Dates;\
    cpm install --show-build-log-on-failure Task::Kensho::ExcelCSV;\
    cpm install --show-build-log-on-failure IO::All;\
    cpm install --show-build-log-on-failure Smart::Comments;\
    cpm install --show-build-log-on-failure Term::ProgressBar::Simple;\
    cpm install --show-build-log-on-failure Task::Kensho::Logging;\
    cpm install --show-build-log-on-failure Code::TidyAll;\
    cpm install --show-build-log-on-failure Module::Build::Tiny;\
    cpm install --show-build-log-on-failure Perl::Critic;\
    cpm install --show-build-log-on-failure Perl::Tidy;\
    cpm install --show-build-log-on-failure Pod::Readme;\
    cpm install --show-build-log-on-failure Software::License;\
    cpm install --show-build-log-on-failure Moo;\
    cpm install --show-build-log-on-failure Type::Tiny;\
    cpm install --show-build-log-on-failure Task::Kensho::Testing;\
    cpm install --show-build-log-on-failure Task::Kensho::Toolchain;\
    cpm install --show-build-log-on-failure Task::Kensho::WebCrawling;\
    cpm install --show-build-log-on-failure Template;\
    cpm install --show-build-log-on-failure XML::LibXML;\
    cpm install --show-build-log-on-failure XML::Generator::PerlData;\
    cpm install --show-build-log-on-failure XML::SAX;\
    cpm install --show-build-log-on-failure XML::SAX::Writer;\
    cpm install --show-build-log-on-failure IO::Prompter;\
    cpm install --show-build-log-on-failure Text::CSV;\
    cpm install --show-build-log-on-failure Net::SFTP;\
    cpm install --no-retry --show-build-log-on-failure Net::SSLeay;\
    cpm install --show-build-log-on-failure IO::Socket::SSL;\
    rm -rf /tmp/* ~/.perl-cpm;

WORKDIR /tmp

COPY get-vscode-server.sh .

RUN set -ex;\
    chmod +x get-vscode-server.sh;\
    ./get-vscode-server.sh