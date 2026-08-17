# Elixir

## Information

Elixir is a functional, concurrent, and fault-tolerant programming language built on the Erlang VM (BEAM). It was
created by José Valim and first released in 2012. Elixir inherits Erlang's actor-model concurrency, distributed system
capabilities, and legendary fault tolerance, while providing a modern Ruby-inspired syntax and a rich macro system.

Common use cases: web APIs (Phoenix framework), real-time systems (Phoenix Channels / LiveView), embedded systems
([Nerves](nerves.md)), data pipelines (Broadway), IoT (Tortoise MQTT).

## Installation

### Rocky Linux

Package manager:

```shell
sudo dnf install -y elixir erlang
elixir --version
```

Build from source (latest stable):

```shell
cd ~/sources/others
git clone https://github.com/elixir-lang/elixir.git elixir
cd elixir

LATEST_TAG=$(git tag --sort=-version:refname \
  | grep '^v' \
  | grep -v -- '-rc' \
  | grep -v -- '-alpha' \
  | grep -v -- '-beta' \
  | head -n 1)
ELIXIR_VERSION=${LATEST_TAG#v}
echo "Latest Elixir stable tag: $LATEST_TAG ($ELIXIR_VERSION)"
git checkout "$LATEST_TAG"

make clean compile
sudo mkdir -p /opt/elixir-${ELIXIR_VERSION}
sudo cp -r . /opt/elixir-${ELIXIR_VERSION}
```

### Fedora

```shell
sudo dnf install -y elixir erlang
```

### Debian

```shell
sudo apt install -y elixir erlang
```

### FreeBSD

```shell
pkg install elixir
```

## Configuration

Elixir projects are managed with **Mix** (the build tool bundled with Elixir):

```shell
mix new my_project          # create a new project
cd my_project
mix deps.get                # install dependencies (from mix.exs)
mix compile                 # compile
mix test                    # run tests
```

`mix.exs` is the project manifest — defines dependencies (`deps/0`), application name, and version.

`hex` is the package manager:

```shell
mix hex.info                # check hex is available
mix hex.search phoenix      # search packages
```

`.iex.exs` in your home directory or project root is loaded when starting `iex` — use it for convenience aliases and
module imports:

```elixir
# ~/.iex.exs
IEx.configure(
    inspect: [
        limit: 50
    ]
)
```

## Usage, tips and tricks

Interactive shell:

```shell
iex          # start REPL
iex -S mix   # start REPL with project loaded
```

Create and run a Phoenix project:

```shell
mix archive.install hex phx_new
mix phx.new my_web_app
cd my_web_app
mix deps.get
mix phx.server
```

Functional programming patterns with the pipe operator:

```elixir
defmodule FPPatterns do
    def add1(x), do: x + 1
    def double(x), do: x * 2

    def composition_example(x) do
        x
        |> add1()
        |> double()
    end

    def map_filter_reduce(list) do
        list
        |> Enum.map(fn x -> x * 2 end)
        |> Enum.filter(fn x -> x > 4 end)
        |> Enum.reduce(0, fn x, acc -> x + acc end)
    end
end
```

Result/error flow (railway-oriented programming):

```elixir
def result_pipeline(x) do
    with {:ok, a} <- step1(x),
         {:ok, b} <- step2(a),
         {:ok, c} <- step3(b) do
        {:ok, c}
    end
end
```

### Distributed Elixir

Elixir inherits Erlang's powerful distribution model. Multiple nodes (e.g., `alice@host` and `bob@host`) can be
connected to each other. Once connected, if a process is registered or a module exists on one node, the other node can
make remote calls (using `:rpc.call`, `Node.spawn`, `GenServer.call`, etc.). This is quite common in the Elixir world.

### Real-time Communication with Phoenix

For web applications requiring real-time interaction:

