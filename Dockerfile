FROM centos:7.5.1804

# system update
RUN yum -y update && yum clean all

# set locale
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

# editor install
RUN yum install -y vim && yum clean all
RUN mkdir /isucon

# start isucon setup
WORKDIR /isucon

RUN yum groupinstall 'Development tools' -y && \
  yum install git openssl-devel readline-devel zlib-devel mysql mysql-devel -y

RUN git clone https://github.com/tagomoris/xbuild.git

ENV PATH /root/local/ruby/bin:/root/local/go/bin:/root/go/bin:$PATH

RUN mkdir local

RUN xbuild/go-install     1.10.3  $HOME/local/go
RUN xbuild/ruby-install   2.5.1   $HOME/local/ruby -f

RUN gem update --system
RUN gem install bundler -v 1.16.4

COPY . /isucon

RUN cd /isucon/bench && make deps && make

CMD tail -f /dev/null
