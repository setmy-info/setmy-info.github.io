# Material Design Icons

## Information

Material Design Icons are Google's official icon system, part of the Material Design specification. Icons are
available as SVG files, a web font (ligature-based), and npm packages. They cover common UI actions, navigation,
content, and hardware symbols.

### Icon style variants

* **Baseline** (Filled) — solid filled shapes; the default style.
* **Outlined** — icon shapes drawn with outlines only.
* **Rounded** — filled shapes with rounded corners.
* **Two-tone** — filled shapes with a secondary tinted layer.
* **Sharp** — filled shapes with sharp square corners.

## Installation

### Web font via CDN (quickest)

Add to the HTML `<head>`:

```html
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
```

For a specific style variant:

```html
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
```

### npm

For modern projects using the updated symbol set:

```shell
npm install material-symbols
```

Legacy package (older icon set, still widely used):

```shell
npm install material-icons
```

## Configuration

### Icon size

Control with CSS `font-size`. Material icons inherit the font size of their container:

```css
.material-icons {
    font-size: 24px;   /* default */
}
.material-icons.large {
    font-size: 48px;
}
```

### Icon color

Icons inherit the CSS `color` property:

```css
.material-icons {
    color: #1976d2;
}
```

## Usage, tips and tricks

### Ligature-based HTML usage

```html
<span class="material-icons">home</span>
<span class="material-icons">delete</span>
<span class="material-icons outlined">settings</span>
```

The text content is the icon ligature name (e.g. `home`, `delete`, `settings`).

### With Angular Material

```html
<mat-icon>home</mat-icon>
<mat-icon fontIcon="delete"></mat-icon>
```

Import `MatIconModule` in your Angular module or standalone component.

### SVG vs font trade-offs

| Aspect       | Web font                        | SVG                                  |
|--------------|---------------------------------|--------------------------------------|
| Setup        | Single CDN link                 | Import individual SVG files          |
| Performance  | One HTTP request for all icons  | Only requested icons are loaded      |
| Styling      | CSS color/size via font rules   | Full SVG styling and animation       |
| Accessibility| Needs `aria-hidden` + labels    | Can embed `<title>` directly         |

Prefer SVG imports in performance-critical or offline-first applications. Prefer the web font for rapid prototyping
or when you need the full icon set available without additional build configuration.

## See also

* [Material Design](https://m3.material.io/)
* [Material Symbols and Icons](https://fonts.google.com/icons)
* [Material Design Components](https://material.io/components)
* [Material Design Components GitHub](https://github.com/material-components)
* [Google Material Design Icons GitHub](https://github.com/google/material-design-icons)
* [Material Icons npm](https://www.npmjs.com/package/material-icons)
