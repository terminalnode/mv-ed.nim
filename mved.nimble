# Package
version       = "0.1.0"
author        = "Alexander Rundberg"
description   = "Move and/or rename multiple files at once using your favourite editor"
license       = "MIT"
binDir        = "bin"
srcDir        = "src"
bin           = @["main"]
namedBin     = { "bin/main": "mv-ed" }.toTable()


# Dependencies
requires "nim >= 2.0.0"
