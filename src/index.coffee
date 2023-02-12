import "construct-style-sheets-polyfill"

cache = new Map

bind = ( sheet ) ->
  if Type.isString sheet
    if cache.has sheet
      cache.get sheet
    else
      value = new CSSStyleSheet
      value.replaceSync = sheet
      cache.set sheet, value
      value
  else
    sheet

style = ( root, sheets ) ->
  root.adoptedStyleSheets = sheets.map bind
    
export { style }