# Material

## Information

Material Design is Google's open-source design system for building consistent, beautiful user interfaces. The current
version is **Material Design 3 (M3)**, also known as **Material You**, which introduced dynamic colour theming and
updated component shapes.

Material Design components are available for multiple frameworks:

| Framework   | Package / Library             |
|-------------|-------------------------------|
| Web (native)| `@material/web` (web components) |
| Angular     | `@angular/material`           |
| React       | MUI (`@mui/material`)         |
| Vue.js      | Vuetify (`vuetify`)           |
| Flutter     | Built-in Material widgets     |

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

## Configuration

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

## See also

* [Material Design 3](https://m3.material.io/)
* [M3 Theme Builder](https://m3.material.io/theme-builder)
* [Material Web Components](https://github.com/material-components/material-web)
* [Angular Material](https://material.angular.io/)
* [MUI (React)](https://mui.com/)
* [Vuetify](https://vuetifyjs.com/)
* [Material Design icons](materialdicons.md)
