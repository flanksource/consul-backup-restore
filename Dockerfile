FROM consul:1.7.1

RUN apk -v --update add \
        bash \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    mkdir /scripts

COPY backup.sh scripts/backup.sh
COPY restore.sh scripts/restore.sh

WORKDIR /scripts

ENTRYPOINT ["/bin/bash"]
