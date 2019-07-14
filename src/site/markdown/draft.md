[Dynamic documentation](static.html)

http://www.doclo.be/lieven/articles/personalsitewithmaven.html

mvn archetype:create   
   -DgroupId=mygroup   
   -DartifactId=mywebsite  
   -DarchetypeArtifactId=maven-archetype-site-simple

https://dzone.com/articles/how-publish-maven-site-docs

firefox --new-tab `pwd`/src/site/resources/static.html
firefox --new-tab `pwd`/target/site/index.html

https://wiki.eclipse.org/EclipseLink/Examples/JPA/EclipseLink-ORM.XML
https://dzone.com/articles/persisting-entity-classes
https://www.objectdb.com/java/jpa/entity/persistence-unit
https://vladmihalcea.com/how-to-use-external-xml-mappings-files-outside-of-jar-with-jpa-and-hibernate/
http://java.sun.com/xml/ns/persistence/orm_2_0.xsd

export JAVA_HOME=/opt/jdk-11.0.2/ && export PATH=${JAVA_HOME}/bin:${PATH}
export JAVA_HOME=/opt/jdk-12/ && export PATH=${JAVA_HOME}/bin:${PATH}
export PATH=/opt/apache-maven-3.6.0/bin:$PATH

mvn cleaninstall &&
cd groovy-models && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd groovy-services && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd java-models && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd jwt-models && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd springboot-start-project && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd ..&&
cd documentation && mvn site:site && cd ..

1.
    docker build -t setmyinfo/node-start-project .
        npm run docker-build
    docker run -p 4000:3000 -d setmyinfo/node-start-project
        npm run docker-run

2. Or
    firefox --new-tab http://localhost:4000
    firefox --new-tab http://localhost:8010/rest/hello
    firefox --new-tab http://localhost:8020/rest/hello
    firefox --new-tab http://localhost:8020/api/example
    firefox --new-tab http://localhost:8030/tomcat-start-project-1.2.0-SNAPSHOT/
    firefox --new-tab http://localhost:8030/tomcat-start-project-1.2.0-SNAPSHOT/rest/hello
    firefox --new-tab http://localhost/tomcat-start-project/
    firefox --new-tab http://localhost/springboot-start-project/api/example
    firefox --new-tab http://localhost/springboot-start-project/rest/hello
    firefox --new-tab http://localhost/micronaut-start-project/rest/hello
    firefox --new-tab http://localhost/node-start-project/

3. Ports
    Service and debug ports

4. Golang Microservice

    docker build -t setmyinfo/go-start-project .
    docker run -p 8040:8080 -d  setmyinfo/go-start-project

5. Karma
    Fro project:
        npm install karma karma-jasmine karma-chrome-launcher karma-firefox-launcher jasmine-core jasmine karma-html-reporter --save-dev
    Globaly:
        npm install -g karma-cli
        karma init karma.conf.js

6. Node main development tools set
    npm install -g bower grunt gulp karma-cli sass less typescript express-generator yarn jshint protractor karma-cli @hapi/joi @hapi/topo @hapi/hoek
    npm install -g @vue/cli
    npm install karma karma-coverage karma-junit-reporter --save-dev
