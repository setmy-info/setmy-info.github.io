# A2UI

## Information

`A2UI` (Angular to UI) is a modern, lightweight, and highly customizable UI component library for Angular applications.
It is designed to provide developers with a robust set of tools for building responsive and accessible user interfaces
with ease.

The project is hosted at [https://a2ui.org/](https://a2ui.org/).

### Main Functionalities and Features

* **Angular-First Design**: Built from the ground up for Angular, leveraging its powerful component model, directives,
  and dependency injection.
* **Responsive Layouts**: All components are fully responsive and work seamlessly across mobile, tablet, and desktop
  devices.
* **Customizable Theming**: A flexible theming system based on CSS variables and LESS, allowing for easy brand
  integration.
* **Accessibility (A11y)**: Follows WAI-ARIA standards to ensure your applications are accessible to all users.
* **Modular Architecture**: Import only the components you need to keep your bundle size small.
* **Comprehensive Documentation**: Detailed guides and examples for every component.

## Installation

### Prerequisites

* **Node.js LTS** (Recommended). See [node.md](node.md) for details.
* **Angular CLI**. See [angular.md](angular.md) for details.

### Using npm

Install the core library and component package:

```shell
npm install @a2ui/core @a2ui/components
```

### Using Angular CLI (Recommended)

Use the Angular CLI to add A2UI to your project and run initial setup:

```shell
ng add @a2ui/schematics
```

This will automatically configure the library and add the necessary styles to your `angular.json`.

## Usage, tips and tricks

### Basic Component Usage

1. **Import the Module**: In your `app.module.ts` or a feature module, import the `A2UIModule`.

```typescript
import {A2UIModule} from '@a2ui/core';

@NgModule({
    imports: [
        A2UIModule.forRoot()
    ]
})
export class AppModule {
}
```

2. **Use the Component**: You can now use A2UI components in your HTML templates.

```html

<a2ui-card>
    <a2ui-card-header>Welcome to A2UI</a2ui-card-header>
    <a2ui-card-content>
        Building beautiful UIs has never been easier.
    </a2ui-card-content>
    <a2ui-card-footer>
        <a2ui-button (click)="onConfirm()">Get Started</a2ui-button>
    </a2ui-card-footer>
</a2ui-card>
```

### Theming and Customization

A2UI uses LESS variables for theming. You can override these in your `styles.less` file:

```less
// Custom brand colors
@a2ui-primary: #007bff;
@a2ui-secondary: #6c757d;
@a2ui-success: #28a745;

// Custom spacing
@a2ui-base-padding: 1rem;
```

### Performance Tips

* **Treeshaking**: Use granular imports if you are only using a few components.
* **Lazy Loading**: Import component modules into lazy-loaded feature modules to optimize initial load time.

## See also

* [A2UI Official Website](https://a2ui.org/)
* [A2UI GitHub Repository](https://github.com/a2ui/a2ui)
* [AG-UI protocol](ag-ui.md)
* [Angular](angular.md)
* [Angular Start Project](angular-start-project.md)
* [Lerna](lerna.md)
* [Node.js](node.md)
* [npm](npm.md)
