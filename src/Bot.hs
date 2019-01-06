module Bot where

import qualified Telegram.Bot.API as Telegram
import Telegram.Bot.Simple
import Telegram.Bot.Simple.Debug
import Telegram.Bot.Simple.UpdateParser

import Handlers
import Messages
import Models

bot :: BotApp Model Action
bot =
  BotApp
    { botInitialModel = Model {meetingsList = [], canPostPodcast = False}
    , botAction = flip handleUpdate
    , botHandler = handleAction
    , botJobs = []
    }
