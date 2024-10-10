# A python script to launch aap jobs.
# It simulates an external automation tool that inputs extra variables

import requests,json,os

aap_url  = os.getenv('CONTROLLER_HOST')
api_token = os.getenv('CONTROLLER_TOKEN')  # Generate this under the user in GUI
job_template_name='00_appc-network-fortios-config-backup'

# Ansible Automation Platform (AAP) details
# api_url = f"{aap_url}/api/v2/job_templates/{job_template_id}/launch/"

api_url = f"{aap_url}/api/v2/job_templates/"


# Headers for the request
headers = {
    "Authorization": f"Bearer {api_token}",
    "Content-Type": "application/json"
}

# Data payload for launching the job template (optional)
payload = {
    # Pass extra_vars or other launch options if needed
    # "extra_vars": {
    #     "var1": "value1",
    #     "var2": "value2"
    # }
}

def get_job_template_id():
    """
    Query the AAP API to get the job template ID by name.
    To be worked on when I have time for this one
    """
    try:
        # Make a GET request to fetch job templates
        response = requests.post(api_url, headers=headers, data=json.dumps(payload), verify=False)

        # Check for successful response
        if response.status_code == 200:
            templates = response.json().get('results', [])
            
            # Find the template by name
            for template in templates:
                if template['name'] == job_template_name:
                    print(f"Job Template ID for '{job_template_name}': {template['id']}")
                    return template['id']
            
            print(f"Job Template '{job_template_name}' not found.")
            return None
        else:
            print(f"Failed to query job templates. Status Code: {response.status_code}")
            print(f"Error Response: {response.text}")
            return None
        
    except Exception as e:
        print(f"Error querying job templates: {str(e)}")
        return None

def trigger_aap_job(job_template_id):
    """
    Start the job using the job template ID.
    """
    launch_url = f"{aap_url}/api/v2/job_templates/{job_template_id}/launch/"
    
    try:
        # Make the API POST request to launch the job template
        response = requests.post(launch_url, headers=headers, data=json.dumps(payload), verify=False)
        
        # Check for successful response
        if response.status_code == 201:
            print("Job template triggered successfully!")
            job_data = response.json()
            print(f"Job ID: {job_data['id']}")
            print(f"Job Status: {job_data['status']}")
        else:
            print(f"Failed to trigger job template. Status Code: {response.status_code}")
            print(f"Error Response: {response.text}")
    except Exception as e:
        print(f"Error triggering job template: {str(e)}")

if __name__ == "__main__":
    # Step 1: Get the job template ID by name
    # job_template_id = get_job_template_id()
    
    job_template_id = 835
    
    # Step 2: Start the job if the template ID was found
    if job_template_id:
        trigger_aap_job(job_template_id)
        
