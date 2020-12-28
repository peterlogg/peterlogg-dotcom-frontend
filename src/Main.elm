module Main exposing (Model, Msg(..), init, main, stingAddress, update, view)

import Browser
import Html exposing (Attribute, Html, div, img, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW


stingAddress : String
stingAddress =
    "http://www.radioandmusic.com/sites/www.radioandmusic.com/files/images/entertainment/2015/10/02/sting-%281%29.jpg"


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Search for an image here", value model.content, onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        , img [ src stingAddress ] []
        ]
