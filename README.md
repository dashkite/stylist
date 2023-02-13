# Stylist

*Manage reuse of stylesheets*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

## Install

Install via your favorite package manager. Ex:

```
pnpm add @dashkite/verve
```

## Usage

```coffeescript
import { layers, reset, normalize, typography } from "@dashkite/verve"
import { style } from "@dashkite/stylist"

style document, [ layers, reset, normalize, typography ]
```
