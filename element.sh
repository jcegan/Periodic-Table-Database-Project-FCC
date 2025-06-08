#!/bin/bash

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else 
  PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1' OR symbol = '$1' OR name = '$1'")
  if [[ $ATOMIC_NUMBER ]]
  then
    RETRIEVE_INFO=$($PSQL "SELECT * FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number WHERE elements.atomic_number = $ATOMIC_NUMBER")
    echo "$RETRIEVE_INFO" | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID
    do
      echo "test $TYPE"
    done
  fi
fi