*   **Phoenix Channels**: Enables soft real-time communication between clients and the server, typically using WebSockets.
*   **Phoenix LiveView**: Allows building rich, interactive user interfaces with server-rendered HTML and real-time updates, significantly reducing the need for complex client-side JavaScript.

## Most Common Production Technologies (2026)

### Core Data & Database Layer

| Name       | Description                                                      |
|------------|------------------------------------------------------------------|
| Ecto       | Standard database toolkit — query building, schemas, migrations  |
| PostgreSQL | Primary relational database in most Elixir production systems    |
| ETS        | High-performance in-memory key-value store for caching and state |

### Web, API & Framework Layer

| Name              | Description                                                  |
|-------------------|--------------------------------------------------------------|
| Phoenix Framework | Main web framework for APIs, MVC apps, and real-time systems |
| Phoenix LiveView  | Real-time server-rendered UI without a JavaScript SPA        |
| Phoenix Channels  | WebSocket-based real-time communication layer                |

### Authentication & Security

| Name     | Description                                            |
|----------|--------------------------------------------------------|
| Joken    | Elixir library for encoding and verifying JWT tokens   |
| Guardian | Authentication library for Phoenix using JWT pipelines |
| Keycloak | SSO / OAuth2 / OpenID Connect identity provider        |

### Background Jobs & Messaging

| Name     | Description                                              |
|----------|----------------------------------------------------------|
| Oban     | Production job processing library built on PostgreSQL    |
| Broadway | Data ingestion and streaming pipeline (Kafka, SQS, etc.) |
| Tortoise | MQTT client for IoT and messaging                        |

### Testing

| Name       | Description                               |
|------------|-------------------------------------------|
| ExUnit     | Built-in testing framework                |
| Mox        | Mocking library based on behaviours       |
| StreamData | Property-based testing (QuickCheck style) |
| Hound      | Selenium framework for browser automation |

## Secure SQL Practices in Elixir: A Comprehensive Guide to Preventing SQL Injection

### Introduction

SQL Injection remains one of the most common and dangerous application security vulnerabilities. It occurs when
untrusted user input is incorrectly incorporated into SQL statements, allowing attackers to modify the intended query
logic.

Modern Elixir applications usually interact with databases through **Ecto**, the official database wrapper and query
toolkit for Elixir. When used correctly, Ecto provides strong protection against SQL Injection by relying on:

* Parameterized queries
* Prepared statements
* Query composition
* Safe query APIs
* Database driver escaping mechanisms

This guide explains how to build SQL-injection-resistant Elixir applications and how to maintain security when advanced
database features require custom SQL.

---

## 1. The Core Security Principle

The fundamental rule:

> Never mix untrusted user input directly into SQL code.

SQL contains two different types of information:

1. **SQL structure**

    * Keywords
    * Table names
    * Column names
    * Operators
    * Sorting rules

2. **Data values**

    * Usernames
    * Emails
    * Search terms
    * IDs
    * Form inputs

Only data values should come from users.

Example of unsafe SQL:

```elixir
username = params["username"]

sql =
    "SELECT * FROM users WHERE username = '" <>
    username <>
    "'"
```

An attacker could submit:

```text
admin' OR '1'='1
```

The generated SQL becomes:

```sql
SELECT *
FROM users
WHERE username = 'admin'
   OR '1' = '1'
```

The attacker has changed the query logic.

---

## 2. Use Ecto Query DSL

The preferred solution in Elixir is to use Ecto's query API.

Example:

```elixir
import Ecto.Query

query =
    from u in User,
         where: u.username == ^username

Repo.all(query)
```

The `^` operator is critical.

It means:

> Inject this value as a parameter, not as SQL code.

The database receives something similar to:

```sql
SELECT *
FROM users
WHERE username = $1
```

with:

```
$1 = user input
```

The database never interprets the input as SQL.

---

## 3. Never Build SQL Strings Manually

Avoid:

```elixir
sql =
    "SELECT * FROM users WHERE email = '" <>
    email <>
    "'"
```

Avoid:

