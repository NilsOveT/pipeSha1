{-# LANGUAGE OverloadedStrings #-}

-- required packages: serialport

import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString as B
import System.Hardware.Serialport
import System.Environment
import Data.Char
import Control.Concurrent

lf = B8.singleton '\n'
cr = B8.singleton '\r'
ctrlc = B.pack [3]

sleep ms = threadDelay (1000*ms)
 
hash = ["fef34801", "7fed863c", "cb2e8b62", "d4a3ff56", "ae8d6150"]
lengthInfo = ["32", "32"]
alphG = ["4", "47673626"]
alphR = ["2", "52720000"]
alphI = ["6", "49696c31", "217c0000"]
alphS = ["6", "53735a7a", "35240000"]
alphE = ["4", "4565333d"]
alphN = ["2", "4e6e0000"]
alphNum = ["10", "30313233", "34353637", "38390000"]
alph1 = ["1", "31000000"]

main = do
  args <- getArgs
  let portname = if null args then "COM8" else map toUpper (head args)  -- COM for windows, /dev/ttyUSB0 for linux
  port <- openSerial portname defaultSerialSettings { commSpeed = CS115200 }
  putStrLn "Startsequence..."
  oblivious port ctrlc  -- ctrlc quits any process, enter always elicits a response
  oblivious port "root"  -- either logs in or executes nonexisting command
  sendline port "./sendhash"
  sleep 1000
  putStrLn "Starting program..."
  recvline port >>= print
  putStrLn "Sending hash..."
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) hash
  putStrLn "Confirming hash:"
  sleep 1000
  recvline port >>= print
  putStrLn "Sending metadata..."
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) lengthInfo
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphN
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphN
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphN
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphN
  sleep 500
  mapM_ (\part -> recvline port >> sendline port part >> sleep 300 >> recvline port >>= print) alphR
  sleep 1000
  putStrLn "Starting computation..."
  eternity port
  closeSerial port

oblivious :: SerialPort -> B.ByteString -> IO ()
oblivious port cmd = do
  sendline port cmd
  sleep 400
  flush port

eternity :: SerialPort -> IO ()
eternity port = do
  recvline port >>= print
  eternity port
  
sendline :: SerialPort -> B.ByteString -> IO ()
sendline port str = (send port $ B.append str lf) >> return ()

-- strips trailing \r if any
recvline :: SerialPort -> IO B.ByteString
recvline port = do
  line <- recvline' port []
  return $ if B.null line || B8.last line /= '\r' then line else B.init line

recvline' :: SerialPort -> [B.ByteString] -> IO B.ByteString
recvline' port sofar = do
  b <- recv port 1
  if b == lf {- || B.empty b -} then return (B.concat sofar) else recvline' port (sofar ++ [b])
