# colisee-db
[![Travis](https://img.shields.io/travis/siggame/colisee-db.svg?style=flat-square)](https://travis-ci.org/siggame/colisee-db) [![Code Climate](https://img.shields.io/codeclimate/github/siggame/colisee-db.svg?style=flat-square)](https://codeclimate.com/github/siggame/colisee-db) [![David](https://img.shields.io/david/siggame/colisee-db.svg?style=flat-square)]() [![Docker Pulls](https://img.shields.io/docker/pulls/siggame/colisee-db.svg?style=flat-square)](https://hub.docker.com/r/siggame/colisee-db/) [![GitHub release](https://img.shields.io/github/release/siggame/colisee-db.svg?style=flat-square)](https://github.com/siggame/colisee-db/releases)  

Microservice containing the PostgreSQL Database for the Arena and Web.

## Using colisee-db

```bash
docker pull siggame/colisee-db:<TAG>

docker run --name <SERVICE-NAME> --publish 5432:<HOST-PORT> --detach siggame/colisee-db:<TAG>
```

We currently have a `stable` and `latest` release for this service. Replace `<TAG>` above with either release name depending on your needs. The `stable` release is recommended.
