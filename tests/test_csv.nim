import ../csv/csv

proc test1() =
  ## Test read whole file
  echo "Running test1..."
  let csvh: CSVHandler = newCSVHandler()
  csvh.initCSVHandler("test_csv.csv", ',')
  echo $csvh

when isMainModule:
  test1()