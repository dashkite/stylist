# cyrb53
# adapted from:
#   https://stackoverflow.com/a/52171480

hash = (str, seed = 0) ->
  do (
      h1 = 0xdeadbeef ^ seed
      h2 = 0x41c6ce57 ^ seed
      i = 0
      ch = undefined
    ) ->
      while i < str.length
        ch = str.charCodeAt(i)
        h1 = Math.imul(h1 ^ ch, 2654435761)
        h2 = Math.imul(h2 ^ ch, 1597334677)
        i++
      h1 = Math.imul(h1 ^ h1 >>> 16, 2246822507) ^ Math.imul(h2 ^ h2 >>> 13, 3266489909)
      h2 = Math.imul(h2 ^ h2 >>> 16, 2246822507) ^ Math.imul(h1 ^ h1 >>> 13, 3266489909)
      (h2 >>> 0).toString(16).padStart(8, 0) + (h1 >>> 0).toString(16).padStart(8, 0)

export {hash}
