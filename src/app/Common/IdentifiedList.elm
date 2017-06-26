module Common.IdentifiedList exposing (findById, mapIfId, removeById)

import List.Extra


findById : a -> List { b | id : a } -> Maybe { b | id : a }
findById id =
    List.Extra.find (\item -> item.id == id)


removeById : a -> List { b | id : a } -> List { b | id : a }
removeById id =
    List.filter (\item -> item.id /= id)


mapIfId : Int -> ({ a | id : Int } -> b) -> ({ a | id : Int } -> b) -> List { a | id : Int } -> List b
mapIfId id caseTrue caseFalse =
    List.map
        (\item ->
            if item.id == id then
                caseTrue item
            else
                caseFalse item
        )
