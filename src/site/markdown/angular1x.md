# Angular 1.x

## Information

## Configuration

| Method           | HTTP   | Purpose                 | URL Example | Description                       | Idempotent    | Safe  | Cacheable |
|------------------|--------|-------------------------|-------------|-----------------------------------|---------------|-------|-----------|
| `User.get()`     | GET    | Retrieve a single user  | `/users/42` | Fetches one specific resource     | ✅ Yes         | ✅ Yes | ✅ Yes     |
| `User.query()`   | GET    | Retrieve list of users  | `/users`    | Returns a collection of resources | ✅ Yes         | ✅ Yes | ✅ Yes     |
| `User.save()`    | POST   | Create a new user       | `/users`    | Creates a new resource            | ❌ No          | ❌ No  | ❌ No      |
| `User.delete()`  | DELETE | Delete a user           | `/users/42` | Removes the resource              | ✅ Yes         | ❌ No  | ❌ No      |
| `User.remove()`  | DELETE | Alias for `delete`      | `/users/42` | Also removes the resource         | ✅ Yes         | ❌ No  | ❌ No      |
| `user.$update()` | PUT    | Replace entire resource | `/users/42` | Replaces the whole object         | ✅ Yes         | ❌ No  | ❌ No      |
| `user.$patch()`  | PATCH  | Partial update          | `/users/42` | Updates only specified fields     | ❌* Usually no | ❌ No  | ❌ No      |

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
