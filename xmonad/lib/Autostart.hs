module Autostart (autostart, autostartWinName) where

import Data.List.Split
import Data.String.Utils
import System.IO
import XMonad
import XMonad.Util.Run

myList = [ ("skype", "skype")
         , ("thunderbird", "thunderbird")
         , ("gvim", "gvim")
         , ("firefox", "firefox")
         , ("urxvt", "urxvt")
         , ("dropbox start", "dropbox")]

autostartWinName fileName = do
    s <- readFile fileName
    let maps = map (getPairName. parseLine) $ lines s
    mapM_ startOrSkip maps

autostart :: X ()
autostart = do
    mapM_ startOrSkip myList

startOrSkip (runString, nameToGrep) = do
    ret <- pgrep nameToGrep
    case ret of
         False -> spawn runString
         _ -> return ()

pgrep name = do
    out <- runProcessWithInput "pgrep" [name] ""
    return (out /= "")

parseLine :: String -> [String]
parseLine = (take 2) . (map strip) . (splitOn ";")

getPairName :: [String] -> (String, String)
getPairName (command:name:_) = (command, name)
getPairName (command:_) = (command, command)
