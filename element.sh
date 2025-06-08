#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
  else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1' OR name = '$1'")
  fi

  if [[ $ATOMIC_NUMBER ]]
  then
    RETRIEVE_INFO=$($PSQL "SELECT * FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number WHERE elements.atomic_number = $ATOMIC_NUMBER")
    echo "$RETRIEVE_INFO" | while IFS='|' read ATOMIC_NUMBER SYMBOL NAME ATOMIC_NUMBER TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  else
    echo "I could not find that element in the database."
  fi
fi