```elixir
sql =
    "DELETE FROM users WHERE id = " <>
    id
```

These patterns create SQL Injection risks.

Instead use:

```elixir
Repo.get_by(User, email: email)
```

or:

```elixir
from(
    u in User,
    where: u.email == ^email
)
|> Repo.one()
```

---

## 4. Safe CRUD Operations with Ecto

### Insert

Use changesets:

```elixir
changeset =
    User.changeset(%User{}, user_params)

Repo.insert(changeset)
```

A changeset provides:

* Validation
* Type checking
* Controlled field updates
* Protection against unexpected fields

---

### Update

Safe:

```elixir
changeset =
    user
    |> User.changeset(params)

Repo.update(changeset)
```

Avoid:

```elixir
Repo.query(
    "UPDATE users SET name='#{name}'"
)
```

---

### Delete

Safe:

```elixir
Repo.delete(user)
```

Avoid:

```elixir
Ecto.Adapters.SQL.query!(
    Repo,
    "DELETE FROM users WHERE id=#{id}"
)
```

---

## 5. Using Raw SQL Safely

Sometimes raw SQL is necessary:

* Complex reporting
* Database-specific features
* Performance optimization
* Stored procedures

Raw SQL is not automatically unsafe.

Unsafe:

```elixir
Ecto.Adapters.SQL.query!(
    Repo,
    "SELECT * FROM users WHERE email='#{email}'"
)
```

Safe:

```elixir
Ecto.Adapters.SQL.query!(
    Repo,
    "SELECT * FROM users WHERE email=$1",
    [email]
)
```

The SQL structure is fixed.

The value is transferred separately.

---

## 6. Parameterized Queries

Always use parameters.

PostgreSQL example:

```elixir
Ecto.Adapters.SQL.query!(
    Repo,
    """
    SELECT *
    FROM accounts
    WHERE account_number = $1
    """,
    [account_number]
)
```

The database receives:

```sql
WHERE account_number =
$1
```

not:

```sql
WHERE account_number = '12345'
```

This separation prevents SQL Injection.

---

## 7. Safe Dynamic Queries

Applications often need optional filters.

Example:

```elixir
query =
    from u in User

query =
    if email do
        from u in query,
             where: u.email == ^email
    else
        query
    end

query =
    if active do
        from u in query,
             where: u.active == true
    else
        query
    end

Repo.all(query)
```

Every value remains parameterized.

---

## 8. Dynamic ORDER BY Security

A common mistake is allowing users to control SQL identifiers.

Unsafe:

```elixir
sort = params["sort"]

query =
    "SELECT *
   FROM users
   ORDER BY #{sort}"
```

An attacker could send:

```
name; DROP TABLE users;
```

Never insert user input directly into:

* ORDER BY
* Table names
* Column names
* SQL operators

---

### Safe Allowlist Approach

Example:

```elixir
allowed_fields = %{
    "name" => :name,
    "email" => :email,
    "created" => :inserted_at
}

sort_field =
    Map.get(
        allowed_fields,
        params["sort"],
        :name
    )

query =
    from u in User,
         order_by: field(u, ^sort_field)
```

Only approved values are accepted.

---

## 9. Dynamic Table Names

Avoid:

```elixir
table = params["table"]

"SELECT * FROM #{table}"
```

Never allow users to select database objects.

Use explicit mapping:

```elixir
tables = %{
    "customers" => Customer,
    "orders" => Order
}

schema =
    Map.get(tables, requested_table)
```

---

## 10. Ecto Changesets and Mass Assignment Protection

A common vulnerability is allowing users to modify fields they should not control.

Example:

Unsafe:

```elixir
cast(user, params, [:name, :role, :admin])
```

A user could submit:

```json
{
    "name": "John",
    "admin": true
}
```

Better:

```elixir
cast(user, params, [:name])
```

Sensitive fields should be changed only by trusted backend logic.

---

## 11. Validation and Type Checking

Ecto provides strong type handling.

