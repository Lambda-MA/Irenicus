{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text (Text)
import qualified Data.Text as Text

import Control.Applicative ((<|>))

import qualified Telegram.Bot.API as Telegram
import Telegram.Bot.Simple
import Telegram.Bot.Simple.Debug
import Telegram.Bot.Simple.UpdateParser

newtype Model = Model
  { todoItems :: [TodoItem]
  } deriving (Show)

type TodoItem = Text

addItem :: TodoItem -> Model -> Model
addItem item model = model {todoItems = item : todoItems model}

removeItem :: TodoItem -> Model -> Either Text Model
removeItem item model
  | item `notElem` items = Left "error"
  | otherwise = Right model {todoItems = filter (/= item) items}
  where
    items = todoItems model

showItems :: [TodoItem] -> Text
showItems = Text.unlines

data Action
  = NoAction
  | AddItem Text
  | RemoveItem Text
  | ShowItems
  | Start
  deriving (Show)

startMessage :: Text
startMessage =
  Text.unlines
    [ "Sou Jon Irenicus, o bot pessoal do @lambdama e"
    , " também gerencio outros serviços úteis de outras"
    , " comunidades de São Luís - MA."
    , ""
    , "Comandos: "
    , ""
    , "/start - Mostra essa mensagem"
    , "/add - Adiciona um evento"
    , "/remove - Remove um evento"
    , "/show - Mostra todos os eventos"
    , "/nopodcastmode - Deleta os podcasts de Jherferson"
    , "/podcastmode - Permite que Jherferson poste podcast"
    ]

bot :: BotApp Model Action
bot =
  BotApp
    { botInitialModel = Model []
    , botAction = flip handleUpdate
    , botHandler = handleAction
    , botJobs = []
    }

handleUpdate :: Model -> Telegram.Update -> Maybe Action
handleUpdate model =
  parseUpdate $
  ShowItems <$ command "show" <|> AddItem <$> command "add" <|>
  RemoveItem <$> command "remove" <|>
  Start <$ command "start"

handleAction :: Action -> Model -> Eff Action Model
handleAction action model =
  case action of
    NoAction -> pure model
    AddItem title ->
      addItem title model <# do
        replyText "Evento Adicionado"
        pure ShowItems
    RemoveItem title ->
      case removeItem title model of
        Left err ->
          model <# do
            replyText err
            pure NoAction
        Right newModel ->
          newModel <# do
            replyText "Evento removido"
            pure NoAction
    ShowItems ->
      model <# do
        replyText (showItems (todoItems model))
        pure NoAction
    Start ->
      model <# do
        replyText startMessage
        pure NoAction

run :: Telegram.Token -> IO ()
run token = do
  env <- Telegram.defaultTelegramClientEnv token
  startBot_ (traceBotDefault bot) env

main :: IO ()
main = getEnvToken "TELEGRAM_BOT_TOKEN" >>= run
