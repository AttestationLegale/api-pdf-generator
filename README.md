# pdf-generator

[![badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/ALGMachine/76211039a484570425e2c336e01a53f4/raw/badge_api_pdf_generator_deployment_production.json)](https://github.com/AttestationLegale/api-pdf-generator/actions)

[![badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/ALGMachine/582fdbdc0cc4dc93908b1175f5cd56d8/raw/badge_api_pdf_generator_deployment_staging.json)](https://github.com/AttestationLegale/api-pdf-generator/actions)

[![badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/ALGMachine/891c66600c9a6b36b3de73247bc9138f/raw/badge_api_pdf_generator_deployment_integration.json)](https://github.com/AttestationLegale/api-pdf-generator/actions)

[![badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/ALGMachine/43db75352a092a75b0f68d8c0cf32171/raw/badge_api_pdf_generator_deployment_demo.json)](https://github.com/AttestationLegale/api-pdf-generator/actions)

The documentation is available here: https://confluence.attestationlegale.fr/display/OFA/PDF+Generator

This application was generated using JHipster 4.5.3, you can find documentation and help at [https://jhipster.github.io/documentation-archive/v4.5.3](https://jhipster.github.io/documentation-archive/v4.5.3).

This is a "microservice" application intended to be part of a microservice architecture, please refer to the [Doing microservices with JHipster][] page of the documentation for more information.

This application is configured for Service Discovery and Configuration with the JHipster-Registry. On launch, it will refuse to start if it is not able to connect to the JHipster-Registry at [http://localhost:8761](http://localhost:8761). For more information, read our documentation on [Service Discovery and Configuration with the JHipster-Registry][].


To start your application in the dev profile, simply run:

    ./mvnw


For further instructions on how to develop with JHipster, have a look at [Using JHipster in development][].


You can also use [Angular CLI][] to generate some custom client code.

For example, the following command:

    ng generate component my-component

will generate few files:

    create src/main/webapp/app/my-component/my-component.component.html
    create src/main/webapp/app/my-component/my-component.component.ts
    update src/main/webapp/app/app.module.ts


To optimize the pdf-generator application for production, run:

    ./mvnw -Pprod clean package

To ensure everything worked, run:

    java -jar target/*.war


Refer to [Using JHipster in production][] for more details.


To launch your application's tests, run:

    ./mvnw clean test

For more information, refer to the [Running tests page][].


You can use Docker to improve your JHipster development experience. A number of docker-compose configuration are available in the [src/main/docker](src/main/docker) folder to launch required third party services.
For example, to start a postgresql database in a docker container, run:

    docker-compose -f src/main/docker/postgresql.yml up -d

To stop it and remove the container, run:

    docker-compose -f src/main/docker/postgresql.yml down

You can also fully dockerize your application and all the services that it depends on.
To achieve this, first build a docker image of your app by running:

    ./mvnw package -Pprod docker:build

Then run:

    docker-compose -f src/main/docker/app.yml up -d

For more information refer to [Using Docker and Docker-Compose][], this page also contains information on the docker-compose sub-generator (`jhipster docker-compose`), which is able to generate docker configurations for one or several JHipster applications.


To configure CI for your project, run the ci-cd sub-generator (`jhipster ci-cd`), this will let you generate configuration files for a number of Continuous Integration systems. Consult the [Setting up Continuous Integration][] page for more information.

[JHipster Homepage and latest documentation]: https://jhipster.github.io
[JHipster 4.5.3 archive]: https://jhipster.github.io/documentation-archive/v4.5.3
[Doing microservices with JHipster]: https://jhipster.github.io/documentation-archive/v4.5.3/microservices-architecture/
[Using JHipster in development]: https://jhipster.github.io/documentation-archive/v4.5.3/development/
[Service Discovery and Configuration with the JHipster-Registry]: https://jhipster.github.io/documentation-archive/v4.5.3/microservices-architecture/#jhipster-registry
[Using Docker and Docker-Compose]: https://jhipster.github.io/documentation-archive/v4.5.3/docker-compose
[Using JHipster in production]: https://jhipster.github.io/documentation-archive/v4.5.3/production/
[Running tests page]: https://jhipster.github.io/documentation-archive/v4.5.3/running-tests/
[Setting up Continuous Integration]: https://jhipster.github.io/documentation-archive/v4.5.3/setting-up-ci/

## Github actions

Hosted in `.github` folder. Available in the Actions tab in Github repository.
You can test actions locally using [ACT](https://github.com/nektos/act)

Example:

    ```bash
    # List workflows
    act -l

    # Trigger workflow
    # Using 'nektos/act-environments-ubuntu:18.04' ensures having ~runner as Github, bt it is 18 GB
    # NEVER COMMIT YOUR SECRETS FILES
    # .github/workflows/build.secrets contains all secrets needed (like in repo's secrets)
    # .github/workflows/events/ofa_build_java.event replaces workflows inputs (mandatory in local)
    act workflow_dispatch -P ubuntu-latest=nektos/act-environments-ubuntu:18.04 --secret-file .github/workflows/build.secrets -W .github/workflows/ofa_build_java.yml -e .github/workflows/events/ofa_build_java.event
    ```
