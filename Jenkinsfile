// Jenkinsfile
String credentialsId = 'azurecred'

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  // Run terraform init
  stage('init') {
   node {
    withCredentials([azureServicePrincipal(credentialsId: 'azurecred',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) 
        {
          ansiColor('xterm') {
           sh 'terraform init'
          }
        }
    }
  }


  // Run terraform plan
  stage('plan') {
    node {
    withCredentials([azureServicePrincipal(credentialsId: 'azurecred',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) 
        {
           sh """export ARM_CLIENT_ID=$CLIENT_ID
export ARM_CLIENT_SECRET=$CLIENT_SECRET
export ARM_SUBSCRIPTION_ID=$SUBS_ID
export ARM_TENANT_ID=$TENANT_ID
                   terraform plan"""
          }
    }
  }

  if (env.BRANCH_NAME == 'master') {

    // Run terraform apply
    stage('apply') {
      node {
       withCredentials([azureServicePrincipal(credentialsId: 'azurecred',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')])  { 
         ansiColor('xterm') {
                     script {
                     input "Do you want apply the modifications to the existing infra?"
                      sh """export ARM_CLIENT_ID=$CLIENT_ID
export ARM_CLIENT_SECRET=$CLIENT_SECRET
export ARM_SUBSCRIPTION_ID=$SUBS_ID
export ARM_TENANT_ID=$TENANT_ID
                   terraform apply -auto-approve"""
         }
         }
        }
      }
    }

    // Run terraform show
    stage('show') {
      node {
         withCredentials([azureServicePrincipal(credentialsId: 'azurecred',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')])  { 
           ansiColor('xterm') {
                    sh 'terraform show'
           }}
      }
    }
  }
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}
