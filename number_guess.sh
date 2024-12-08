#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo Enter your username:
read NAME
USERNAME=$($PSQL "SELECT username FROM info WHERE username='$NAME'")

# search username
if [[ -z $USERNAME ]]
then
# new user
echo -e "\nWelcome, $NAME! It looks like this is your first time here."

else
# exist user
# get info
GAMES_PLAYED=$($PSQL "SELECT count(username) FROM info WHERE username = '$NAME'")
BEST_GAME=$($PSQL "SELECT min(number_of_guess) FROM info WHERE username = '$NAME'")
echo -e "\nWelcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# generate secret number
SECRET_NUMBER=$(( RANDOM % 1000 + 1))
echo -e "\n$SECRET_NUMBER"
# count guessing time
NUMBER_OF_GUESS=0

echo -e "\nGuess the secret number between 1 and 1000:"
while true
do
# read user guess input
read GUESS_INPUT

# read input
if [[ $GUESS_INPUT =~ ^[0-9]+$ ]]
then
(( NUMBER_OF_GUESS++ ))
  if (( GUESS_INPUT > SECRET_NUMBER ))
  then
  # secret number lower than guess number
  echo -e "\nIt's lower than that, guess again:"
  elif (( GUESS_INPUT < SECRET_NUMBER ))
  then
  # secret number higher than guess number
  echo -e "\nIt's higher than that, guess again:"
  else
  # secret number guessed
  echo -e "\nYou guessed it in $NUMBER_OF_GUESS tries. The secret number was $SECRET_NUMBER. Nice job!"
  # insert into database
  GAME_INSERT_RESULT=$($PSQL "INSERT INTO info(username, number_of_guess) VALUES('$NAME', $NUMBER_OF_GUESS)")
  exit
  fi
else
# not an integer
echo -e "\nThat is not an integer, guess again:"
fi
done