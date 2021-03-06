{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Models where

import Data.Fixed
import Data.Hashable
import Data.Text
import Data.Time

import Database.Persist
import Database.Persist.Sql
import Database.Persist.TH

import GHC.Generics

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
  name Text
  age  Int
  UniqueName name
  deriving Eq Read Show Generic
|]

{- produced by the QuasiQuoter
Types: User, Key User, UserId, UserName, UserAge,UniqueName, Entity UserId User
Functions: migrateAll, userName, userAge
-}

instance Hashable User

deriving instance Generic Day
instance Hashable Day
deriving instance Generic TimeOfDay
instance Hashable TimeOfDay

instance Hashable DiffTime where
  hashWithSalt s = (hashWithSalt s :: Double -> Int) . realToFrac

deriving instance Generic UTCTime
instance Hashable UTCTime

deriving instance Generic PersistValue
instance Hashable PersistValue
deriving instance Generic (BackendKey SqlBackend)
instance Hashable (BackendKey SqlBackend)

deriving instance Generic (Key User)
instance Hashable (Key User)
