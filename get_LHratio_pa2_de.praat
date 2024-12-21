# Define the paths to the directories containing the sound files
original_directory$ = "/Users/gim-yeonsu/Desktop/project/cropped/fem_cut/"
cloned_directory$ = "/Users/gim-yeonsu/Desktop/project/pair_1/cloned_fem/"

# Initialize an empty string to accumulate results
results$ = "Filename" + tab$ + "LH Ratio" + tab$ + "Type" + newline$

# Function to calculate LH ratio directly in the loop
# Loop through each original sound file in the directory
for i from 1 to 40
    # Construct the file path for the current original sound file
    file_path$ = original_directory$ + "fem_" + string$(i) + "_cut.wav"
    file_name$ = "fem_" + string$(i) + "_cut.wav"
    
    # Read the sound file
    Read from file: file_path$


	# Apply De-emphasis filter 
    Filter (de-emphasis): 50.0

    # Convert to Spectrum
    To Spectrum: 0

    # Select the Spectrum object
    spectrum_id = selected("Spectrum")
    selectObject: spectrum_id
    
    # Query the band energy for the low-frequency range (0 to 4000 Hz)
    low_energy_pascal = Get band energy... 0 4000

    # Query the band energy for the high-frequency range (4000 to 8000 Hz)
    high_energy_pascal = Get band energy... 4000 8000

    # Calculate the LH ratio
    lh_ratio = low_energy_pascal / high_energy_pascal

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(lh_ratio, 2) + tab$ + "original" + newline$

    # Clean up: remove the Spectrum object
    select spectrum_id
    Remove
endfor

# Loop through each cloned sound file in the directory
for i from 1 to 40
    # Construct the file path for the current cloned sound file
    file_path$ = cloned_directory$ + "output_v2_kr_fem_" + string$(i) + ".wav"
    file_name$ = "output_v2_kr_fem_" + string$(i) + ".wav"
    
    # Read the sound file
    Read from file: file_path$


	# Apply De-emphasis filter 
    Filter (de-emphasis): 50.0

    # Convert to Spectrum
    To Spectrum: 0

    # Select the Spectrum object
    spectrum_id = selected("Spectrum")
    selectObject: spectrum_id

    # Query the band energy for the low-frequency range (0 to 4000 Hz)
    low_energy_pascal = Get band energy... 0 4000

    # Query the band energy for the high-frequency range (4000 to 8000 Hz)
    high_energy_pascal = Get band energy... 4000 8000

    # Calculate the LH ratio
    lh_ratio = low_energy_pascal / high_energy_pascal

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(lh_ratio, 2) + tab$ + "cloned" + newline$

    # Clean up: remove the Spectrum object
    select spectrum_id
    Remove
endfor

# Print all results to the info window at once
writeInfo: results$

# Print completion message
appendInfoLine: "Analysis complete."