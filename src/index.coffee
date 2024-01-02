import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import { generic } from "@dashkite/joy/generic"

# we rely on the CSS string itself as the Map key
# the idea is that if you import text css, you
# will always return the same string...
cache = new Map

bind = generic name: "bind"

generic bind,
  Type.isString,
  ( css ) -> 
    if cache.has css
      cache.get css
    else
      stylesheet = new CSSStyleSheet
      stylesheet.replaceSync css
      cache.set css, stylesheet
      stylesheet

generic bind,
  ( Type.isType CSSStyleSheet ),
  Fn.identity

sheets = Fn.curry ( root, sheets ) ->
  root.adoptedStyleSheets =
    bind sheet for sheet in sheets

      
export { sheets }