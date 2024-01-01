import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import { generic } from "@dashkite/joy/generic"

bind = generic name: "bind"

# we rely on the CSS string itself as the Map key
# the idea is that if you import text css, you
# will always return the same string...
cache = new Map

generic bind,
  Type.isString,
  ( css ) -> 
    if cache.has css
      cache.get css
    else
      cache.set css,
        ( new CSSStyleSheet )
          .replaceSync css

generic bind,
  ( Type.isType CSSStyleSheet ),
  Fn.identity

sheets = Fn.curry ( root, sheets ) ->
  root.adoptedStyleSheets = sheets.map bind
      
export { sheets }