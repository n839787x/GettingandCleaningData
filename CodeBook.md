The run_analysis.R program does the following

1. Loads package dplyr 
2. Assigns Files to variables
3. Reads and Merge the Training Data
4. Reads and Merge the Test Data
5. Combines the Training and Test Data
6. Adds labels to the file to the combined data
7. Gets all data related to mean and standard deviation using grep function
8. Joins the Combined Data with the Activity Labels file but Activity_ID
9. Renames some columns
10. Gets the average of each activity and subject
11. Creates a final Text Dataset
