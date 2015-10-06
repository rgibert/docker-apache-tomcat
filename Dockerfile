FROM rgibert/openjdk-jre
MAINTAINER Richard Gibert <richard@gibert.ca>
ENV TOMCAT_VER=8.0.27
ENV TOMCAT_MIRROR=http://apache.mirror.iweb.ca/tomcat
ENV CATALINA_HOME=var/lib/apache-tomcat
ENV CATALINA_BASE=/usr/local/share/apache-tomcat
RUN TOMCAT_MAJOR_VER=`echo ${TOMCAT_VER} | awk -F"." '{print $1}'` && \
    apk-install \
        bash \
        && \
    cd /usr/local/share && \
    wget ${TOMCAT_MIRROR}/tomcat-${TOMCAT_MAJOR_VER}/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz && \
    tar -zxf apache-tomcat-${TOMCAT_VER}.tar.gz && \
    rm -f apache-tomcat-${TOMCAT_VER}.tar.gz && \
    ln -s ${CATALINA_BASE}-${TOMCAT_VER} ${CATALINA_BASE} && \
    mkdir -p \
        /${CATALINA_HOME}/conf \
        /${CATALINA_HOME}/bin \
        /${CATALINA_HOME}/work \
        /${CATALINA_HOME}/lib \
        /${CATALINA_HOME}/webapps \
        /${CATALINA_HOME}/logs \
        /${CATALINA_HOME}/temp \
        && \
    ln -sf ${CATALINA_BASE}/bin/tomcat-juli.jar /${CATALINA_HOME}/bin/tomcat-juli.jar && \
    ln -sf ${CATALINA_BASE}/bin/catalina.sh /${CATALINA_HOME}/bin/catalina.sh && \
    ln -sf ${CATALINA_BASE}/bin/daemon.sh /${CATALINA_HOME}/bin/daemon.sh && \
    ln -sf ${CATALINA_BASE}/bin/digest.sh /${CATALINA_HOME}/bin/digest.sh && \
    ln -sf ${CATALINA_BASE}/bin/setclasspath.sh /${CATALINA_HOME}/bin/setclasspath.sh && \
    ln -sf ${CATALINA_BASE}/bin/shutdown.sh /${CATALINA_HOME}/bin/shutdown.sh && \
    ln -sf ${CATALINA_BASE}/bin/startup.sh /${CATALINA_HOME}/bin/startup.sh && \
    ln -sf ${CATALINA_BASE}/bin/tool-wrapper.sh /${CATALINA_HOME}/bin/tool-wrapper.sh && \
    ln -sf ${CATALINA_BASE}/bin/version.sh /${CATALINA_HOME}/bin/version.sh && \
    ln -sf ${CATALINA_BASE}/conf/catalina.properties /${CATALINA_HOME}/conf/catalina.properties && \
    ln -sf ${CATALINA_BASE}/conf/logging.properties /${CATALINA_HOME}/conf/logging.properties && \
    ln -sf ${CATALINA_BASE}/conf/web.xml /${CATALINA_HOME}/conf/web.xml
COPY usr/local/bin/entrypoint /usr/local/bin/entrypoint
COPY ${CATALINA_HOME}/bin/setenv.sh /${CATALINA_HOME}/bin/setenv.sh
COPY ${CATALINA_HOME}/conf/server.xml /${CATALINA_HOME}/conf/server.xml
COPY ${CATALINA_HOME}/conf/context.xml /${CATALINA_HOME}/conf/context.xml
RUN adduser -s /bin/false -D tomcat && \
    chown -R tomcat:tomcat /${CATALINA_HOME}
EXPOSE 8009 8080 8443
VOLUME ${CATALINA_HOME}/logs
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
CMD [ "tomcat" ]

