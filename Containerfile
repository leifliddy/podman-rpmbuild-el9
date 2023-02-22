FROM docker.io/library/rockylinux:9

RUN dnf update -y &&\
    dnf install -y dnf-plugins-core &&\
    dnf config-manager --set-enabled appstream crb &&\
    dnf install -y bash-completion coreutils-common epel-release rpmdevtools findutils git pyproject-rpm-macros vim-enhanced wget &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo "defaultyes=True" >> /etc/dnf/dnf.conf &&\
    mkdir /root/.bashrc.d

COPY files/bashrc /root/.bashrc
COPY files/bashrc-default /root/.bashrc.d/default
COPY files/bashrc-rpmbuild /root/.bashrc.d/rpmbuild
COPY files/rpmmacros /root/.rpmmacros

# set login directory
WORKDIR /root

CMD ["/bin/bash"]
