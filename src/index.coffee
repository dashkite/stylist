import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import { generic } from "@dashkite/joy/generic"

isURL = ( value ) -> value?.startsWith "https://"

fetchText = Fn.flow [
  ( url ) -> fetch url
  ( response ) -> do response.text 
]

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
  Fn.memoize ( url ) -> bind await fetchText url

getCandidates = ( sheets ) ->
  candidates = ( bind sheet for sheet in sheets )
  stylesheets: candidates.filter Type.isType CSSStyleSheet
  promises: candidates.filter Type.isPromise

sheets = Fn.curry ( root, sheets ) ->
  { stylesheets, promises } = getCandidates sheets
  root.adoptedStyleSheets = stylesheets
  root.adoptedStyleSheets.push ( await Promise.all promises  )...


add = Fn.curry ( root, sheets ) ->
  { stylesheets, promises } = getCandidates sheets
  root.adoptedStyleSheets.push stylesheets...
  root.adoptedStyleSheets.push ( await Promise.all promises  )...

export { sheets, add }