# Multi Cloud DevOps Project

![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/project.jpg)


This project demonstrates a complete CI/CD pipeline setup for a Java application using Terraform, Ansible, Jenkins, SonarQube, and OpenShift. The pipeline begins with infrastructure provisioning on AWS using Terraform, followed by configuration management and application deployment using Ansible, Jenkins, SonarQube and Deploy on OpenShift Cluster.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Terraform Setup](#terraform-setup)
- [Ansible Setup](#ansible-setup)
- [Jenkins Configuration](#jenkins-configuration)
- [Running the Pipeline](#running-the-pipeline)
- [Checking Results](#checking-results)
- [Contributing](#contributing)


## Prerequisites

- AWS Account
- Terraform installed
- Ansible installed
- GitHub Account
- OpenShift Cluster
- DockerHub Account


## Terraform Setup

1. **Clone the Repository:**

    ```
    git clone <repository-url>
    cd <repository-directory>/terraform

    ```
2. **Configure Variables:**

    Edit the terraform.tfvars and variables.tf file to set values for your AWS setup.

3. **Initialize Terraform:**

    ```
    terraform init

    ```
    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/terraform-init.png)

4. **Review the Plan:**

    ```
     terraform plan

    ```
    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/terraform-plan.png)

5. **Apply the Configuration:**

    ```
    terraform apply
    ```

    Confirm the action by typing yes when prompted.

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/terraform-apply.png)

6. **AWS Resources Created:**

    - EC2 Instances

        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/ec2.png)
        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/ec2-1.png)
        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/ec2-vol.png)


    - VPC

        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/vpc.png)
        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/vpc-2.png)


    - CloudWatch with SNS topic for email notifications

        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/cloudwatch.png)
        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/alarm.png)
        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/sns.png)
        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/sns-email.png)
        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/confirm-sub-sns.png)

    - S3 Bucket for Terraform state file backend

        ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/s3.png)


## Ansible Setup

1. **Navigate to Ansible Directory:**
    ```
    cd ../Ansible

    ```
2. **Install Jenkins, SonarQube, Docker, and Openshift CLI:**

    Use Ansible roles to install the necessary services.

3. **Dynamic Inventory:**

    Use the aws_ec2 plugin for dynamic inventory.

4. **Generate Private Key:**

    Terraform will generate private_key.pem and add it to the Ansible folder.

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/keypair.png)


6. **Run Ansible Playbook:**

    ```
    ansible-playbook -i aws_ec2.yml devops.yml

    ```
    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/ansible.png)
    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/ansible-done.png)

7. **Outputs:**

- SonarQube token

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/sonarqube-token.png)

- Jenkins initial password

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-initial-pass.png)
    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-password.png)


## Jenkins Configuration

1. **Install Plugins:**
    - Suggested plugins

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-install-plugin.png)

    - SonarQube Scanner and Groovy Plugins: To Shared Library
    
    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-add-plugin.png)



2. **Create Credentials:**
    - GitHub 
    - SonarQube token
    - OpenShift token
    - DockerHub 

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/credintial.png)


3. **Configure Shared Library:**

- Add repository URL and name in Jenkins system configuration:

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/shared-lib.png)
    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/shared-lib-2.png)



4. **Create Pipeline:**

    - Create a new pipeline.

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/pipeline.png)

    - Choose SCM and add repository URL and branch name.

    ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/configure-pipeline.png)

## Running the Pipeline

1. **Run Pipeline:**
    Execute the pipeline from Jenkins.

   Make sure you have given enough storage space to the ec2 to avoid this error

   ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-build-4-space.png)

   ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-build.png)
   ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-build-2.png)
   ![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-build-3.png)


3. **Monitor Pipeline:**

    Ensure the pipeline runs successfully.

![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-build-5-done.png)
![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-build-6-stages.png)


## Checking Results

1. **SonarQube Quality Gate:**

    Review code quality reports on SonarQube.

![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/jenkins-build-5-done.png)

![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/sonarqube-website.png)

![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/sonarqube-website-2.png)


2. **Application Deployment:**

    Verify your application is running on the OpenShift cluster.

    Login In Your Cluster and Run to Get Application Route

    ```
    oc get all -n namespace

    ```

![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/oc-all.png)


Past It in Your Browser

![](https://github.com/omarshaban32/MultiCloudDevOpsProject/blob/dev/screenshots/website.png)


## Contributing

    Contributions are welcome! Please submit a pull request or open an issue for any suggestions or improvements.
