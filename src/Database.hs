{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}

module Database where

import Hasql.Connection
import Hasql.Statement
import Hasql.Session
import Data.ByteString.Char8 (ByteString)

connectionSettings :: Settings
connectionSettings = settings
  "localhost"   -- hostname
  5432          -- port
  "root"        -- user
  "admin"       -- password
  "poroscope"   -- database

customQueryError :: ByteString -> QueryError
customQueryError bs = QueryError bs [] (ClientError Nothing)

genericQueryError :: QueryError
genericQueryError = QueryError "Failed to connect to database" [] (ClientError Nothing)

connect :: IO ()
connect = do
  connectionResult <- acquire connectionSettings
  case connectionResult of
    Left _ -> error "Failed to connect to database"
    Right connection -> release connection

sessionFromStatement :: Statement () a -> Session a
sessionFromStatement = statement ()

execQuery :: Statement () a -> IO (Either QueryError a)
execQuery stmt = acquire connectionSettings >>= \case
  Left (Just err) -> pure . Left $ customQueryError err
  Left Nothing    -> pure $ Left genericQueryError
  Right connection -> do
    queryResult <- run (sessionFromStatement stmt) connection
    release connection
    pure queryResult
