{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.IO.Class (liftIO)
import DB.Types
import Database.Groundhog
import Database.Groundhog.Sqlite
import Test.Hspec

main :: IO ()
main = hspec spec


spec :: Spec
spec =
  describe "Sample Queries" $ do
    it "Insert and Retrieve a User" $ do
      muser <- withSqliteConn ":memory:" $ runDbConn $ do
        runMigration $ migrate (undefined :: User)
        _ <- insert $ User 1 "Scott" "smurphy@plowtech.net"
        getBy (UserDbKey 1)
      muser `shouldBe` (Just (User 1 "Scott" "smurphy@plowtech.net"))

    it "Insert and Retrieve a WorkOrder" $ do
      mworkorder <- withSqliteConn ":memory:" $ runDbConn $ do
        runMigration $ migrate (undefined :: WorkOrder)
        _ <- insert $ WorkOrder 1 "X-1" WorkOrderClosed
        getBy (WorkOrderDbKey 1)
      mworkorder `shouldBe` (Just (WorkOrder 1 "X-1" WorkOrderClosed))
