import pandas as pd
import scipy.io as sio
from datetime import datetime
import numpy as np
import os

# Read the CSV files
input_dir = '../../../../data/incoming/DEW/wq/WQ_HCHB_2024'
csv_files = [f for f in os.listdir(input_dir) if f.endswith('.csv')]

# Read the variable conversion file
var_conv_df = pd.read_csv('Var_Conv_1998_2019.csv')
# Create a dictionary for easy lookup of new names and conversion factors
var_conv_dict = {row['Old Name']: {'new_name': row['New Name'], 'conv': row['Conv']} 
                 for _, row in var_conv_df.iterrows()}
print(var_conv_dict)

# Read the site conversion file
site_conv_df = pd.read_csv('Site_Conv.csv')

# After reading the site conversion file
print("\nSite conversion file columns:", site_conv_df.columns.tolist())
print("\nFirst few rows of site_conv_df:")
print(site_conv_df.head())

# Initialize dictionary to store data
data_dict = {}

# Define the base date for MATLAB datenum (Jan 1, 0000)
# Use Jan 1, 1900 as a practical starting point
base_date = datetime(1900, 1, 1)  # Practical base date

# Calculate the offset in days between MATLAB base date (Jan 1, 0000) and our base date (Jan 1, 1900)
# MATLAB datenum starts from Jan 1, 0000, which is 693960 days before Jan 1, 1900
offset_days = 693960

# Function to convert datetime to MATLAB datenum equivalent
def matlab_datenum(dt):
    # Calculate the number of days between the given date and the base date
    delta_days = (dt - base_date).days
    # Include the fractional part of the day
    datenum = delta_days + offset_days + (dt.hour / 24.0) + (dt.minute / 1440.0) + (dt.second / 86400.0)
    return datenum

# Add debugging counters
total_sites = 0
matched_sites = 0
unique_combinations = set()

