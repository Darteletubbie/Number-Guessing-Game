#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

echo Enter your username:
read NAME

# search username
# exist user
echo -e "\nWelcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses."
# new user
echo -e "\nWelcome, <username>! It looks like this is your first time here."

# generate secret number

# read user guess input
echo -e "\nGuess the secret number between 1 and 1000:"
# not an integer
echo -e "\nThat is not an integer, guess again:"
# secret number lower than guess number
echo -e "\nIt's lower than that, guess again:"
# secret number higher than guess number
echo -e "\nIt's higher than that, guess again:"
# secret number guessed
echo -e "\nYou guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!"