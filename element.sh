#!/bin/bash
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else 
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1' OR symbol = '$1' OR name = '$1'")
  if [[ ! -z $ATOMIC_NUMBER ]]
  then
    echo $($PSQL "SELECT * FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number WHERE elements.atomic_number = $ATOMIC_NUMBER") | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME ATOMIC_NUMBER TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
    do
      echo "$TYPE $MELTING_POINT"
    done
  fi
fi
