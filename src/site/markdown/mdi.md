# Material Design Icons (Pictogrammers)

## Information

[Material Design Icons](https://pictogrammers.com/library/mdi/) by Pictogrammers is a highly popular, community-led icon
collection that extends the official Google Material Design icon set. It contains over 7,000 icons, providing many
symbols not found in the official Google sets, making it a go-to for many developers.

### Main Functionalities and Features

* **Extensive Library**: 7,000+ icons and growing.
* **Multiple Formats**: Available as Webfont, SVG, PNG, and XAML.
* **Framework Support**: Official packages for React, Angular, Vue, and more.
* **Community Driven**: Users can request and contribute new icons.
* **Searchable**: Robust search and filtering at [pictogrammers.com](https://pictogrammers.com/library/mdi/).

## Installation

Pictogrammers MDI can be installed in several ways depending on your project's needs.

### Webfont (npm)

The easiest way to get all icons available as CSS classes:

```bash
npm install @mdi/font
```

Then include the CSS in your project:

```javascript
import '@mdi/font/css/materialdesignicons.css'
```

### SVG Path (npm) - Recommended for Production

For better performance and smaller bundle sizes, use the SVG path package:

```bash
npm install @mdi/js
```

### Framework Specific Packages

* **React**: `npm install @mdi/react`
* **Angular**: `npm install @mdi/angular`
* **Vue**: `npm install @mdi/vue`

## Configuration

### CSS Customization (Webfont)

You can customize the icons using standard CSS properties:

```css
.mdi {
    font-size: 24px;
    color: #2196F3;
}

/* Helper classes provided by @mdi/font */
.mdi-24px {
    font-size: 24px;
}

.mdi-36px {
    font-size: 36px;
}

.mdi-48px {
    font-size: 48px;
}

.mdi-light {
    color: rgba(255, 255, 255, 0.7);
}

.mdi-dark {
    color: rgba(0, 0, 0, 0.54);
}
```

## Usage, Tips and Tricks

### Webfont Usage (HTML)

Once the CSS is loaded, use the `mdi` and `mdi-<icon-name>` classes:

```html
<span class="mdi mdi-account"></span>
<span class="mdi mdi-home-outline"></span>
<span class="mdi mdi-check-circle-outline mdi-24px"></span>
```

### React Usage (with @mdi/react and @mdi/js)

```jsx
import Icon from '@mdi/react';
import {mdiAccount} from '@mdi/js';

function MyComponent() {
    return (
        <Icon path={mdiAccount} size={1} color="red"/>
    );
}
```

### Angular Usage (with @mdi/angular)

```html

<mdi-icon [path]="mdiAccountPath"></mdi-icon>
```

```typescript
import {mdiAccount} from '@mdi/js';

@Component({...})
export class MyComponent {
    mdiAccountPath = mdiAccount;
}
```

### Why use Pictogrammers MDI over Google's Official Icons?

1. **More Icons**: Google's set is relatively small and focused on generic UI. Pictogrammers includes brands, weather,
   medical, and highly specific industry icons.
2. **Consistency**: Pictogrammers follows the Material Design grid strictly, so their icons mix perfectly with official
   ones.
3. **Community**: If you need an icon that doesn't exist, you can request it on their GitHub.

## See also

* [Pictogrammers MDI Library](https://pictogrammers.com/library/mdi/)
* [Pictogrammers Documentation](https://pictogrammers.com/docs/)
* [MDI GitHub Repository](https://github.com/Templarian/MaterialDesign)
* [Material Symbols (Google)](material-symbols.html)
* [Material Icons (Google Legacy)](materialdicons.html)
