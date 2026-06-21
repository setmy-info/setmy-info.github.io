# VueJS

## Information

Vue.js is a progressive JavaScript framework for building user interfaces. Developed by Evan You and released in 2014,
Vue is designed to be incrementally adoptable — you can use it for a single widget or build a full single-page
application (SPA) with it.

**Vue 2 vs Vue 3:** Vue 3 (released 2020) is the current stable version. It introduced the Composition API alongside
the existing Options API, improved TypeScript support, and better performance. Vue 2 reached end-of-life on
December 31, 2023.

**Composition API vs Options API:**
- Options API: organizes code by option type (data, methods, computed, watch). Classic Vue 2 style.
- Composition API: organizes code by logical concern using `setup()` or `<script setup>`. Preferred for Vue 3.

Node.js **LTS** version is required for CLI tooling and build processes. See [node.md](node.md).

## Installation

### Vue 3 (modern, recommended)

```shell
# Create a new Vue 3 project with Vite (recommended)
npm create vue@latest
```

This runs the official `create-vue` scaffolding tool with interactive prompts for TypeScript, JSX, Vue Router,
Pinia, Vitest, ESLint, and Prettier.

### Vue 2 (legacy, via Vue CLI)

```shell
npm install -g @vue/cli
vue --version
```

## Preparations

### Create a Project (Vue CLI — Vue 2 style)

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

For a full project setup guide see [vue-start-project.md](vue-start-project.md).

## Usage, tips and tricks

```shell
yarn serve
# or with npm
npm run dev
```

### Simple SPA

```html
<!DOCTYPE html>
<html>
<head>
    <title>Vue.js 3 simple SPA</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

<script src="https://unpkg.com/vue/dist/vue.global.prod.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.global.prod.js"></script>

<template id="numbers-page-template">
    <div><h2>Page number from template component: {{ pageNumber }}</h2></div>
</template>

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
        template: '#numbers-page-template'
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

### Select dropdown snippet

```html
        <label for="itemDropdown">Select item:</label>
        <select v-model="selectedItem" @change="onItemChange" id="itemDropdown">
            <option v-for="(item, key) in items" :key="key" :value="item">{{ key }} {{ item.type }}</option>
        </select>
```

## See also

* [Vue.js official documentation](https://vuejs.org/)
* [Vue Router](https://router.vuejs.org/)
* [Pinia (state management)](https://pinia.vuejs.org/)
* [Vite](https://vitejs.dev/)
* [Vue start project](vue-start-project.md)
* [Node.js](node.md)
* [npm](npm.md)
