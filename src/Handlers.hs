{-# LANGUAGE OverloadedStrings #-}

module Handlers where

import Control.Applicative ((<|>))

import qualified Telegram.Bot.API as Telegram
import Telegram.Bot.Simple
import Telegram.Bot.Simple.Debug
import Telegram.Bot.Simple.UpdateParser

import Data.Text (Text)

import Messages (podcastMessage, startMessage)
import Models

data Action
  = NoAction
  | AddMeeting Text
  | ShowMeetings
  | Start
  | PodcastMode
  deriving (Show)

podcastMessageKeyboard :: Telegram.ReplyKeyboardMarkup
podcastMessageKeyboard =
  Telegram.ReplyKeyboardMarkup
    { Telegram.replyKeyboardMarkupKeyboard = [["On", "Off"]]
    , Telegram.replyKeyboardMarkupResizeKeyboard = Just True
    , Telegram.replyKeyboardMarkupOneTimeKeyboard = Just True
    , Telegram.replyKeyboardMarkupSelective = Just True
    }

handleUpdate :: Model -> Telegram.Update -> Maybe Action
handleUpdate model =
  parseUpdate $
  ShowMeetings <$ command "show" <|> AddMeeting <$> command "add" <|>
  Start <$ command "start" <|>
  PodcastMode <$ command "podcastmode"

handleAction :: Action -> Model -> Eff Action Model
handleAction action model =
  case action of
    NoAction -> pure model
    AddMeeting name ->
      addMeeting name "" model <# do
        replyText "Evento Adicionado"
        pure ShowMeetings
    ShowMeetings ->
      model <# do
        replyText (showMeetings (meetingsList model))
        pure NoAction
    Start ->
      model <# do
        replyText startMessage
        pure NoAction
    PodcastMode ->
      model <# do
        reply
          (toReplyMessage podcastMessage)
            { replyMessageReplyMarkup =
                Just $ Telegram.SomeReplyKeyboardMarkup podcastMessageKeyboard
            }
        pure NoAction
