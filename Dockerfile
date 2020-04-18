FROM ubuntu:18.04
ARG UID=65587
#コンフリクトしないように大きい値で
RUN sed -i"" -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends sudo \
&& rm -rf /tmp/* /var/tmp/* \
&& apt-get clean
# 依存関係をインストールする

RUN echo "root:root" | chpasswd && \
    adduser --disabled-password --uid ${UID} --gecos "" docker && \
    echo "docker:docker" | chpasswd && \
    echo "%docker    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/docker && \
    chmod 0440 /etc/sudoers.d/docker
#sudoがパスワード入力無しで使えるユーザの作成

RUN mkdir -p /debuild/build /deb
COPY ./debuild.sh /debuild/debuild.sh
RUN chmod +x /debuild/debuild.sh \
&& chown -R docker:docker /debuild
USER ${UID}
WORKDIR /debuild
#CMD ["./debuild.sh"]
