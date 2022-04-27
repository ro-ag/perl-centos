FROM centos:7

ARG PERL_VERSION=5.32.1
ARG PKGS="jq wget nano gcc make which man-pages man-db man zlib readline openssl-libs openssl openssl-devel deltarpm"

RUN set -ex;\
    yum install epel-release -y;\
    yum update -y;\
    yum install -y ${PKGS};\
    yum clean all;\
    cd /tmp;\
    wget https://www.cpan.org/src/5.0/perl-${PERL_VERSION}.tar.gz;\
    tar -xzf perl-${PERL_VERSION}.tar.gz;\
    cd perl-${PERL_VERSION};\
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
    cpm install -g --show-build-log-on-failure App::cpanminus;\
    cpm install -g --show-build-log-on-failure Log::Log4perl;\ 
    cpm install -g --show-build-log-on-failure Term::ReadLine::Perl;\ 
    cpm install -g --show-build-log-on-failure Modern::Perl;\
    cpm install -g --show-build-log-on-failure Parallel::ForkManager;\
    cpm install -g --show-build-log-on-failure Task::Kensho::CLI;\
    cpm install -g --show-build-log-on-failure Task::Kensho::Config;\
    cpm install -g --show-build-log-on-failure Task::Kensho::DBDev;\
    cpm install -g --show-build-log-on-failure Task::Kensho::Dates;\
    cpm install -g --show-build-log-on-failure Task::Kensho::ExcelCSV;\
    cpm install -g --show-build-log-on-failure IO::All;\
    cpm install -g --show-build-log-on-failure Smart::Comments;\
    cpm install -g --show-build-log-on-failure Term::ProgressBar::Simple;\
    cpm install -g --show-build-log-on-failure Task::Kensho::Logging;\
    cpm install -g --show-build-log-on-failure Code::TidyAll;\
    cpm install -g --show-build-log-on-failure Module::Build::Tiny;\
    cpm install -g --show-build-log-on-failure Perl::Critic;\
    cpm install -g --show-build-log-on-failure Perl::Tidy;\
    cpm install -g --show-build-log-on-failure Pod::Readme;\
    cpm install -g --show-build-log-on-failure Software::License;\
    cpm install -g --show-build-log-on-failure Moo;\
    cpm install -g --show-build-log-on-failure Type::Tiny;\
    cpm install -g --show-build-log-on-failure Task::Kensho::Testing;\
    cpm install -g --show-build-log-on-failure Task::Kensho::Toolchain;\
    cpm install -g --show-build-log-on-failure Task::Kensho::WebCrawling;\
    cpm install -g --show-build-log-on-failure Template;\
    cpm install -g --show-build-log-on-failure XML::LibXML;\
    cpm install -g --show-build-log-on-failure XML::Generator::PerlData;\
    cpm install -g --show-build-log-on-failure XML::SAX;\
    cpm install -g --show-build-log-on-failure XML::SAX::Writer;\
    cpm install -g --show-build-log-on-failure IO::Prompter;\
    cpm install -g --show-build-log-on-failure Text::CSV;\
    cpm install -g --show-build-log-on-failure Net::SFTP;\
    cpm install -g --no-retry --show-build-log-on-failure Net::SSLeay;\
    cpm install -g --show-build-log-on-failure IO::Socket::SSL;\
    rm -rf /tmp/* ~/.perl-cpm;

COPY get-vscode-server.sh /get-vscode-server.sh

RUN set -ex;\
    chmod +x get-vscode-server.sh;\
    ./get-vscode-server.sh;\
    rm -f /tmp/*