FROM quay.io/centos/centos:stream9

RUN dnf update -y &&\
    dnf install -y dnf-plugins-core.noarch &&\
    dnf config-manager --set-enabled appstream crb &&\
    dnf install -y coreutils-common rpmdevtools findutils git pyproject-rpm-macros vim-enhanced wget &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    mkdir /root/.bashrc.d

COPY files/bashrc /root/.bashrc
COPY files/bashrc-centos /root/.bashrc.d/centos

# set login directory
WORKDIR /root

CMD ["/bin/bash"]
