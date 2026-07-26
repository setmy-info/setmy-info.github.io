# Material Symbols

## Information

Material Symbols are Google's newest icons, consolidating over 3,000 icons into a single font file with variable
attributes. They are the successor to Material Icons and are designed to integrate seamlessly with Material Design 3
(M3).

### Main Functionalities and Features

* **Variable Font**: One font file contains all variations (Weight, Fill, Grade, and Optical Size).
* **Style Variants**: Available in three styles: **Outlined**, **Rounded**, and **Sharp**.
* **Granular Control**: Fine-tune icon appearance using CSS variable font properties.
* **Performance**: Smaller footprint compared to loading multiple individual icon font files.
* **Searchable**: Easily find icons at [fonts.google.com/icons](https://fonts.google.com/icons).

### Variable Font Axes

| Axis | Na me | R     ange | Description |
|------|--------------------|-------------|
| **FILL**  | Fill | 0  or 1 | 0 for default (outline), 1 for filled. |
| **wght**  | Weight |  100 to 700 | Adjust stroke thickness. |
| **GRAD**  | Grade |  -25 to 200 | Affects stroke thickness without changing icon size. |
| **opsz**  | Optical  Size | 20 to 48 | Optimizes appearance for different display sizes. |

### Icon Styles

Material Symbols are available in three distinct styles to match different design aesthetics:

* **Outlined**: The default style, featuring clear, stroke-based shapes.
* **Rounded**: Features softer, rounded corners for a friendlier look.
* **Sharp**: Features crisp, square corners for a more technical or precise feel.

All three styles support the four variable axes (Fill, Weight, Grade, and Optical Size).

## Installation

### Web Font via Google Fonts CDN

Add the stylesheet link to your HTML `<head>`. It is recommended to request all four axes to enable full variable
control:

```html
<!-- For Outlined style -->
<link
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-25..200"
    rel="stylesheet"/>

<!-- For Rounded style -->
<link
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-25..200"
    rel="stylesheet"/>

<!-- For Sharp style -->
<link
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-25..200"
    rel="stylesheet"/>
```

### npm

Install the package to use icons in a local build:

```bash
npm install material-symbols
```

Then import the CSS in your main entry point (e.g., `main.ts` or `app.js`):

```javascript
import 'material-symbols';
```

## Configuration

### Global Styling

You can define default variable font settings in your global CSS file to ensure consistency across the application:

```css
.material-symbols-outlined {
    font-variation-settings: 'FILL' 0,
    'wght' 400,
    'GRAD' 0,
    'opsz' 24;
}
```

### Individual Variations

Create utility classes for common variations:

```css
.icon-filled {
    font-variation-settings: 'FILL' 1;
}

.icon-bold {
    font-variation-settings: 'wght' 700;
}

.icon-small {
    font-variation-settings: 'opsz' 20;
    font-size: 20px;
}
```

## Fast and Efficient Way to Start Development

The quickest way to use Material Symbols is via the Google Fonts CDN.

1. **Add the CDN Link**:
   ```html
   <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
   ```

2. **Use in HTML**:
   ```html
   <span class="material-symbols-outlined">copyright</span>
   ```

Material Symbols use ligatures, so the text content of the element is automatically converted into the corresponding
icon.

## Usage, Tips and Tricks

### M3 Icon Principles

According to the [Material Design 3 Icons Overview](https://m3.material.io/styles/icons/overview), icons should follow
these principles:

* **Communicative**: Use recognizable symbols that clearly convey their function.
* **Consistent**: Maintain the same style, stroke weight, and corner treatment across all icons in a product.
* **Simple**: Avoid unnecessary detail that can make icons hard to read at small sizes.

### Interaction States

One of the biggest advantages of variable fonts is the ability to animate attributes smoothly.

```css
.btn-interactive:hover .material-symbols-outlined {
    font-variation-settings: 'FILL' 1, 'wght' 500;
    transition: font-variation-settings 0.2s ease;
}
```

### Alignment and Scaling

To ensure icons align correctly with your text:

```css
.material-symbols-outlined {
    display: inline-block;
    vertical-align: middle;
    line-height: 1;
    font-size: 24px; /* Matches default opsz */
}
```

### Accessibility

For screen readers, icons should usually be hidden, and a descriptive label should be provided:

```html

<button aria-label="Close settings">
    <span class="material-symbols-outlined" aria-hidden="true">close</span>
</button>
```

## Troubleshooting

### Icons showing as text

If you see the icon name (e.g., "home") instead of the icon:

1. **Check the URL**: Ensure the Google Fonts CDN link is correct and accessible.
2. **Check the Class**: Verify that the class name matches the style you requested (e.g., `material-symbols-outlined`).
3. **Font-family Override**: Ensure no other CSS rule is overriding the `font-family: 'Material Symbols Outlined'`.

### Blurry icons

Ensure `opsz` (Optical Size) matches the `font-size` you are using. If you set `font-size: 40px`, you should ideally set
`'opsz' 40` in your `font-variation-settings`.

## See also

[Material Symbols Guide](https://developers.google.com/fonts/docs/material_symbols)

[Google Fonts Icons Search](https://fonts.google.com/icons)

[Material Design 3 Icons Overview](https://m3.material.io/styles/icons/overview)

[Material Design Icons (Legacy)](materialdicons.html)
