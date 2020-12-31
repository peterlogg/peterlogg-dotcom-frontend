module Main exposing (Model, Msg(..), init, main, stingAddress, update, view)

import Browser
import Debug
import Html exposing (Attribute, Html, button, div, img, input, pre, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { content : String
    , response : String
    }


init : Model
init =
    { content = ""
    , response = ""
    }



-- UPDATE


type Msg
    = Change String
    | SendHttpRequest
    | GotText (Result Http.Error String)


backendUrl : String
backendUrl =
    "https://elm-lang.org/assets/public-opinion.txt"


logTag : String
logTag =
    "TAGGA"


getImageUrl : Cmd Msg
getImageUrl =
    let
        _ =
            Debug.log logTag "I'm in this function mate"
    in
    Http.get
        { url = backendUrl
        , expect = Http.expectString GotText
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }

        SendHttpRequest ->
            let
                _ =
                    Debug.log logTag "Sending HTTP request"

                _ =
                    getImageUrl
            in
            model

        GotText response ->
            case response of
                Ok someString ->
                    let
                        _ =
                            Debug.log logTag "Got" ++ someString
                    in
                    model

                Err httpError ->
                    let
                        _ =
                            Debug.log logTag "Hit a error"
                    in
                    model



-- VIEW


stingAddress : String
stingAddress =
    "http://www.radioandmusic.com/sites/www.radioandmusic.com/files/images/entertainment/2015/10/02/sting-%281%29.jpg"


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Do you like Sting?", value model.content, onInput Change ] []
        , button [ onClick SendHttpRequest ] [ text "Get image please" ]
        , div [] [ text (String.reverse model.content) ]
        , img [ src stingAddress ] []
        ]



-- button : List (Attribute msg) -> List (Html msg) -> Html msg
-- input : List (Attribute msg) -> List (Html msg) -> Html msg
