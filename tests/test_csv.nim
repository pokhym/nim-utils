import ../csv/csv

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

proc test5() =
  ## Delete non-existent key
  echo "Running test5..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  assert csvh.deleteEntry("asdf") == false
  echo $csvh

proc test6() =
  ## Delete existing key
  echo "Running test6..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  assert csvh.insertEntry(@["qwe789", "q", "e", "789"]) == true
  assert csvh.deleteEntry("qwe789") == true
  assert csvh.deleteEntry("abc123") == true
  echo $csvh

proc test7() =
  ## Test output
  echo "Running test7..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  csvh.saveCSV("test_csv_out.csv", ':')
  

when isMainModule:
  test1()
  test2()
  test3()
  test4()
  test5()
  test6()
  test7()