{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE KindSignatures    #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

module DB.Types (
   module DB.Types
 , module Shared.Types
 ) where

import Data.ByteString.Lazy.Internal (ByteString)
import Database.Groundhog.Converters
import Shared.Types

import Database.Groundhog.Sqlite ()
import Database.Groundhog.TH

workOrderStatusConverter :: Converter WorkOrderStatus ByteString
workOrderStatusConverter = jsonConverter

mkPersist defaultCodegenConfig [groundhog|
- entity: User
  autoKey: null
  keys:
    - name: userDb
      type: primary
      default: true
  constructors:
    - name: User
      fields:
        - name: userName
          dbName: name
        - name: userEmail
          dbName: email
      uniques:
        - name: userDb
          fields: [userId]

- entity: WorkOrder
  autoKey: null
  keys:
    - name: workOrderDb
      type: primary
      default: true
  constructors:
    - name: WorkOrder
      fields:
        - name: workOrderOrderNum
        - name: workOrderWorkOrderStatus
      uniques:
        - name: workOrderDb
          fields: [workOrderId]

- primitive: WorkOrderStatus
  converter: workOrderStatusConverter
|]

{-


- entity: OnPingIdToRocLocationKey
  autoKey: null
  keys:
    - name: OnPingIdToRocLocationKeyConstraint
      type: primary
      default: true
  constructors:
    - name: OnPingIdToRocLocationKey
      fields:
        - name: _mappedOnPingId
          dbName: onPingId
          exprName: MappedOnPingIdField
        - name: _mappedRocLocationKey
          dbName: locationKey
          exprName: MappedRocLocationField
          converter: locationKeyConverter
      uniques:
        - name: OnPingIdToRocLocationKeyConstraint
          fields: [_mappedOnPingId]


-}