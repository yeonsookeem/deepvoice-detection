# Define the paths to the directories containing the sound files
original_directory$ = "/Users/gim-yeonsu/Desktop/project/cropped/male_cut/"
cloned_directory$ = "/Users/gim-yeonsu/Desktop/project/pair_1/cloned_male/"

# Initialize an empty string to accumulate results
results$ = "Filename" + tab$ + "RNR" + tab$ + "Type" + newline$

# Loop through each original sound file in the directory
for i from 1 to 40
    # Construct the file path for the current original sound file
    file_path$ = original_directory$ + "male_" + string$(i) + "_cut.wav"
    file_name$ = "male_" + string$(i) + "_cut.wav"
    
    # Read the sound file
    Read from file: file_path$

    # Convert Sound object to Spectrum
    To Spectrum: "yes"

    # Convert Spectrum object to Cepstrum
    To Cepstrum

    # Convert Cepstrum object to PowerCepstrum
    Down to PowerCepstrum

    # Smooth the PowerCepstrum object
    Smooth: 0.0001, 1

    # Get rhamonics to noise ratio
    rnr = Get rhamonics to noise ratio: 60, 333.3, 0.05

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(rnr, 2) + tab$ + "original" + newline$

    # Clean up: remove the PowerCepstrum object
    Remove
endfor

# Loop through each cloned sound file in the directory
for i from 1 to 40
    # Construct the file path for the current cloned sound file
    file_path$ = cloned_directory$ + "output_v2_kr_male_" + string$(i) + ".wav"
    file_name$ = "output_v2_kr_male_" + string$(i) + ".wav"
    
    # Read the sound file
    Read from file: file_path$

    # Convert Sound object to Spectrum
    To Spectrum: "yes"

    # Convert Spectrum object to Cepstrum
    To Cepstrum

    # Convert Cepstrum object to PowerCepstrum
    Down to PowerCepstrum

    # Smooth the PowerCepstrum object
    Smooth: 0.0001, 1

    # Get rhamonics to noise ratio
    rnr = Get rhamonics to noise ratio: 60, 333.3, 0.05

    # Append the values to the results string, formatting to 2 decimal places
    results$ = results$ + file_name$ + tab$ + fixed$(rnr, 2) + tab$ + "cloned" + newline$

    # Clean up: remove the PowerCepstrum object
    Remove
endfor

# Print all results to the info window at once
writeInfo: results$

# Print completion message
appendInfoLine: "Analysis complete."