Example:

```elixir
def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :age])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
end
```

Benefits:

* Reject invalid data early
* Prevent unexpected values
* Reduce attack surface

---

## 12. Database Permissions

Application security should not depend only on code.

Use database permissions.

Example:

Application user:

```
SELECT
INSERT
UPDATE
DELETE
```

should not have:

```
CREATE DATABASE
DROP TABLE
SUPERUSER
```

Follow the principle:

> The application should have only the minimum database permissions it requires.

---

## 13. Use Database Constraints

Security is stronger when enforced at multiple layers.

Use:

* Primary keys
* Foreign keys
* Unique indexes
* NOT NULL constraints
* CHECK constraints

Example:

```sql
CREATE UNIQUE INDEX users_email_index
    ON users (email);
```

Never rely only on application validation.

---

## 14. Avoid Information Leakage

Do not expose database errors directly.

Bad:

```elixir
{:error, error}
```

returned directly to users.

Database errors may reveal:

* Table names
* Column names
* SQL structure

Return safe messages:

```elixir
{:error, "Invalid request"}
```

Log technical details internally.

---

## 15. Logging Security

Never log:

* Passwords
* Access tokens
* Session IDs
* Sensitive personal data

Example:

Unsafe:

```elixir
Logger.info("Login #{email} #{password}")
```

Safe:

```elixir
Logger.info("Login attempt for #{email}")
```

---

## 16. Testing for SQL Injection

Test dangerous inputs:

```
'
"
;
--
/*
*/
OR 1=1
UNION SELECT
```

Example:

```elixir
test "search is safe" do
    result =
        search_users("' OR 1=1 --")

    assert result == []
end
```

Security tests should verify that malicious input is treated as data.

---

## 17. Security Checklist

### Query Construction

* [ ] Use Ecto Query DSL
* [ ] Use parameter binding (`^value`)
* [ ] Avoid string concatenation
* [ ] Avoid dynamic SQL generation

### Raw SQL

* [ ] Use `$1`, `$2` parameters
* [ ] Never interpolate variables
* [ ] Review every raw query

### Dynamic Features

* [ ] Use allowlists for sorting
* [ ] Use allowlists for filtering fields
* [ ] Never expose table names

### Data Handling

* [ ] Use changesets
* [ ] Validate input
* [ ] Protect sensitive fields
* [ ] Use database constraints

### Database

* [ ] Use least privilege accounts
* [ ] Separate application and administration users
* [ ] Keep database software updated

### Operations

* [ ] Do not expose SQL errors
* [ ] Protect logs
* [ ] Perform security testing

---

## 18. Comparison with Java Hibernate/JPA

Hibernate/JPA and Ecto follow the same security model.

Java:

```java
repository.findByEmail(email);
```

Elixir:

```elixir
Repo.get_by(User, email: email)
```

Both generate parameterized SQL.

Hibernate:

```sql
WHERE email = ?
```

Ecto:

```sql
WHERE email =
$1
```

The security principle is identical:

> Keep SQL structure separate from user-controlled data.

---

## Conclusion

Ecto provides strong SQL Injection protection when used as intended. The safest approach is to use Ecto's query DSL,
changesets, and parameterized queries everywhere.

SQL Injection almost always appears when developers bypass these protections by dynamically constructing SQL strings.

A secure Elixir application follows a simple rule:

**Never allow user input to become SQL code. Allow user input only to become SQL data values.**

## See also

* [Elixir official documentation](https://elixir-lang.org/)
* [Hex package manager](https://hex.pm/)
* [HexDocs](https://hexdocs.pm/)
* [Phoenix Framework](https://www.phoenixframework.org/)
* [Nerves Project](nerves.md)
* [Tortoise MQTT](https://github.com/gausby/tortoise)
* [EMQX ExMQTT](https://github.com/emqx/exmqtt)
* [Hound](https://github.com/HashNuke/hound)
* [Erlang](erlang.md)
