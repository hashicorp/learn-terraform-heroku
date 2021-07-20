## Demo NodeJS application

The application connects to a Postgres database and defines endpoints that allow you to insert and retrieve values from a test table.

If using locally, you can spin up a postgres instance in Docker using the following command.

```
docker run --name pg -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres
```