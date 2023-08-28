[Dynamic documentation](static.html)

firefox --new-tab `pwd`/src/site/resources/static.html
firefox --new-tab `pwd`/target/site/index.html

https://wiki.eclipse.org/EclipseLink/Examples/JPA/EclipseLink-ORM.XML
https://dzone.com/articles/persisting-entity-classes
https://www.objectdb.com/java/jpa/entity/persistence-unit
https://vladmihalcea.com/how-to-use-external-xml-mappings-files-outside-of-jar-with-jpa-and-hibernate/
http://java.sun.com/xml/ns/persistence/orm_2_0.xsd

export JAVA_HOME=/opt/jdk-14.0.1/ && export PATH=${JAVA_HOME}/bin:${PATH}
export JAVA_HOME=/opt/jdk-14.0.1/ && export PATH=${JAVA_HOME}/bin:${PATH}
export PATH=/opt/apache-maven-3.6.0/bin:$PATH

mvn cleaninstall &&
cd groovy-models && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd groovy-services && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd java-models && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd jwt-models && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd .. &&
cd springboot-start-project && mvn org.pitest:pitest-maven:mutationCoverage site:site && cd ..&&
cd submodules/setmy-info.github.io && mvn site:site && cd ..

1.

docker build -t setmyinfo/node-start-project .
npm run docker-build
docker run -p 4000:3000 -d setmyinfo/node-start-project
npm run docker-run

1.
    1. Micronaut microservice

docker build -t setmyinfo/micronaut-start-project:1.0.0-SNAPSHOT .
docker run -p 8010:8080 -d setmyinfo/micronaut-start-project:1.0.0-SNAPSHOT

1.2. Spring boot microservice
docker build -t setmyinfo/springboot-start-project:1.0.0-SNAPSHOT .
docker run -p 8020:8080 -d setmyinfo/springboot-start-project:1.0.0-SNAPSHOT

1.3. Tomcat web app
docker build -t setmyinfo/tomcat-start-project:1.0.0-SNAPSHOT .
docker run -p 8030:8080 -d setmyinfo/tomcat-start-project:1.0.0-SNAPSHOT

2. Or

   /opt/firefox/firefox --new-tab http://localhost:4000
   /opt/firefox/firefox --new-tab http://localhost:8010/rest/hello
   /opt/firefox/firefox --new-tab http://localhost:8020/rest/hello
   /opt/firefox/firefox --new-tab http://localhost:8020/api/example
   /opt/firefox/firefox --new-tab http://localhost:8030/tomcat-start-project-1.2.0-SNAPSHOT/
   /opt/firefox/firefox --new-tab http://localhost:8030/tomcat-start-project-1.2.0-SNAPSHOT/rest/hello
   /opt/firefox/firefox --new-tab http://localhost/tomcat-start-project/
   /opt/firefox/firefox --new-tab http://localhost/springboot-start-project/api/example
   /opt/firefox/firefox --new-tab http://localhost/springboot-start-project/rest/hello
   /opt/firefox/firefox --new-tab http://localhost/micronaut-start-project/rest/hello
   /opt/firefox/firefox --new-tab http://localhost/node-start-project/

3. Ports

   Service and debug ports

4. Golang Microservice

   docker build -t setmyinfo/go-start-project .
   docker run -p 8040:8080 -d setmyinfo/go-start-project

5. Karma

   Fro project:
   npm install karma karma-jasmine karma-chrome-launcher karma-firefox-launcher jasmine-core jasmine karma-html-reporter
   --save-dev
   Globaly:
   npm install -g karma-cli
   karma init karma.conf.js

6. Node main development tools set

   npm install -g bower grunt gulp karma-cli sass less typescript express-generator yarn jshint protractor karma-cli
   @hapi/joi @hapi/topo @hapi/hoek
   npm install -g @vue/cli
   npm install karma karma-coverage karma-junit-reporter --save-dev

7. Hexo.io

   hexo init hexo-test-blog
   cd hexo-test-blog
   npm install
   hexo server
   firefox --new-tab http://localhost:4000
   hexo generate

9. Logging

   https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html#data-to-exclude

10. Teamwork

    All or nothing.

11. Unsorted

* Välised webi API-d, teenused - alati läbi cacheva proxy API.
* Risk mitte maksta arveid võib tekitada riski, et andmed kustutatakse ära (Pilve puhul).
* Püüelda IDE-e funktsionaalsuse ärakasutamise suunas.
* Roles: Business analüütikud: should not write tables, SQL, Java class model in any form. Its implementing team members
  responsibility.
