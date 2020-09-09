import {_stylesheet, _style} from "./helpers"

build = (sheet) ->
  try
    _stylesheet sheet
  catch
    _style sheet

export {build}
