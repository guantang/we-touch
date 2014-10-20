#! /bin/sh
MAVEN_OPTS='-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=4000,server=y,suspend=n -Xms128m -Xmx512m -XX:MaxPermSize=256m'
export MAVEN_OPTS
echo $MAVEN_OPTS
mvn clean -P test
mvn jetty:run -P test -Dspring.profiles.active=test
