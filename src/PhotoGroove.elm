module PhotoGroove exposing (main)

import Browser 

import Html exposing (div,h1,img,text,button,Html)

import Html.Attributes exposing (..)

import Html.Events exposing (onClick)

import Array exposing (Array)


urlPrefix ="http://elm-in-action.com/"

{-- view model = 
  div [ class "content" ]
        [ 
            h1 [] [text "Photo Groove"]
            , div [ id "thumbnails" ] 
                    [ img [ src "http://elm-in-action.com/1.jpeg" ] []
                    ,img [ src "http://elm-in-action.com/2.jpeg" ] []
                    ,img [ src "http://elm-in-action.com/3.jpeg" ] []
                    ]
        ]
 --}
type alias Photo  = { url:String }

type alias Model = { photos : List Photo ,selectedUrl : String}

type ThumbnailSize = Small | Medium | Large

type alias Msg ={ description : String, data : String ,chosenSize : ThumbnailSize}


initialModel: Model
initialModel = {
      photos =[ { url = "1.jpeg" }
       ,{ url = "2.jpeg" }
       ,{ url = "3.jpeg" }]
       ,selectedUrl = "1.jpeg"
       ,chosenSize = "medium"
        }   
photoArray : Array Photo

photoArray =Array.fromList initialModel.photos

view model = div [ class "content" ]
        [ 
                h1 [] [ text "Photo Groove" ]
                ,h3 [] [text "Thumbnail Size :"]
                ,div [id "choose-size"]
                        (List.map viewSizeChooser [Small , Medium ,Large])
                , div [ id "thumbnails" ] (List.map (viewThumbnail model.selectedUrl) model.photos)
                ,img
                        [
                        class "large"
                        ,src (urlPrefix ++ "large/" ++ model.selectedUrl)
                        ]
                        []
                , button
                        [
                         onClick {description="ClickedSurpriseMe" ,data= ""}
                        ][text "Surprise Me!"] 
                ,div [id "thumbnails" , class (sizeToString model.chosenSize)][]               
        ]


viewThumbnail: String -> Photo -> Html Msg
viewThumbnail selectedUrl thumb =
        img
           [
                src (urlPrefix++thumb.url)
                ,classList [("selected", selectedUrl == thumb.url )]
                ,onClick { description="ClickedPhoto" ,data =thumb.url}
           ]
           []

viewSizeChooser : ThumbnailSize -> Html Msg
viewSizeChooser size = label []  [ 
                input [type_ "radio" , name "size"] []
                ,text (sizeToString size) ]           
 


 sizeToString : ThumbnailSize -> String

 sizeToString size =
        case size of 
                Small ->
                        "small"
                Medium ->
                        "med"
                Large ->
                        "large"

        

update  msg model = 
        case msg.description of
                "ClickedPhoto" ->
                        { model | selectedUrl = msg.data}
                "ClickedSurpriseMe" ->
                        { model | selectedUrl = "2.jpeg"}
                 
                _->  
                        model      

main = Browser.sandbox 
       {
        init = initialModel
        ,view = view
        ,update = update
       }