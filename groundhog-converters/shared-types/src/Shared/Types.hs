{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Shared.Types where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics

-- User will have a non auto generated key
data User = User
  { userId    :: Int
  , userName  :: Text
  , userEmail :: Text
  } deriving (Eq,Read,Show)

instance ToJSON User where
  toJSON (User {..}) = object
    [ "userId" .= userId
    , "userName" .= userName
    , "userEmail" .= userEmail
    ]

instance FromJSON User where
  parseJSON = withObject "User" $ \o ->
    User <$> o .: "userId"
         <*> o .: "userName"
         <*> o .: "userEmail"

data WorkOrderStatus = WorkOrderOpen | WorkOrderClosed | WorkOrderOnHold
  deriving (Eq,Generic,Read,Show)

instance ToJSON WorkOrderStatus where
instance FromJSON WorkOrderStatus where

data WorkOrder = WorkOrder
  { workOrderId       :: Int
  , workOrderOrderNum :: Text
  , workOrderWorkOrderStatus :: WorkOrderStatus
  } deriving (Show,Generic,Eq)

instance ToJSON WorkOrder where
instance FromJSON WorkOrder where
