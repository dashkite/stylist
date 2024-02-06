import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import { generic } from "@dashkite/joy/generic"

isURL = ( value ) -> value?.startsWith "https://"

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

generic bind,
  isURL,
  Fn.memoize ( url ) ->
    bind await do ( await fetch url ).text

sheets = Fn.curry ( root, sheets ) ->

  candidates = ( bind sheet for sheet in sheets )

  # segment synchrously obtained stylesheets
  # so they can be applied immediately...
  root.adoptedStyleSheets = candidates.filter ( Type.isType CSSStyleSheet )

  # any promise-returning binds will be applied
  # as they resolve
  root.adoptedStyleSheets = [
    root.adoptedStyleSheets...
    ( await Promise.all candidates.filter Type.isPromise )...
  ]
      
export { sheets }