# MariaDB Sales Schema

This is a MariaDB schema for tests and examples.

Have fun with it and please contribute.


## Project Purpose and Guidelines

This schema is designed for tests and examples.

Some possible use cases are the following:

- Students and new users can use it to understand database design good practices.
- Tools and library developers can use it to test support for various
  MariaDB features.
- Developers and database professionals can use it to experiment with
  various MariaDB features.
- It can be used to test the impact on some indexing practices or some other
  features on MariaDB performance.
- Easily writing examples for training courses, blog posts, books, etc.

In general, we should follow the good practices and use advanced features
for a high-quality OLTP schema. But since part of our goals is testing
performance and features, we'll also include more common practices, and
even some poor design practices. We will document poor practices used.


## Setup

To create this schema, run `schemas.sql` through the mariadb CLI client.
To avoid confusion, remember: MariaDB is the database server, whereas
mariadb (lowercase) is the CLI client that is usually installed with MariaDB.

Make sure to pass your MariaDB credentials to the client in one of these ways:

- If you are `root` in MariaDB and you're logged into the local Linux OS as `root`,
  you probably won't need to specify any credentials. By default, local `root`
  connections are authenticated via
  [UNIX_SOCKET](https://mariadb.com/docs/server/reference/plugins/authentication-plugins/authentication-plugin-unix-socket).
- Otherwise, make sure that the credentials are set in your user's home directory's
  `.my.ini` or in `/etc/mysql/my.ini`. See the
  [documentation](https://mariadb.com/docs/server/server-management/install-and-upgrade-mariadb/configuring-mariadb/configuring-mariadb-with-option-files).
- Alternartively, you can pass the credentials to mariadb using CLI options.
  See the
  [documentation](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client/mariadb-command-line-client).

To pass the `schema.sql` file to mariadb, run:

```
mariadb [credentials] < schema.sql
```

Some people are uncomfortable with mariadb's interface.

Before switching to a GUI or a web UI, try [mycli](https://www.mycli.net/).
It's still a CLI, but it provides user-friendly features like autocompletion, syntax
highlighting, and saved queries. The usage is very similar.
To pass the `schema.sql` file to mariadb, run:

```
mycli [credentials] < schema.sql
```


## Credits

This schema was developed by [vettabase](https://vettabase.com).

Current maintainer: [Federico Razzoli](federico.razzoli@vettabase.com).

Contributions are welcome.


## Copyright and Lucense

License: GNU Affero GPL v3. See the `LICENSE` file.

SPDX: [AGPL-3.0-only](http://spdx.org/licenses/AGPL-3.0-only.html).

Copyright Vettabase Ltd 2025

