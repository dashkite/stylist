import {curry} from "@dashkite/joy/function"
import {memoize} from "./memoize"
import {hash} from "./hash"

_stylesheet = (text) ->
  r = new CSSStyleSheet
  r.replaceSync text
  r

_style = (text) ->
  r = document.createElement "style"
  r.textContent = text
  r.dataset.hash = hash text
  r.dataset.carbonSkip = "prepend"
  r


css = (stylesheet) ->
  Array.from stylesheet.cssRules
  .map (r) -> r.cssText
  .join " "

style = memoize (value) ->
  if value instanceof HTMLStyleElement
    value
  else if value instanceof CSSStyleSheet
    _style css value
  else
    _style value.toString()

stylesheet = memoize (value) ->
  if value instanceof CSSStyleSheet
    value
  else
    _stylesheet value.toString()

export {_stylesheet, _style, css, style, stylesheet}
