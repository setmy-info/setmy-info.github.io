# SDL (Simple DirectMedia Layer)

## Information

`SDL` (`Simple DirectMedia Layer`) is a cross-platform multimedia and low-level application development library. It is
widely used for games, emulators, visualization tools, media applications, and interactive software that need portable
access to graphics, audio, input devices, timers, and window management.

### Main Functionalities and Features

* **Cross-platform Windowing**: Create windows and manage application lifecycle events on multiple operating systems.
* **Input Handling**: Keyboard, mouse, touch, controller, and joystick support.
* **2D Rendering Support**: Hardware-accelerated rendering APIs for many common application and game scenarios.
* **Audio Playback and Capture**: Useful for games, tools, and multimedia software.
* **Threading, Timers, and Synchronization**: Portable building blocks for native applications.
* **File, Clipboard, and Platform Utilities**: Small but practical system integration helpers.
* **OpenGL / Vulkan Interoperability**: Often used as the portability layer around graphics APIs.

### Common Developer Use Cases

* Build a portable native game that runs on `Windows`, `Linux`, and `macOS`.
* Implement controller and keyboard input without writing platform-specific code first.
* Create a rendering window for `OpenGL` or `Vulkan` applications.
* Develop emulators, demos, kiosks, and multimedia frontends.

## Installation

### Fedora

```bash
sudo dnf install -y SDL2 SDL2-devel
```

### Debian / Ubuntu

```bash
sudo apt-get install -y libsdl2-2.0-0 libsdl2-dev
```

### macOS

```bash
brew install sdl2
```

### Windows

On `Windows`, teams often use one of these approaches:

* download the official development libraries from the `SDL` site,
* install through a package manager,
* or consume it via `CMake`, `vcpkg`, `Conan`, or another dependency workflow.

## Configuration

`SDL` usually requires very little central configuration. Most work happens in the application code:

* initialize required subsystems,
* create window and renderer objects,
* configure event loop behavior,
* and link any optional image, audio, or font companion libraries if needed.

## Usage, tips and tricks

* Keep the main event loop explicit and simple.
* Initialize only the subsystems you actually need.
* Treat `SDL` as a portability layer; keep platform-specific code isolated.
* If you use `OpenGL` or `Vulkan`, let `SDL` handle the window and device integration but keep rendering logic separate.
* For larger applications, wrap initialization and cleanup carefully to avoid resource leaks.

### Minimal C Example

```c
#include <SDL.h>

int main(void) {
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        return 1;
    }

    SDL_Window *window = SDL_CreateWindow("SDL app",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        800,
        600,
        SDL_WINDOW_SHOWN);

    if (window == NULL) {
        SDL_Quit();
        return 1;
    }

    SDL_Delay(1000);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
```

## See also

* [SDL official site](https://www.libsdl.org/)
* [SDL Wiki](https://wiki.libsdl.org/)
* [C++](cpp.html)
