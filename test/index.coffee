import assert from "assert"
import {print, test, success} from "amen"
import "source-map-support/register"


do ->

  print await test "Stylist", [

    test "core", [

      test "set", ->

    ]

  ]

  process.exit if success then 0 else 1
