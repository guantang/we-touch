set MAVEN_OPTS= -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8080,server=y,suspend=n -Xms128m -Xmx512m -XX:MaxPermSize=256m
echo %MAVEN_OPTS%
call mvn clean -Ptest
mvn jetty:run -Ptest -Dspring.profiles.active=test