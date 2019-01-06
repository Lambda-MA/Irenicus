{-# LANGUAGE OverloadedStrings #-}

module Messages where

import qualified Data.Text as Text
import Data.Text (Text)

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
    , "/podcastmode - Permite que Jherferson poste (ou não) podcasts"
    ]

podcastMessage :: Text
podcastMessage =
  Text.unlines
    ["Opção para ativas/desativar postagens de podcast", "", "Status: ", ""]
