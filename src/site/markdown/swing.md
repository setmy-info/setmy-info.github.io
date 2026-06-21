# Swing and Java Foundation Classes

## Information

**Java Swing** is a GUI widget toolkit for Java, part of the **Java Foundation Classes (JFC)**. It provides a
platform-independent set of components for building desktop applications. Swing is built on top of AWT (Abstract
Window Toolkit) and renders its own components, making it consistent across operating systems.

Swing was the standard Java GUI toolkit from Java 1.2 (1998) through the early 2010s. JavaFX has since replaced it
as the recommended modern approach for new projects, but Swing remains widely used in legacy enterprise applications.

### Key components

| Component      | Purpose                                    |
|----------------|--------------------------------------------|
| `JFrame`       | Top-level application window               |
| `JPanel`       | General-purpose container for other components |
| `JButton`      | Clickable button                           |
| `JLabel`       | Non-editable text or image display         |
| `JTextField`   | Single-line text input                     |
| `JTextArea`    | Multi-line text input                      |
| `JComboBox`    | Drop-down selection list                   |
| `JTable`       | Tabular data display with optional editing |
| `JTree`        | Hierarchical tree data display             |
| `JMenuBar`     | Application menu bar                       |
| `JDialog`      | Modal or non-modal dialog window           |
| `JFileChooser` | File open/save dialog                      |

### Layout managers

| Layout manager  | Behavior                                               |
|-----------------|--------------------------------------------------------|
| `BorderLayout`  | Five regions: North, South, East, West, Center         |
| `GridLayout`    | Equal-size cells in a grid                             |
| `FlowLayout`    | Left-to-right, wrapping like text                      |
| `BoxLayout`     | Single row or column of components                     |
| `GridBagLayout` | Flexible grid with spanning cells and weights          |
| `CardLayout`    | Stacked panels, one visible at a time (like tabs)      |

## Configuration

### Event Dispatch Thread (EDT)

All Swing UI creation and updates must happen on the EDT. Use `SwingUtilities.invokeLater` to safely schedule UI work:

```java
SwingUtilities.invokeLater(() -> {
    JFrame frame = new JFrame("My App");
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setSize(400, 300);
    frame.setVisible(true);
});
```

Never update Swing components from background threads directly.

## Usage, tips and tricks

### Minimal Swing application

```java
import javax.swing.*;

public class HelloSwing {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            JFrame frame = new JFrame("Hello Swing");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

            JPanel panel = new JPanel();
            panel.add(new JLabel("Hello, World!"));
            panel.add(new JButton("Click me"));

            frame.getContentPane().add(panel);
            frame.pack();
            frame.setLocationRelativeTo(null);
            frame.setVisible(true);
        });
    }
}
```

### Event handling

```java
JButton button = new JButton("Click");
button.addActionListener(e -> System.out.println("Clicked!"));
```

### Look and Feel

```java
// Use system native look and feel
UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
```

### Background tasks

Use `SwingWorker` for long-running operations to avoid blocking the EDT:

```java
new SwingWorker<String, Void>() {
    @Override
    protected String doInBackground() throws Exception {
        return fetchDataFromNetwork();
    }

    @Override
    protected void done() {
        try {
            label.setText(get());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}.execute();
```

## See also

* [Java Swing tutorial (Oracle)](https://docs.oracle.com/javase/tutorial/uiswing/)
* [Swing in Wikipedia](https://en.wikipedia.org/wiki/Swing_(Java))
* [Webswing — run Swing apps in a browser](https://www.webswing.org/)
* [JavaFX](javafx.md)
* [Java](java.md)
