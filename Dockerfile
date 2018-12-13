FROM lambci/lambda:build-nodejs8.10

RUN yum -y install R \
 && yum clean all \
 && curl -Lo txtplot_1.0-3.tar.gz https://cran.r-project.org/src/contrib/txtplot_1.0-3.tar.gz \
 && R CMD INSTALL txtplot_1.0-3.tar.gz \
 && rm txtplot_1.0-3.tar.gz
