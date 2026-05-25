# REST

## Information

## Angular 1.x descriptions

Combined with REST best practices.

| Method           | HTTP   | Purpose                 | URL Example | Description                       | Idempotent    | Safe  | Cacheable |
|------------------|--------|-------------------------|-------------|-----------------------------------|---------------|-------|-----------|
| `User.get()`     | GET    | Retrieve a single user  | `/users/42` | Fetches one specific resource     | ✅ Yes         | ✅ Yes | ✅ Yes     |
| `User.query()`   | GET    | Retrieve list of users  | `/users`    | Returns a collection of resources | ✅ Yes         | ✅ Yes | ✅ Yes     |
| `User.save()`    | POST   | Create a new user       | `/users`    | Creates a new resource            | ❌ No          | ❌ No  | ❌ No      |
| `User.delete()`  | DELETE | Delete a user           | `/users/42` | Removes the resource              | ✅ Yes         | ❌ No  | ❌ No      |
| `User.remove()`  | DELETE | Alias for `delete`      | `/users/42` | Also removes the resource         | ✅ Yes         | ❌ No  | ❌ No      |
| `user.$update()` | PUT    | Replace entire resource | `/users/42` | Replaces the whole object         | ✅ Yes         | ❌ No  | ❌ No      |
| `user.$patch()`  | PATCH  | Partial update          | `/users/42` | Updates only specified fields     | ❌* Usually no | ❌ No  | ❌ No      |

## Standard or defacto usage

### Base

Entity as a resource.

`{BASE_PATH}` as:

```
/{name}-api/v{version}
```

```
GET {BASE_PATH}/{entities}/{entityId}/{subEntities}/{subEntityId}
GET {BASE_PATH}/{entities}/{entityId}/{subEntities}?{somesubEntityVariable}={somesubEntityValue}&sort={some_property},asc&page=0&size=20
```

Example:

```
GET /shop-api/v1/customers/123/addresses?status=active&sort=last_name,asc&page=0&size=20
```

### Query parameters

Query parameters are used with the `GET` method and are typically used for filtering, sorting, and pagination.

#### Filtering

Use query parameters to filter collections.

```
GET {BASE_PATH}/users?status=active
```

#### Sorting

Use a `sort` parameter to specify the field and direction.

```
GET {BASE_PATH}/users?sort=last_name,asc
```

#### Pagination

Use `page` and `size` (or `offset` and `limit`).

```
GET {BASE_PATH}/users?page=0&size=20
```

#### Sub-entities and Query Parameters

Query parameters are useful for filtering sub-entities belonging to a specific parent resource.

```
GET {BASE_PATH}/customers/123/orders?status=pending
```

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [RESTful API Best practices](https://restfulapi.net/rest-api-best-practices/)
