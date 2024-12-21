# Define the paths to the directories containing the sound files
original_directory$ = "/Users/gim-yeonsu/Desktop/project/cropped/male_cut/"
cloned_directory$ = "/Users/gim-yeonsu/Desktop/project/pair_1/cloned_male/"

# Initialize an empty string to accumulate results
results$ = "Filename" + tab$ + "MeanF0" + tab$ + "F0_SD" + tab$ + "F0_Range" + tab$ + "Type" + newline$

# Loop through each original sound file in the directory
for i from 1 to 40
    # Construct the file path for the current original sound file
    file_path$ = original_directory$ + "male_" + string$(i) + "_cut.wav"
    file_name$ = "male_" + string$(i) + "_cut.wav"
    
    # Read the sound file
    Read from file: file_path$
    
    # Calculate Mean F0
    To Pitch: 0.0, 75, 600
    meanF0 = Get mean: 0, 0, "Hertz"
    
    # Calculate F0 Standard Deviation
    f0_sd = Get standard deviation: 0, 0, "Hertz"
    
    # Calculate F0 Range (Max - Min)
    f0_min = Get minimum: 0, 0, "Hertz", "Parabolic"
    f0_max = Get maximum: 0, 0, "Hertz", "Parabolic"
    f0_range = f0_max - f0_min
    
    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(meanF0, 2) + tab$ + fixed$(f0_sd, 2) + tab$ + fixed$(f0_range, 2) + tab$ + "original" + newline$

    # Clean up: remove the Pitch object
    select all
    Remove
endfor

# Loop through each cloned sound file in the directory
for i from 1 to 40
    # Construct the file path for the current cloned sound file
    file_path$ = cloned_directory$ + "output_v2_kr_male_" + string$(i) + ".wav"
    file_name$ = "output_v2_kr_male_" + string$(i) + ".wav"
    
    # Read the sound file
    Read from file: file_path$
    
    # Calculate Mean F0
    To Pitch: 0.0, 75, 600
    meanF0 = Get mean: 0, 0, "Hertz"
    
    # Calculate F0 Standard Deviation
    f0_sd = Get standard deviation: 0, 0, "Hertz"
    
    # Calculate F0 Range (Max - Min)
    f0_min = Get minimum: 0, 0, "Hertz", "Parabolic"
    f0_max = Get maximum: 0, 0, "Hertz", "Parabolic"
    f0_range = f0_max - f0_min
    
    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(meanF0, 2) + tab$ + fixed$(f0_sd, 2) + tab$ + fixed$(f0_range, 2) + tab$ + "cloned" + newline$

    # Clean up: remove the Pitch object
    select all
    Remove
endfor

# Print all results to the info window at once
writeInfo: results$

# Print completion message
appendInfoLine: "F0 Analysis complete."