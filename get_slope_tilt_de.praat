# Define the paths to the directories containing the sound files
original_directory$ = "/Users/gim-yeonsu/Desktop/project/cropped/fem_cut/"
cloned_directory$ = "/Users/gim-yeonsu/Desktop/project/pair_1/cloned_fem/"

# Initialize an empty string to accumulate results
results$ = "Filename" + tab$ + "Tilt" + tab$ + "Slope" + tab$ + "Type" + newline$

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

    # Convert to LTAS (1-to-1)
    To Ltas (1-to-1)

    # Select the LTAS object
    ltas = selected("Ltas")

    # Calculate tilt
    reportSpectralTrend$ = Report spectral trend: 0.1, 8000, "Linear", "Robust"
    tilt = extractNumber (reportSpectralTrend$, "Slope:")
    tilt_1 = tilt * 1000

    # Calculate slope
    slope = Get slope: 0, 1000, 1000, 4000, "energy"

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(tilt_1, 2) + tab$ + fixed$(slope, 2) + tab$ + "original" + newline$

    # Clean up: remove the LTAS object
    select ltas
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

    # Convert to LTAS (1-to-1)
    To Ltas (1-to-1)

    # Select the LTAS object
    ltas = selected("Ltas")

    # Calculate tilt
    reportSpectralTrend$ = Report spectral trend: 0.1, 8000, "Linear", "Robust"
    tilt = extractNumber (reportSpectralTrend$, "Slope:")
    tilt_1 = tilt * 1000

    # Calculate slope
    slope = Get slope: 0, 1000, 1000, 4000, "energy"

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(tilt_1, 2) + tab$ + fixed$(slope, 2) + tab$ + "cloned" + newline$

    # Clean up: remove the LTAS object
    select ltas
    Remove
endfor

# Print all results to the info window at once
writeInfo: results$

# Print completion message
appendInfoLine: "Analysis complete."