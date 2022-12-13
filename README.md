# bOptimizer

This is a project derived from [esbuild](https://github.com/evanw/esbuild).

bOptimizer is a bundler, minifier and optimizer for Bun code, available as a static C library. It links JS/TS source code with npm modules and produces a compact bundle that does not have any external dependencies (no `node_modules` required).

## Why?

*This project is built for [bkg](https://github.com/theseyan/bkg), a packager for Bun apps.*

bOptimizer is designed to go hand-in-hand with bkg's static analyzer to perform best-effort link time optimizations on source code during bundling.
Due to the nature of bkg's [executable compression](https://en.wikipedia.org/wiki/Executable_compression), cold starts often take longer than the subsequent startups of a bundled program. This is due to the fact that the runtime has to cache all bundled code to disk, which gets increasingly slower as number of files and their respective sizes increase.

bOptimizer aims to eliminate this bottleneck by linking all project sources and their dependencies into a single (or very few) bundled files, which drastically reduces the amount of work to be done during cold starts, and hence increases startup performance noticeably.

## Building from source

The prerequisites for cross-compilation to all supported targets are:
- Golang version 1.18.0 and above
- Zig (available as `zig cc` and `zig c++`)

Static libraries for all supported platforms and architectures can be generated automatically by running the build script:
```
./build.sh
```
Generated libraries and header files are placed in `build/out`.

## License
MIT License