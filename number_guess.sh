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
# insert into database
INSERT_USERNAME_RESULT=$($PSQL "INSERT INTO info(username) VALUES('$NAME')")
else
# exist user
# get info
GAMES_PLAYED=$($PSQL "SELECT games_played FROM info WHERE username = '$USERNAME'")
BEST_GAME=$($PSQL "SELECT best_game FROM info WHERE username = '$USERNAME'")
echo -e "\nWelcome back, $USERNAME! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
fi

READ_NUMBER(){
echo -e "\nGuess the secret number between 1 and 1000:"
# read user guess input
read GUESS_INPUT
GUESS_NUMBER
}

# generate secret number
GUESS_NUMBER(){
  SECRET_NUMBER=$(( RANDOM % 1000 + 1))

if [[ ! GUESS_INPUT =~ ^[0-9]*$ ]]
then
# not an integer
echo -e "\nThat is not an integer, guess again:"
read GUESS_INPUT
else
  if [[ $GUESS_INPUT < $SECRET_NUMBER ]]
  then
  # secret number lower than guess number
  echo -e "\nIt's lower than that, guess again:"
  READ_NUMBER
  elif [[ $GUESS_INPUT > $SECRET_NUMBER ]]
  then
  # secret number higher than guess number
  echo -e "\nIt's higher than that, guess again:"
  READ_NUMBER
  else
  # secret number guessed
  echo -e "\nYou guessed it in <number_of_guesses> tries. The secret number was $SECRET_NUMBER. Nice job!"
  exist
  fi
fi
}

$READ_NUMBER