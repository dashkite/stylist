import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import { generic } from "@dashkite/joy/generic"

isURL = ( value ) -> value?.startsWith "https://"

bind = generic name: "bind"

generic bind,
  Type.isString,
  Fn.memoize ( css ) -> 
    stylesheet = new CSSStyleSheet
    stylesheet.replaceSync css
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