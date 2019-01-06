{-# LANGUAGE OverloadedStrings #-}

module Models where

import qualified Data.Text as Text
import Data.Text (Text)

data Model = Model
  { meetingsList :: [Meeting]
  , canPostPodcast :: Bool
  } deriving (Show)

data Meeting = Meeting
  { name :: Text
  , local :: Text
  } deriving (Eq, Show)

addMeeting :: Text -> Text -> Model -> Model
addMeeting name local model = model {meetingsList = item : meetings}
  where
    item = Meeting {name = name, local = local}
    meetings = meetingsList model

removeMeeting :: Meeting -> Model -> Either Text Model
removeMeeting meeting model
  | meeting `notElem` meetings = Left "error"
  | otherwise = Right model {meetingsList = filter (/= meeting) meetings}
  where
    meetings = meetingsList model

showMeetings :: [Meeting] -> Text
showMeetings items = "TODO"
