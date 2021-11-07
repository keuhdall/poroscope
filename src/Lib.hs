{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE LambdaCase #-}

module Lib (startApp) where

import Network.Wai
import Network.Wai.Handler.Warp
import Servant

import Horoscope
import Database

import Control.Monad.IO.Class (liftIO)
import Data.ByteString.Char8 (unpack)
import Hasql.Session (QueryError(..))

type API =  "horoscopes" :> Get '[JSON] [Horoscope]

port :: Int
port = 8080

startApp :: IO ()
startApp = do
  putStrLn $ "Started server on port " ++ show port
  run port app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = getHoroscopes

getHoroscopes :: Handler [Horoscope]
getHoroscopes = liftIO $ execQuery getAllHoroscopesStatement >>= \case
  Left (QueryError err _ _) -> do
    putStrLn $ unpack err
    pure []
  Right result -> pure result
