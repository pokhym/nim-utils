import ../csv/csv
import system/exceptions

proc test1() =
  ## Test read whole file
  echo "Running test1..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  echo $csvh

proc test2() =
  ## Test key not in contents
  echo "Running test2..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  try:
    echo $csvh.getEntry("1111")
  except:
    echo getCurrentExceptionMsg()

proc test3() =
  ## Test key in contents
  echo "Running test3..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  assert csvh.getEntry("abc123") == @["a", "c", "123"]

proc test4() =
  ## Insert entry
  echo "Running test4..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  assert csvh.insertEntry(@["qwe789", "q", "e", "789"]) == true
  assert csvh.getEntry("qwe789") == @["q", "e", "789"]

when isMainModule:
  test1()
  test2()
  test3()
  test4()