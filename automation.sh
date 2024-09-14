#!/bin/bash
# FINAL CORRECT VERSION OF THE SCRIPT

# Set up repository
mkdir contribution-graph
cd contribution-graph
git init

# Dates for contribution (start date in 2005 since GitHub can only go back to 2005)
start_date="2003-01-01"

# Define the Z3RO-O pattern for a 52×7 grid
pattern=(
  "00000001000000000100001000100001000100000001000100000000000"  # Row 3
  "00000010000001111100001111100001000100111001000100000000000"  # Row 4
  "00000100000000000100001010000001000100000001000100000000000"  # Row 5
  "00001000000000000100001001000001000100000001000100000000000"  # Row 6
  "00001111100001111100001000100001111100000001111100000000000"  # Row 7
  "00011111000011111000011111000011111000000011111000000000000"  # Row 1 (Z3RO-O)
  "00000001000000001000010001000010001000000010001000000000000"  # Row 2
)

# Iterate over the pattern and create commits for each "1"
for week in {0..51}; do
  for day in {0..6}; do
    if [ "${pattern[day]:week:1}" == "1" ]; then
      # Calculate the commit date
      commit_date=$(date -d "$start_date +$((week * 7 + day)) days" +"%Y-%m-%dT12:00:00")
      
      # Create 3 commits for each '1'
      for i in {1..3}; do
        touch file-$week-$day-$i.txt
        git add .
        GIT_COMMITTER_DATE="$commit_date" git commit --date="$commit_date" -m "Contribution for Z3RO-O on $commit_date (commit $i)"
      done
    fi
  done
done

# Push the result to GitHub (replace with your remote URL)
git remote add origin https://github.com/Z3RO-O/time-travel-is-easy-af.git
git push -u origin main

echo "Contribution graph art creation completed!"
