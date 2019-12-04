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

1. 1. Micronaut microservice

    docker build -t setmyinfo/micronaut-start-project:1.0.0-SNAPSHOT .
    docker run -p 8010:8080 -d setmyinfo/micronaut-start-project:1.0.0-SNAPSHOT
        
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

7. Hexo.io

    hexo init hexo-test-blog
    cd hexo-test-blog
    npm install
    hexo server
    firefox --new-tab http://localhost:4000
    hexo generate

8. Process

    Steps
    Artifacts
    Roles

    Planning (ideas, refinement, PoC/Spike, architecture)
    Implementation
    Testing
    Releasing

9. Logging

    https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html#data-to-exclude

10. Teamwork

    All or nothing.
    One team, not many separated with separated poards for one task.
    Shortest bath.
    No more, no less.
    Describing somewhere else, then testing somewhere else - not in the end of the sprint.

## Test Task

### Questions for VueJS architects

    1.1 What other frameworks you know? What else have you used as frontend framework?
    1.2 Do you have experience with Angular 1.x? Yes: do you know controllers, services, values, resources? Describe what for they are?
    1.3 Yes: Do you know angular-classy? What you think about similarities and differencies VueJS and (angular + angular-classy)
    2. Describe your project, where you used VueJS. Hardest problem you solved there?
    3. Are you familiar with: Webpack, JasmineJS, Karma, Protractor?
    4. Which testing frameworks you use in VueJS projects?
    5. How you usually organize your VueJS project? What is where?
    6. What is for you VueJs component? Is it always visual (visible or hiddable) element?
    7. Your preferred process to apply UX design? Who, what, when and how should do?
    8. If you have free will to apply requirements for UX desing, whate are these? What are your requirements for that?
    9. If you have requirement, that we have 3 layers (controller, service, resource): how you implement service layer in VueJS project?
    10. REST is returning following item object: "{isVisible: "No", firstName: "Imre", "Tabur"}". You should shouw that item data depending of isVisible.
        What you write into template, how it wol look like?

## Wiki documentation hierarchy

    Business
        Projects (timely)
            Commons
                Analysis
            ABC
                Analysis
    IT
        People (roles, locations, vacations, etc)
        Process
            Scrum (Per team, optional)
                Team
                Planning
                Refinements (optional)
                Sprints
                Retrospectives
            Kanban (Optional)
            Other meetings (meeting notes, etc)
            Testing (optional, plans, specs)
        Architecture
            Decisions
                PoC & Spikes
            Enterprise architecture
                Environments
            Components/Modules/Projects (Module or component or app or library as Project)
                Commons and overview
                    Architecture
                    Requirements
                    Development notes
                    QA: test guides and specifications
                    Release notes
                    Deployment notes
                    Maintenance
                XYZ
                    Architecture
                    Requirements
                    Development notes
                    QA: test guides and specifications
                    Release notes
                    Deployment notes
                    Maintenance
                ...
        Knowledge
            Tool xyz
        