*** Settings ***
Library  DatabaseLibrary
Library  String
Library  Dialogs


*** Variables ***
# replace the server & credentials with your own
${DB_NAME} =  test
${DB_USER_NAME} =  root
${DB_USER_PASSWORD} =  Password
${DB_HOST} =  localhost
${DB_PORT} =  13306
${PREVIOUS_ROW_COUNT}

*** Keywords ***
Connect
    Connect To Database  pymysql  ${DB_NAME}  ${DB_USER_NAME}  ${DB_USER_PASSWORD}  ${DB_HOST}  ${DB_PORT}

Save Current Row Count
    ${current_row_count} =  Row Count  SELECT * FROM DemoItems;
    Set Suite Variable  ${PREVIOUS_ROW_COUNT}  ${current_row_count}
    Log  ${current_row_count}

Get Input Data
    # from the dialogs library
    ${name} =  Get Value From User  Enter a First Name
    # save it at the suite scope so subsequent test can use it
    Set Suite Variable  ${FIRST_NAME}  ${name}

Insert Record
    # Execute SQL Script  Inputs/SQL/insert.txt
    # Notice I've put the first name variable inside single quotes
    Execute SQL String  INSERT INTO test.DemoItems (ItemName, FirstName) VALUES (current_timestamp , '${FIRST_NAME}');;

Verify New Record Added
    ${new_row_count} =  Row Count  SELECT * FROM DemoItems;
    Log  ${new_row_count}
    # notice that I'm using +1 INSIDE the braces, not after the final brace
    Should be Equal as Numbers  ${new_row_count}  ${PREVIOUS_ROW_COUNT + 1 }

Verify Last Record
    # notice here we use TOP 1 instead of LIMIT 1 in MySQL
    ${queryResults} =  Query  SELECT * FROM test.DemoItems ORDER BY ItemId DESC LIMIT 1
    # Examine the (0-based) 3rd field of the first record in the results
    Should be Equal as Strings  ${queryResults[0][2]}  ${FIRST_NAME}
    Log  ${queryResults[0][2]}

Log All Rows
    ${queryResults} =  Query  SELECT * FROM DemoItems ORDER BY ItemId
    Log Many  ${queryResults}

Disconnect
    Disconnect from Database