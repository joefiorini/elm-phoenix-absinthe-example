-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module TaskApp.Query exposing (..)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)
import TaskApp.InputObject
import TaskApp.Interface
import TaskApp.Object
import TaskApp.Scalar
import TaskApp.Union


{-| Select fields to build up a top-level query. The request can be sent with
functions from `Graphqelm.Http`.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.selection constructor


tasks : SelectionSet decodesTo TaskApp.Object.Task -> Field (List decodesTo) RootQuery
tasks object =
    Object.selectionField "tasks" [] object (identity >> Decode.list)