# MUI Material Icons

## Information

[MUI Material Icons](https://mui.com/material-ui/material-icons/) is the React implementation of the official Material
Design icons for the MUI (formerly Material-UI) ecosystem. These icons are provided as React components, making them
extremely easy to use and style within React applications.

### Main Functionalities and Features

* **2,100+ Icons**: Covers all five official Google Material Icon themes (Filled, Outlined, Rounded, Two-tone, and
  Sharp).
* **React Components**: Each icon is a standalone component, allowing for tree-shaking and optimized bundles.
* **Easy Styling**: Icons integrate perfectly with MUI's `sx` prop and theme system.
* **Accessibility**: Pre-configured with appropriate SVG attributes for accessibility.

## Installation

### npm

```bash
npm install @mui/icons-material @mui/material @emotion/react @emotion/styled
```

Note: `@mui/icons-material` depends on `@mui/material` for some internal components (like `SvgIcon`).

## Configuration

### Importing Icons

To keep your bundle small, use path imports rather than top-level imports:

```javascript
// Recommended (Better for bundle size)
import HomeIcon from '@mui/icons-material/Home';

// Not Recommended (Can slow down build times)
// import { Home } from '@mui/icons-material';
```

## Usage, Tips and Tricks

### Basic Usage

```jsx
import HomeIcon from '@mui/icons-material/Home';

function App() {
  return <HomeIcon />;
}
```

### Changing Size and Color

MUI icons inherit the font size and color of their parent, but can be customized directly:

```jsx
<HomeIcon color="primary" />
<HomeIcon color="secondary" fontSize="large" />
<HomeIcon sx={{ color: 'pink', fontSize: 40 }} />
```

Available color values: `inherit`, `primary`, `secondary`, `success`, `error`, `info`, `warning`.

### Custom SVG Icons (SvgIcon)

If you have a custom SVG and want it to behave like a Material Icon, use the `SvgIcon` component:

```jsx
import { SvgIcon } from '@mui/material';

function HomeIcon(props) {
  return (
    <SvgIcon {...props}>
      <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z" />
    </SvgIcon>
  );
}
```

### Font Material Icons

If you prefer using the icon font (via Google Fonts CDN) with MUI instead of SVG components:

```jsx
import { Icon } from '@mui/material';

<Icon>add_circle</Icon>
```

Note: This requires loading the Material Icons font in your HTML.

### Performance Tip: Tree Shaking

MUI Icons support tree-shaking out of the box. However, using the "Not Recommended" import style mentioned above can
sometimes lead to slower compilation times in development, even if the final production bundle is small. Always prefer
direct path imports for the best experience.

## See also

* [MUI Material Icons Documentation](https://mui.com/material-ui/material-icons/)
* [MUI Icon Search](https://mui.com/material-ui/material-icons/#main-content)
* [Material Symbols (Google)](material-symbols.html)
* [Material Design Icons (Pictogrammers)](mdi.html)
