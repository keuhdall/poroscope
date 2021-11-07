{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE TemplateHaskell    #-}
{-# LANGUAGE TypeOperators      #-}

module Horoscope where

import Hasql.Statement
import Hasql.Encoders as E
import Hasql.Decoders as D
import Data.Text as T
import Data.Int
import Data.Aeson
import Data.Aeson.TH
import Data.UUID as UUID

data Horoscope = Horoscope {
  id      :: String,
  content :: String
} deriving (Eq, Show)

$(deriveJSON defaultOptions ''Horoscope)

horoscopeRow :: Row Horoscope
horoscopeRow = Horoscope <$> idColumn <*> contentColumn
  where
    idColumn      = UUID.toString <$> D.column (D.nonNullable D.uuid)
    contentColumn = T.unpack  <$> D.column (D.nonNullable D.text)

getAllHoroscopesStatement :: Statement () [Horoscope]
getAllHoroscopesStatement = Statement
  "SELECT * FROM horoscopes"
  noParams
  (D.rowList horoscopeRow)
  True

getHoroscopeFromIdStatement :: Statement Int64 (Maybe Horoscope)
getHoroscopeFromIdStatement = Statement
  "SELECT * FROM horoscopes WHERE id = $1"
  (E.param $ E.nonNullable E.int8)
  (D.rowMaybe horoscopeRow)
  True