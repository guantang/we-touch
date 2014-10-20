#! /bin/sh
cd ../
cd ../core
mvn clean -P test
mvn -P prod -Dmaven.test.skip=true
cd ../web
mvn clean -P test
mvn package -P prod -D maven.test.skip=true
cp target/wetouch-1.0.x.war target/wetouch.war
cp target/wetouch-1.0.x.war target/wetouch.zip
cd bin
