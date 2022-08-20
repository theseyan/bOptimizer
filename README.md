# bOptimizer

This is a WIP project derived from [esbuild](https://github.com/evanw/esbuild).

bOptimizer is a bundler, minifier and optimizer for Bun projects. It links JS/TS source code with npm modules and produces a compact bundle that does not have any external dependencies (no `node_modules` required).

## Why?

This project is being built for [bkg](https://github.com/theseyan/bkg), a packer for Bun apps. At it's current state, bkg archives an entire project directory as it is and extracts it at runtime, which works great for small projects, but becomes increasingly slow to extract when there are a lot of small files (>1000) in the directory. This is *very* common in projects with `node_modules`.

bOptimizer aims to solve this bottleneck by linking all project sources and their dependencies into a single Javascript file, which will drastically improve startup performance, as well as enable fast CRC32 integrity checking to provide spme form of runtime security in bkg bundled apps.

## Progress
- [x] Bundle vanilla TS/JS/JSON sources to ES modules
- [ ] Handle native modules and placement of `.node` binaries through `require` and `import` calls
- [ ] Handle shared libraries (`.so`, `.dylib`, etc.) through bun:ffi's `dlopen`

## License
MIT License