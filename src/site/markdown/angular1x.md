# Angular 1.x

## Information

AngularJS (Angular 1.x) is the first generation of the Angular framework, developed by Google. It is a JavaScript-based
MVC framework for building single-page web applications. AngularJS reached **End-of-Life on December 31, 2021** and
is no longer maintained or receiving security updates.

For new projects, use the current Angular framework (Angular 2+). See [angular.md](angular.md). For legacy projects
that still run AngularJS, be aware that the runtime requires only a browser — no Node.js installation is needed at
runtime — but development tooling (build, test, linting) typically runs on Node.js.

## Installation

AngularJS can be included directly in an HTML page from a CDN (no npm required for runtime):

```html
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.3/angular.min.js"></script>
```

For projects using npm-based build tooling, install as a dependency:

```shell
npm install angular
```

## Configuration

AngularJS applications are bootstrapped with a module declaration and `ng-app`:

```html
<!DOCTYPE html>
<html ng-app="myApp">
<head>
    <script src="angular.min.js"></script>
</head>
<body>
    <div ng-controller="MainCtrl">{{ message }}</div>
    <script>
        angular.module('myApp', [])
            .controller('MainCtrl', function($scope) {
                $scope.message = 'Hello, AngularJS!';
            });
    </script>
</body>
</html>
```

### $resource HTTP Methods

The `$resource` service maps HTTP methods to object methods. Common patterns:

| Method           | HTTP   | Purpose                 | URL Example | Idempotent | Safe  |
|------------------|--------|-------------------------|-------------|------------|-------|
| `User.get()`     | GET    | Retrieve a single user  | `/users/42` | Yes        | Yes   |
| `User.query()`   | GET    | Retrieve list of users  | `/users`    | Yes        | Yes   |
| `User.save()`    | POST   | Create a new user       | `/users`    | No         | No    |
| `User.delete()`  | DELETE | Delete a user           | `/users/42` | Yes        | No    |
| `User.remove()`  | DELETE | Alias for `delete`      | `/users/42` | Yes        | No    |
| `user.$update()` | PUT    | Replace entire resource | `/users/42` | Yes        | No    |
| `user.$patch()`  | PATCH  | Partial update          | `/users/42` | No         | No    |

## Usage, tips and tricks

### Coding tips and tricks

Two-way data binding:

```javascript
angular.module('myApp', [])
    .controller('MainCtrl', function($scope) {
        $scope.name = 'World';
    });
```

```html
<input ng-model="name"> <p>Hello, {{ name }}!</p>
```

Dependency injection:

```javascript
angular.module('myApp')
    .service('UserService', function($http) {
        this.getAll = function() {
            return $http.get('/api/users');
        };
    });
```

## See also

* [AngularJS official documentation (archived)](https://docs.angularjs.org/guide)
* [AngularJS End-of-Life announcement](https://blog.angular.io/discontinued-long-term-support-for-angularjs-cc066b82e65a)
* [Angular 2+ migration guide](https://angular.dev/guide/ngmodules)
* [Angular (current)](angular.md)
* [Node.js](node.md)
