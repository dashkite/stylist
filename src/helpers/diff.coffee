import {curry, wrap, pipe} from "@dashkite/joy/function"
import {select, each} from "@dashkite/joy/iterable"

find = curry (predicate, array) -> array.find predicate

missing = curry (array, node) -> !(find (same node), array)

add = curry (root, node) ->

  if root.head?
    root.head.append node.cloneNode true
  else
    root.append node.cloneNode true

remove = (node) ->
  node.remove()

same = curry (a, b) ->
  if a.dataset.hash? && b.dataset.hash?
    a.dataset.hash == b.dataset.hash
  else
    a.textContent == b.textContent

diff = (root, target) ->
  current = Array.from root.querySelectorAll "style"
  do pipe [
    wrap current
    select missing target
    each remove
  ]
  do pipe [
    wrap target
    select missing current
    each add root
  ]

export {diff}
