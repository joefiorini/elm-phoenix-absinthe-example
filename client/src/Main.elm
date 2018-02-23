module Main exposing (..)

import Html exposing (..)
import RemoteData exposing (RemoteData(..))
import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import TaskApp.Query as Query
import TaskApp.Object as TaskObject
import TaskApp.Object.Task as Task
import TaskApp.Scalar


type Msg
    = RequestTasks
    | LoadTasks Model


type alias Task =
    { id : TaskApp.Scalar.Id
    , name : String
    , description : Maybe String
    , isCompleted : Bool
    }


type alias Model =
    RemoteData Graphqelm.Http.Error TasksResponse


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


task : SelectionSet Task TaskObject.Task
task =
    Task.selection Task
        |> with Task.id
        |> with Task.name
        |> with Task.description
        |> with Task.isCompleted


type alias TasksResponse =
    { tasks : List Task
    }


tasksQuery : SelectionSet TasksResponse RootQuery
tasksQuery =
    Query.selection TasksResponse
        |> with (Query.tasks task)


requestTasks : Cmd Msg
requestTasks =
    tasksQuery
        |> Graphqelm.Http.queryRequest "http://localhost:4000/graphql"
        |> Graphqelm.Http.send (RemoteData.fromResult >> LoadTasks)


init : ( Model, Cmd Msg )
init =
    RemoteData.Loading ! [ requestTasks ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestTasks ->
            model ! []

        LoadTasks m ->
            m ! []


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Todos!" ]
        , case model of
            NotAsked ->
                text "Initializing..."

            Loading ->
                text "Loading..."

            Failure e ->
                text ("Error!" ++ toString e)

            Success { tasks } ->
                ul []
                    (List.map
                        (\task -> li [] [ text task.name ])
                        tasks
                    )
        ]
