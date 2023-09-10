#!/bin/bash

# Check wordlists
if [ ! -f "ss" ] || [ ! -f "ss2" ]; then
  echo "One or both of the wordlists do not exist."
  exit 1
fi

# Read the lines
mapfile -t wordlist1 < ssn1
mapfile -t wordlist2 < ssn2

# Check length
if [ ${#wordlist1[@]} -ne ${#wordlist2[@]} ]; then
  echo "The wordlists must have the same number of items."
  exit 1
fi

# Loop 
for ((i = 0; i < ${#wordlist1[@]}; i++)); do
  email="${wordlist1[i]}"
  password="${wordlist2[i]}"
  echo "Running curl with email: $email and password: $password"
  
  # curl request with email and password variables
  curl -X POST -H "Content-Type: application/json" -d "{\"email\":\"$email\",\"password\":\"$password\"}" http://{{URL}}/login --fail --silent
  
  # Check the response and handle it as needed
  if [ $? -eq 0 ]; then
    echo "Login succeeded."
  else
    echo "Login failed."
  fi
done
