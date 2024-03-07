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
  ##  * path: string: Path to the file
  ##  * sep: Separator in the CSV (usually comma)
  try:
    discard expandFilename(path)
  except:
    echo "[loadCSV]: File at " & path & " does not exist!"
    return

  # echo "[loadCSV]: Opening '" & expandFilename(path) & "'"
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

proc getEntry*(self: CSVHandler, key: string): seq[string] =
  ## Gets a specific row of the CSV given a key
  ## 
  ## Parameters
  ##  * key: string: The key for the row to extract (first column)
  ##
  ## Returns
  ##  * seq[string]: The contents of the row
  ##  * Raises KeyError exception if failed
  return self.contents[key]

proc insertEntry*(self: CSVHandler, entry: seq[string]): bool =
  ## Inserts an entry into the CSVHandler
  ## The entry must contain the same number of elements as
  ## the columns.
  ## 
  ## Parameters
  ##  * entry: seq[string]: Entry to add
  ## 
  ## Returns
  ##  * true: On success
  ##  * false: On failure
  if entry.len != len(self.columns):
    return false

  var foundKey: bool = false
  var keyName: string = ""
  for col in entry:
    if foundKey == false:
      self.contents[col] = @[]
      foundKey = true
      keyName = col
    else:
      self.contents[keyName].add(col)
  return true

proc deleteEntry*(self: CSVHandler, key: string): bool =
  ## Deletes an entry from the CSVHandler
  ## Only does anything if the key exists in CSVHandler's
  ## contents
  ## 
  ## Parameters
  ##  * key: string: Key for the row to delete
  ## 
  ## Returns
  ##  * true: If successful
  ##  * false: Otherwise
  if not self.contents.contains(key):
    return false
  
  self.contents.del(key)
  return true
