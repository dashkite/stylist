class Memo
  constructor: (@value) ->
  set: (@computed) ->
  get: -> @computed

memoize = (f) -> (memo) -> memo.computed ?= f memo.value
memo = (value) -> new Memo value

export {memo, memoize}
