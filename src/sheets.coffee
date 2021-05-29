import {memo, style, stylesheet, diff} from "./helpers"

class Sheets

  constructor: (@root, @sheets = {}) ->
    @styles = []

  get: (key) -> @sheets[key]

  set: (key, value) ->
    if value?
      @sheets[key] = memo value
      @apply()
    else
      @remove key

  remove: (key) ->
    if @sheets[key]?
      delete @sheets[key]
      @apply()

  apply: ->
    try
      @root.adoptedStyleSheets = @toArray().map stylesheet
    catch
      diff @root, @toArray().map style

  toArray: -> Object.values @sheets

sheets = (root) -> new Sheets root

export {sheets}
