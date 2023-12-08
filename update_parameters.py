import requests
import os

# Replace with your actual OtterTune API key
ottertune_api_key = os.environ['OT_API_KEY']

# Replace with the desired database identifier
db_identifier = 'education'

# Base URL for the OtterTune API
base_url = 'https://service.ottertune.com/api'

# Make a call to retrieve the database ID
databases_url = f'{base_url}/databases'
headers = {'OT-API-KEY': ottertune_api_key}

# Replace with your config file name
terraform_file_path = 'db_params.tf'

try:
    response = requests.get(databases_url, headers=headers)
    response.raise_for_status()
    database_data = response.json()

    # Find the database id for the given dbIdentifier
    database_id = None
    for database in database_data['results']:
        if database['dbIdentifier'] == db_identifier:
            database_id = database['id']
            break

    if database_id is not None:
        recommendations_url = f'{base_url}/databases/{database_id}/recommendations'

        # Make a call to retrieve knob recommendations
        params = {'status': 'created', 'type': 'knob'}
        response = requests.get(recommendations_url, headers=headers, params=params)
        response.raise_for_status()
        recommendations_data = response.json()

        # Extract knob recommendations and store in a list of tuples
        knob_recommendations = {}
        for recommendation in recommendations_data['results']:
            knob_name = recommendation['knobName']
            knob_final_value = recommendation['knobFinalValue']
            knob_recommendations[knob_name] = knob_final_value

        if len(knob_recommendations) > 0:
            with open(terraform_file_path, 'r') as file:
                terraform_config = file.read()

            config_lines = terraform_config.splitlines()
            new_config_lines = []

            # Iterate over the lines and update parameter values if needed
            i = 0
            while i < len(config_lines):
                line = config_lines[i]

                # Check if the line contains the parameter definition
                if line.strip().startswith("parameter {"):
                    # Extract the parameter name and value
                    param_name = None
                    param_value = None
                    while not line.strip().startswith("}"):
                        if line.strip().startswith("name"):
                            param_name = line.split("=")[1].strip('" ')
                        elif line.strip().startswith("value"):
                            param_value = line.split("=")[1].strip('" ')
                        assert param_name is not None
                        line = config_lines[i]
                        i += 1

                    if param_name in knob_recommendations:
                        # Replace the parameter value with the new value
                        param_value = knob_recommendations[param_name]
                        new_config_lines.append(
                            f'  parameter {{\n    name  = "{param_name}"\n    value = "{param_value}"\n  }}')
                    else:
                        # Keep the original parameter value
                        new_config_lines.append(
                            f'  parameter {{\n    name  = "{param_name}"\n    value = "{param_value}"\n  }}')
                else:
                    # Add non-parameter lines as is
                    new_config_lines.append(line)
                    i += 1

            # Join the modified configuration lines
            modified_terraform_config = "\n".join(new_config_lines)

            # Write the modified Terraform configuration back to the file
            with open(terraform_file_path, 'w') as file:
                file.write(modified_terraform_config)

            print("Terraform configuration file (main.tf) has been updated with knob recommendations.")
        else:
            print("No knob recommendations found for this database.")
    else:
        print(f'Database with dbIdentifier "{db_identifier}" not found.')

except requests.exceptions.RequestException as e:
    print(f'Error making HTTP request: {e}')
except Exception as e:
    print(f'An error occurred: {e}')
