# vue-start-project

## Information

This page describes how to scaffold and prepare a new Vue.js 3 project from scratch, including toolchain setup,
project initialization, common packages, and the standard development workflow.

Vue.js 3 requires **Node.js LTS** for all CLI tooling and the Vite development server. See [node.md](node.md) for the
LTS versioning policy and installation instructions.

## Installation

### Install Node.js LTS

See [node.md](node.md). Verify:

```shell
node -v
npm -v
```

No global Vue CLI installation is needed for new projects — use `npm create vue@latest` directly.

## Preparations

### Create a New Project

```shell
npm create vue@latest
```

This runs the official `create-vue` scaffolding tool. It prompts for:

* Project name
* TypeScript support
* JSX support
* Vue Router
* Pinia (state management)
* Vitest (unit testing)
* End-to-end testing (Playwright / Cypress)
* ESLint + Prettier

### Pin Node.js Version

```shell
node -v | sed 's/v//' > .nvmrc
```

### Start the Development Server

```shell
cd my-app
npm install
npm run dev
```

Browse to [http://localhost:5173/](http://localhost:5173/) (Vite default port).

### Project Directory Structure

After scaffolding with Vue Router and Pinia:

```
my-app/
├── src/
│   ├── assets/                  # Static assets (images, fonts, global CSS)
│   ├── components/              # Reusable Vue components
│   ├── composables/             # Reusable composition functions
│   ├── router/
│   │   └── index.ts             # Vue Router configuration
│   ├── stores/
│   │   └── counter.ts           # Pinia store
│   ├── views/                   # Page-level components (one per route)
│   ├── App.vue                  # Root component
│   └── main.ts                  # Application entry point
├── public/                      # Static files served at /
├── index.html                   # HTML shell (Vite entry)
├── vite.config.ts               # Vite configuration
├── tsconfig.json
├── package.json
└── package-lock.json
```

### Common Packages and Their Purpose

**Routing and State:**

| Package              | Purpose                                                              |
|----------------------|----------------------------------------------------------------------|
| `vue-router`         | Official router — maps URL paths to view components                  |
| `pinia`              | Official state management — replaces Vuex in Vue 3                  |

**HTTP:**

| Package              | Purpose                                                              |
|----------------------|----------------------------------------------------------------------|
| `axios`              | Promise-based HTTP client for calling REST APIs                     |

**Forms:**

| Package              | Purpose                                                              |
|----------------------|----------------------------------------------------------------------|
| `vee-validate`       | Form validation library for Vue 3                                   |
| `zod`                | Schema validation — pairs well with vee-validate for typed forms    |
| `yup`                | Alternative schema validator for vee-validate                       |

**UI:**

| Package                  | Purpose                                                          |
|--------------------------|------------------------------------------------------------------|
| `@vueuse/core`           | Collection of Vue composition utilities (scroll, storage, etc.)  |
| `primevue`               | Full UI component library for Vue 3                              |
| `naive-ui`               | Lightweight UI library with TypeScript-first design              |

**Testing:**

| Package              | Purpose                                                              |
|----------------------|----------------------------------------------------------------------|
| `vitest`             | Vite-native unit test runner — fast, compatible with Jest API        |
| `@vue/test-utils`    | Official test utilities for mounting and interacting with components |
| `playwright`         | End-to-end browser automation                                       |

### Install Additional Packages

```shell
npm install axios pinia vue-router @vueuse/core
npm install vee-validate zod
npm install --save-dev vitest @vue/test-utils
```

## Configuration

### vite.config.ts

```typescript
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
    plugins: [vue()],
    resolve: {
        alias: {
            '@': fileURLToPath(new URL('./src', import.meta.url))
        }
    },
    server: {
        port: 5173,
        proxy: {
            '/api': 'http://localhost:8080'
        }
    }
})
```

### Environment Variables

Vite exposes variables prefixed with `VITE_` to the client:

`.env`:

```
VITE_API_BASE_URL=http://localhost:8080/api
```

In code:

```typescript
const apiUrl = import.meta.env.VITE_API_BASE_URL
```

## Usage, tips and tricks

### Running the Project

```shell
npm run dev       # Development server with HMR
npm run build     # Production build to dist/
npm run preview   # Preview production build locally
npm run test      # Run Vitest unit tests
npm run lint      # Run ESLint
```

### Minimal Pinia Store

```typescript
// src/stores/user.ts
import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useUserStore = defineStore('user', () => {
    const name = ref('')
    function setName(value: string) {
        name.value = value
    }
    return { name, setName }
})
```

### Minimal Component Test

```typescript
// src/components/__tests__/MyComponent.spec.ts
import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'
import MyComponent from '../MyComponent.vue'

describe('MyComponent', () => {
    it('renders correctly', () => {
        const wrapper = mount(MyComponent)
        expect(wrapper.text()).toContain('Hello')
    })
})
```

## See also

* [VueJS](vuejs.md)
* [Vue.js official documentation](https://vuejs.org/)
* [Vite](https://vitejs.dev/)
* [Vue Router](https://router.vuejs.org/)
* [Pinia](https://pinia.vuejs.org/)
* [Node.js](node.md)
* [npm](npm.md)