* Developer should have possibility to build current work on CI (push by push) to get feedback early. Without additional
  steps (clicks, tool usage).
* GIT should reflect reality and not fake result. Main/master/trunk should be releasable at eny moment without searching
  release tags, numbers somewhere.

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

### Questions for

'''
What was the last biggest waste you detected and eliminated.
What happens singl developer waste, problems?
Work culture and team dynamics:
How would you describe the work culture in this company/project?
How is teamwork and communication fostered?
What are the mutual expectations and collaboration methods among team members?

    Work process and methodology:
        What project management methodology is followed here (e.g., waterfall, Agile, Scrum)?
        How are projects planned and evaluated?
        How are tasks assigned and workflow managed?
        Is version control used, and are there code repositories?
        What are the testing and quality assurance processes?

    Development environment and tools:
        What development environments and tools are used?
        Are there any automation tools (e.g., CI/CD systems)?
        How are code reviews conducted, and how is feedback provided to developers?

    Career opportunities and growth:
        What are the opportunities for professional growth and training?
        Is support provided for attending internal or external events or certifications?
        Are there possibilities for career advancement and promotion?

    Flexibility and working conditions:
        How is work flexibility and working conditions organized?
        Is remote work or flexible scheduling possible?
        What are the policies regarding working hours, leave, and sick leave?

    For Architects:
        What is the architecture approach or design philosophy followed in this project/company?
        How are architectural decisions made, and how are they communicated to the development team?
        What are the key considerations when designing scalable and maintainable systems in this project/company?
        How do architects collaborate with developers to ensure the implementation aligns with the architectural vision?
        Are there any specific architectural challenges or areas of focus in this project?

    For Analysts:
        How is the requirements gathering process organized in this project/company?
        What techniques or tools are used for documenting and managing requirements?
        How are user stories or use cases typically created and prioritized?
        What role do analysts play in the development process and the interaction with developers?
        How are changes to requirements handled during the development lifecycle?

    For Product Owners:
        How are product roadmaps and feature backlogs managed in this project/company?
        What methodologies or frameworks are used for prioritizing and planning product features?
        How do product owners collaborate with stakeholders to gather feedback and validate product requirements?
        What is the decision-making process for accepting or rejecting feature requests or changes?
        How do product owners track and measure the success of product features or releases?

    For Architects:
        How are developers involved in architectural decision-making, and how do architectural decisions impact the development process?
        How do architects respond when developers propose suggestions or express concerns regarding architectural decisions or feasibility?
        What are the channels and processes through which developers can communicate with architects to reject requirements or ask questions?

    For Analysts:
        Do developers have the opportunity to provide input on requirements and functionality before they are finalized and documented?
        How is the collaboration between analysts and developers when developers identify inconsistencies or ambiguities in requirements?
        How is ongoing communication and collaboration ensured between developers and analysts to prevent misunderstandings or unfeasible requirements?

    For Product Owners:
        How are developers involved in the decision-making process for functional requirements and product ownership decisions?
        How do product owners respond when developers make suggestions or express concerns regarding the feasibility of product ownership decisions or requirements?
        What communication channels and processes are in place to allow developers to directly engage with product owners to clarify requirements or raise issues?

    For Architects:
        How are architectural decisions reviewed and validated to ensure they align with the project's requirements and goals?
        What measures are in place to identify and address architectural defects or shortcomings during the development process?
        How do architects collaborate with other team members to proactively identify and mitigate potential architectural defects?

    For Analysts:
        What processes are followed to verify the accuracy and completeness of requirements gathered by analysts?
        How are defects or inconsistencies in requirements identified and resolved during the analysis phase?
        How do analysts collaborate with developers to clarify requirements and prevent defects from being introduced during implementation?

    For Product Owners:
        How do product owners validate and verify requirements to ensure they meet the needs of stakeholders and end-users?
        How are defects or gaps in product requirements addressed and communicated to the development team?
        What steps are taken to gather feedback from the development team and iterate on requirements to minimize defects?

'''

Argo workflow - no. It's not handled by bigger consortium, not a standard by that consortium, not handled by IDE, too
young.

## Changelog

[keepachangelog.com](http://keepachangelog.com/)

## TODO Writing

[great documentation](http://jacobian.org/writing/what-to-write/)
