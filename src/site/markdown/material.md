# Material Design

## Information

`Material Design` is Google's design system for building digital products with a consistent visual language, interaction
model, and component set across web, Android, and other platforms.

The modern generation of the system is often referred to as `Material 3` or `M3`. In practice, teams use Material
Design not only as a component catalog, but as a broader foundation for design tokens, accessibility, motion,
theming, adaptive layout, and product consistency.

It is especially relevant when a product needs a mature, well-documented design language with reusable UI patterns,
cross-platform guidance, and a strong ecosystem around implementation libraries.

Material Design is Google's open-source design system for building consistent, beautiful user interfaces. The current
version is **Material Design 3 (M3)**, also known as **Material You**, which introduced dynamic colour theming and
updated component shapes.

Material Design components are available for multiple frameworks:

| Framework    | Package / Library                |
|--------------|----------------------------------|
| Web (native) | `@material/web` (web components) |
| Angular      | `@angular/material`              |
| React        | MUI (`@mui/material`)            |
| Vue.js       | Vuetify (`vuetify`)              |
| Flutter      | Built-in Material widgets        |

### Main Functionalities and Features

* **Design System Guidance**: Defines principles for layout, typography, color, elevation, motion, and interaction.
* **Component Catalog**: Includes standard UI patterns such as buttons, dialogs, navigation, cards, menus, forms, and
  data display elements.
* **Design Tokens and Theming**: Encourages consistent use of color roles, type scales, spacing, shape, and states.
* **Adaptive and Responsive Design**: Supports layouts that adapt across phones, tablets, desktops, and larger screens.
* **Accessibility Support**: Promotes contrast, focus states, readable hierarchy, and inclusive interaction patterns.
* **Cross-Platform Reach**: Commonly used in Android products, web interfaces, and design system workflows.

### How `Material Design` Fits Into Product Design

`Material Design` is not just a UI kit. It is a full design language.

It usually sits between:

* product design decisions,
* a reusable component library,
* and engineering implementation standards.

In practice, teams adopt it when:

* they want a coherent system instead of one-off component styling,
* they need a shared language between designers and frontend developers,
* or they want to accelerate delivery with established UX patterns.

## Installation

### Angular Material

```shell
ng add @angular/material
```

This schematic installs the package, sets up a theme, and configures animations.

### Web Components (@material/web)

```shell
npm install @material/web
```

Import individual components:

```javascript
import '@material/web/button/filled-button.js';
import '@material/web/textfield/filled-text-field.js';
```

### MUI (React)

```shell
npm install @mui/material @emotion/react @emotion/styled
```

### Vuetify (Vue.js)

```shell
npm install vuetify
```

Or use the Vite plugin:

```shell
npm create vuetify
```

## Usage, tips and tricks

### M3 Colour Theming (CSS custom properties)

Material Design 3 uses a token-based colour system. Generate a theme palette at
[m3.material.io/theme-builder](https://m3.material.io/theme-builder) and apply the exported CSS variables:

```css
:root {
    --md-sys-color-primary: #6750A4;
    --md-sys-color-on-primary: #FFFFFF;
    --md-sys-color-surface: #FFFBFE;
    --md-sys-color-on-surface: #1C1B1F;
}
```

### Angular Material Theme

In `styles.scss`:

```scss
@use '@angular/material' as mat;

$theme: mat.define-theme((
    color: (
        theme-type: light,
        primary: mat.$violet-palette,
    )
));

html {
    @include mat.all-component-themes($theme);
}
```

## Usage, tips and tricks

### Dark Mode

Apply the `color-scheme` CSS property and swap colour tokens:

```css
@media (prefers-color-scheme: dark) {
    :root {
        --md-sys-color-primary: #D0BCFF;
        --md-sys-color-surface: #1C1B1F;
    }
}
```

### Typography Scale

M3 defines a type scale with roles such as `Display`, `Headline`, `Title`, `Body`, and `Label`. Use the corresponding
CSS classes or Angular Material typography mixins rather than hard-coding font sizes.

### Icon Fonts

Material Symbols (the updated icon font replacing Material Icons):

```html

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<span class="material-symbols-outlined">home</span>
```

### Common Developer and Team Use Cases

* Build an internal design system inspired by `Material 3` principles.
* Use ready-made component libraries that follow Material conventions.
* Standardize typography, spacing, color semantics, and state behavior.
* Align mobile and web experiences under one shared interaction language.

### Practical Notes

* Material Design is strongest when adopted as a system, not only as a set of styled buttons.
* Teams should still adapt it to their product identity instead of copying every visual choice literally.
* Design tokens, state definitions, and accessibility rules should be documented alongside components.
* Material guidance is broad, so teams still need governance for exceptions and custom patterns.

## See also

* [Material 3](https://m3.material.io/)
* [Material Design on Google for Developers](https://developers.google.com/material-design)
* [Material Components](https://github.com/material-components)

