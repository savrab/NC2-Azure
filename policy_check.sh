######################
## Author: Saurabh Shinde ##


# Prompt user to enter subscription name
read -p "Enter subscription name: " subscription_name

# Get subscription ID using subscription name

subscription_id=$(az account list --query "[?name=='$subscription_name'].id" -o tsv)

# Check if subscription_id is empty
if [ -z "$subscription_id" ]; then
    echo "Subscription '$subscription_name' not found."
    exit 1
fi

# Set the current subscription context
az account set --subscription $subscription_id

# Get custom policies with "policyType": "Custom" and "category": "Network" and print displayName and description
az policy definition list --query "[?policyType=='Custom' && metadata.category=='Network'].{Name: displayName, Description: description}"