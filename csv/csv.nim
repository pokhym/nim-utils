import std/os
import std/tables
import std/strutils

#[
  CSVHandler
]#
type CSVHandler* = ref object
  ## A CSV representation in nim
  
  contents* : Table[string, seq[string]]
  ## Contains a mapping between the entries
  ## and a sequence of columns for each entry
  
  columns*: Table[string, int]
  ## Contains a mapping between a column name
  ## and the column number

proc newCSVHandler*(): CSVHandler =
  ## Creates a new CSVHandler object
  ## 
  ## Returns
  ## * CSVHandler
  return new(CSVHandler)

proc `$`*(self: CSVHandler): string =
  ## Pretty print the contents
  result = ""
  result &= "Column names:\n"
  for k in self.columns.keys:
    result &= k & ","
  result &= "\n"
  result &= "Entries:\n"
  for k in self.contents.keys:
    result &= $k & ":" & $self.contents[k] & "\n"
  return result


proc initCSVHandler*(self: CSVHandler, path: string, sep: char) = 
  ## Initializes a CSVHandler by reading the file
  ## 
  ## Parametes
  ##  * self: CSVHandler
  ##  * path: string: Path to the file
  ##  * sep: Separator in the CSV (usually comma)
  try:
    discard expandFilename(path)
  except:
    echo "[loadCSV]: File at " & path & " does not exist!"
    return

  echo "[loadCSV]: Opening '" & expandFilename(path) & "'"
  let entireFile = readFile(expandFilename(path))

  # Init members
  self.contents = initTable[string, seq[string]]()
  self.columns = initTable[string, int]()

  var handledFirstLine: bool = false
  for l in entireFile.split("\n"):
    # Handle column names
    if handledFirstLine == false:
      var columnCount: int = 0
      for colName in l.split(sep):
        self.columns[colName] = columnCount
        columnCount += 1
      handledFirstLine = true
    else:
      var entryColumn: bool = false
      var currentEntryName: string = ""
      for col in l.split(sep):
        if entryColumn == false:
          self.contents[col] = @[]
          entryColumn = true
          currentEntryName = col
        else:
          self.contents[currentEntryName].add(col)
