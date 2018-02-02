ARG     CENTOS_VER=latest
ARG     NAME=hdrocker

FROM    centos:${CENTOS_VER}

LABEL   name=$NAME \
        version="1.0" \
        summary="" \
        description="" \
        maintainer="Bhaskar Bhaumik <Bhaskar_Bhaumik@homedepot.com>" \
        version="1.0"

ENV     container="docker" \
        LC_ALL="en_US.UTF-8" \
        LANG="en_US.UTF-8" \
        PATH="/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
        TERM="xterm"

# Copy various packages and installers to base image
COPY    resources /tmp/hdrocker/resources

# Set working directory
WORKDIR /tmp/hdrocker/resources

# Expose standard ports (3838 for Shiny server, 6311 for Rserve and 8787 for R Studio)
EXPOSE  3838 6311 8787

# Update CentOS base packages and install some additional but required packages
RUN     /bin/bash -c ./install-syspkgs.sh

# Install various R packages
RUN     /bin/bash -c ./install-rpkgs.sh

# Setup unix user and groups and user relates configs
RUN     /bin/bash -c ./config-usergrps.sh

# Start RStudio server process with user radmin
USER    radmin:radmin
RUN     /bin/bash -c ./start-rstudio.sh

# Start RStudio process with user rserv
USER    rserv:rserv
RUN     /bin/bash -c ./start-rserv.sh

# Start Shiny server process with user shiny
USER    radmin:radmin
RUN     /bin/bash -c ./start-shiny.sh

# Start shell/R under ruser
USER    ruser:rusers
CMD ["/bin/bash"]
