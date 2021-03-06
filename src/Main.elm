module Main exposing (Model, Msg(..), init, main, stingAddress, update, view)

import Browser
import Debug
import Html exposing (Attribute, Html, button, div, img, input, pre, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http
import Random
import String



-- MAIN


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { content : String
    , response : String
    , backendUrl : String
    }


type alias Flags =
    { backendUrl : String }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { content = ""
      , response = ""
      , backendUrl = flags.backendUrl
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Change String
    | SendHttpRequest
    | GotText (Result Http.Error String)


logTag : String
logTag =
    "TAGGA"


getImageUrl : String -> Cmd Msg
getImageUrl backendUrl =
    Http.get
        { url = backendUrl
        , expect = Http.expectString GotText
        }


randomSubString : String -> String
randomSubString s =
    let
        startPosition =
            1

        -- Random.int 1 (String.length s)
        endPosition =
            10

        -- Random.int (Random.generate startPosition) (String.length s)
    in
    String.slice startPosition endPosition s


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newContent ->
            ( { model | content = newContent }, Cmd.none )

        SendHttpRequest ->
            ( model, getImageUrl model.backendUrl )

        GotText (Ok someString) ->
            ( { model | content = randomSubString someString }, Cmd.none )

        GotText (Err httpError) ->
            ( model, Cmd.none )



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
