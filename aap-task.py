# A python script to launch aap jobs.
# It simulates an external automation tool that inputs extra variables

import requests,json,os

aap_url  = os.getenv('CONTROLLER_HOST')
# username = os.getenv('CONTROLLER_USERNAME')
# password = os.getenv('CONTROLLER__HOST')
api_token = os.getenv('CONTROLLER_TOKEN')
job_template_id=833

# Ansible Automation Platform (AAP) details
api_url = f"{aap_url}/api/v2/job_templates/{job_template_id}/launch/"

# If using token
# API_TOKEN = "your_api_token"


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

def trigger_aap_job():
    try:
        # Make the API POST request to launch the job template
        response = requests.post(api_url, headers=headers, data=json.dumps(payload), verify=False)
        
        # response = requests.post(api_url, auth=(username, password), headers = headers, data=json.dumps(payload), verify=False)
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
    trigger_aap_job()