for csv_file in csv_files:
    if csv_file == 'Coorong Water Quality Jan 1998 to Dec 2019.csv':
        print(csv_file)
        df = pd.read_csv(os.path.join(input_dir, csv_file),header=0)
        print(df.head())

         # Print unique combinations of Site_ID, Easting, and Northing
        for idx, row in df.groupby(['Sampling_point', 'Easting', 'Northing']).first().reset_index().iterrows():
            total_sites += 1
            combo = (row['Sampling_point'], row['Easting'], row['Northing'])
            unique_combinations.add(combo)
            print(f"\nChecking combination:")
            print(f"Site_ID: {combo[0]}")
            print(f"Easting: {combo[1]}")
            print(f"Northing: {combo[2]}")
            
            # Find matching site in conversion table
            site_match = site_conv_df[
                (site_conv_df['old_NAME'] == combo[0]) &
                (site_conv_df['Agency'] == 'AWQC') &
                (site_conv_df['Easting'] == combo[1]) &
                (site_conv_df['Northing'] == combo[2])
            ]
            
            if len(site_match) > 0:
                matched_sites += 1
                print(f"Matched to: {site_match['new_NAME'].iloc[0]}")
            else:
                print(f"NO MATCH FOUND for this combination")

        df['Date'] = pd.to_datetime(df['Date'],format='mixed')

        # Get list of variable columns (excluding specified columns)
        exclude_cols = ['Sampling_point', 'Date', 'Easting', 'Northing']
        variable_cols = [col for col in df.columns if col not in exclude_cols]
        
        # Process each unique combination of Site_ID, Easting, and Northing
        for _, combo in df[['Sampling_point', 'Easting', 'Northing']].drop_duplicates().iterrows():
            site_id = combo['Sampling_point']
            easting = combo['Easting']
            northing = combo['Northing']
            
            site_data = df[
                (df['Sampling_point'] == site_id) & 
                (df['Easting'] == easting) &
                (df['Northing'] == northing)
            ]
            
            # Find matching site in conversion table
            site_match = site_conv_df[
                (site_conv_df['old_NAME'] == combo[0]) &
                (site_conv_df['Agency'] == 'AWQC') &
                (site_conv_df['Easting'] == combo[1]) &
                (site_conv_df['Northing'] == combo[2])
            ]
            
            if len(site_match) > 0:
                # Add agency prefix to the site name
                agency_prefix = 'AWQC' + '_'
                site_name = agency_prefix + site_match['new_NAME'].iloc[0]
            else:
                print(f"Warning: No matching site found for {site_id} at coordinates ({easting}, {northing})")
                continue
            
            if site_name not in data_dict:
                data_dict[site_name] = {}
            
            # Process each variable
            for var in variable_cols:
                # Skip if variable not in conversion dictionary
                if var not in var_conv_dict:
                    continue
                    
                var_data = site_data[['Date', var, 'Easting', 'Northing', 'Sampling_point']]
                var_data = var_data.dropna(subset=[var])
                
                # Filter out entries containing "<" or ">"
                var_data = var_data[~var_data[var].astype(str).str.contains('[<>]')]
                
                if len(var_data) == 0:
                    continue
                
                # Convert the data column to numeric values
                var_data[var] = pd.to_numeric(var_data[var])
                
                # Get new variable name and conversion factor
                new_var_name = var_conv_dict[var]['new_name']
                conv_factor = var_conv_dict[var]['conv']
                
                if new_var_name not in data_dict[site_name]:
                    data_dict[site_name][new_var_name] = {
                        'Date': [],
                        'Data': [],
                        'Depth': [],
                        'X': [],
                        'Y': [],
                        'Name': [],
                        'Agency': []
                    }
                
                # Convert dates to datetime objects first
                dates = pd.to_datetime(var_data['Date'], dayfirst=True)
                
                # Apply conversion factor to the data
                converted_data = var_data[var].values * conv_factor
                
                data_dict[site_name][new_var_name]['Date'].extend(dates)
                data_dict[site_name][new_var_name]['Data'].extend(converted_data)
                data_dict[site_name][new_var_name]['Depth'].extend([0.0] * len(var_data))
                data_dict[site_name][new_var_name]['X'].extend(var_data['Easting'].values.astype(float))
                data_dict[site_name][new_var_name]['Y'].extend(var_data['Northing'].values.astype(float))
                data_dict[site_name][new_var_name]['Name'].extend([site_id] * len(var_data))
                data_dict[site_name][new_var_name]['Agency'].extend('AWQC' * len(var_data))

            idx += 1  # Increment idx after processing each site

# Convert lists to numpy arrays and create final MATLAB structure
matlab_dict = {'cllmm': {}}
for site_idx, variables in data_dict.items():
    matlab_dict['cllmm'][site_idx] = {}
    for var_name, var_data in variables.items():
        # Convert dates to MATLAB format
        matlab_dates = np.array([matlab_datenum(d) for d in var_data['Date']])[:,None]
        
        matlab_dict['cllmm'][site_idx][var_name] = {
            'Date': matlab_dates,
            'Data': np.array(var_data['Data'])[:,None],
            'Depth': np.array(var_data['Depth'], dtype=np.float64)[:,None],
            'X': float(var_data['X'][0]),
            'Y': float(var_data['Y'][0]),
            'Name': var_data['Name'][0],
            'Agency': 'AWQC'
        }

# Save to MAT file
output_file = '../../../../data/store/ecology/cllmm_DATASA_1998_2019.mat'
sio.savemat(output_file, matlab_dict)

# At the end of the script, print summary
print(f"\nSummary:")
print(f"Total unique site combinations found: {total_sites}")
print(f"Successfully matched sites: {matched_sites}")
print(f"Unmatched sites: {total_sites - matched_sites}")
print("\nUnique combinations that were processed:")
for combo in sorted(unique_combinations):
    print(f"Site_ID: {combo[0]}, Easting: {combo[1]}, Northing: {combo[2]}")