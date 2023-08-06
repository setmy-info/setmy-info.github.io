# VueJS

## Installation

```shell
npm install -g @vue/cli
```

## Project creation

```shell
vue create vue-start-project
```

```shell
Vue CLI v4.3.1
? Please pick a preset: Manually select features
? Check the features needed for your project: Babel, Router, Vuex, CSS Pre-processors, Linter, Unit, E2E
? Use history mode for router? (Requires proper server setup for index fallback in production) Yes
? Pick a CSS pre-processor (PostCSS, Autoprefixer and CSS Modules are supported by default): Less
? Pick a linter / formatter config: Standard
? Pick additional lint features: Lint on save
? Pick a unit testing solution: Mocha
? Pick an E2E testing solution: Nightwatch
? Pick browsers to run end-to-end test on Chrome, Firefox
? Where do you prefer placing config for Babel, ESLint, etc.? In dedicated config files
? Save this as a preset for future projects? Yes
? Save preset as: vue-start-project-preset
```

## Usage, tips and tricks

```shell
yarn serve
```

### Simple SPA

```html
<!DOCTYPE html>
<html>
<head>
    <title>Vue.js 3 simple SPA</title>
</head>
<body>
<div id="app">
    <input type="text" @change="textChanged" v-model="inputText">
    <p>{{inputText}}</p>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    const app = Vue.createApp({
        data() {
            return {
                inputText: "Initial text"
            };
        },
        created() {
            this.init();
        },
        methods: {
            init() {
                console.log("Init")
            },
            textChanged(event) {
                console.log("event: ", event);
            }
        }
    });
    app.mount('#app');
</script>
</body>
</html>
```

### Simple SPA with router

```html
<!DOCTYPE html>
<html>
<head>
    <title>Vue.js 3 simple SPA</title>
</head>
<body>
<div id="app">
    <ul>
        <li>
            <router-link to="/">Home page</router-link>
        </li>
        <li>
            <router-link to="/input-field">Input field page</router-link>
        </li>
        <li>
            <router-link :to="{ path: '/page/1' }">Page 1</router-link>
        </li>
        <li>
            <router-link :to="{ path: '/page/2' }">Page 2</router-link>
        </li>
        <li>
            <router-link :to="{ path: '/page/3' }">Page 3</router-link>
        </li>
    </ul>
    <router-view></router-view>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/vue-router@next"></script>
<script>
    const dataService = {
        inputFieldValue: "Initial input field value"
    };

    const homePage = {
        template: '<div><h2>Opening page</h2></div>'
    };

    const inputFieldPage = {
        template: '<div><h2>Input field</h2><input type="text" @change="textChanged" v-model="inputText"><p>{{ inputText }}</p></div>',
        data() {
            return {
                inputText: dataService.inputFieldValue
            };
        },
        created() {
            this.init();
        },
        methods: {
            init() {
                console.log("Init input field page");
            },
            textChanged(event) {
                console.log("event: ", event, this.inputText);
                dataService.inputFieldValue = this.inputText;
            }
        }
    };

    const numbersPage = {
        props: ['pageNumber'],
        template: '<div><h2>Page number: {{ pageNumber }}</h2></div>'
    };

    const router = VueRouter.createRouter({
        history: VueRouter.createWebHashHistory(),//history: VueRouter.createWebHistory(),
        routes: [
            {path: '/', component: homePage},
            {path: '/input-field', component: inputFieldPage},
            {path: '/page/:pageNumber', component: numbersPage, props: true}
        ],
    });

    const app = Vue.createApp({
        data() {
            return {
                appData: "app Data"
            };
        },
        created() {
            this.init();
        },
        methods: {
            init() {
                console.log("Init app")
            }
        }
    });
    app.use(router);
    app.mount('#app');
</script>
</body>
</html>
```
