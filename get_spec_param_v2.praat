# Define the paths to the directories containing the sound files
original_directory$ = "/Users/gim-yeonsu/Desktop/project/cropped/male_cut/"
cloned_directory$ = "/Users/gim-yeonsu/Desktop/project/pair_1/cloned_male/"

# Initialize an empty string to accumulate results
results$ = "Filename" + tab$ + "COG" + tab$ + "Standard Deviation" + tab$ + "Skewness" + tab$ + "Kurtosis" + tab$ + "Type" + newline$

# Loop through each original sound file in the directory
for i from 1 to 40
    # Construct the file path for the current original sound file
    file_path$ = original_directory$ + "male_" + string$(i) + "_cut.wav"
    file_name$ = "male_" + string$(i) + "_cut.wav"
    
    # Read the sound file
    Read from file: file_path$

    # Apply Pre-emphasis filter
    Filter (pre-emphasis): 50.0

    # Convert to Spectrum
    To Spectrum: 0

    # Select the Spectrum object
    spectrum = selected("Spectrum")

    # Calculate the required values
    cog = Get centre of gravity: 2.0
    sd = Get standard deviation: 2.0
    skewness = Get skewness: 2.0
    kurtosis = Get kurtosis: 2.0

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(cog, 2) + tab$ + fixed$(sd, 2) + tab$ + fixed$(skewness, 2) + tab$ + fixed$(kurtosis, 2) + tab$ + "original" + newline$

    # Clean up: remove the Spectrum object
    select spectrum
    Remove
endfor

# Loop through each cloned sound file in the directory
for i from 1 to 40
    # Construct the file path for the current cloned sound file
    file_path$ = cloned_directory$ + "output_v2_kr_male_" + string$(i) + ".wav"
    file_name$ = "output_v2_kr_male_" + string$(i) + ".wav"
    
    # Read the sound file
    Read from file: file_path$

    # Apply Pre-emphasis filter
    Filter (pre-emphasis): 50.0

    # Convert to Spectrum
    To Spectrum: 0

    # Select the Spectrum object
    spectrum = selected("Spectrum")

    # Calculate the required values
    cog = Get centre of gravity: 2.0
    sd = Get standard deviation: 2.0
    skewness = Get skewness: 2.0
    kurtosis = Get kurtosis: 2.0

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(cog, 2) + tab$ + fixed$(sd, 2) + tab$ + fixed$(skewness, 2) + tab$ + fixed$(kurtosis, 2) + tab$ + "cloned" + newline$

    # Clean up: remove the Spectrum object
    select spectrum
    Remove
endfor

# Print all results to the info window at once
writeInfo: results$

# Print completion message
appendInfoLine: "Analysis complete."