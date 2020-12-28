module MainTests exposing (suite)

import Expect exposing (Expectation, equal)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (stingAddress)
import String exposing (startsWith)
import Test exposing (..)


suite : Test
suite =
    test "stingAddress is a url"
        (\_ -> Expect.true "Is a url, at the start at least" (startsWith "http" stingAddress))
