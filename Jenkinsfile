#!/usr/bin/env groovy

node('master') {
  try {
      stage('Commit') {
        // Checkout SCM
        checkout scm

        withEnv(['PATH=/sbin:/usr/sbin:/bin:/usr/bin:/var/lib/jenkins/bin:/usr/local/bin']) {
          // Configure Workspace
          sh 'which bundle || gem install bundler'
          sh 'bundle install'
          // sh 'bundle info cfn-nag | grep Path | cut -f2 -d" " > cfn-nag.path'

          // Build
          sh 'rake commit:build'

          // // Configure CFN_Nag
          // sh 'rake commit:cfn_nag:rules'

          // Static Analysis
          sh 'rake commit:static_analysis'

          // Security / Static Analysis
          sh 'rake commit:security_test'

          // Unit Tests for CFN_NAG custom rules
          sh 'rake commit:cfn_nag_unit_tests'
        }
      }

      stage('Acceptance') {
        def region = env.AWS_REGION == null ? 'us-east-1' : env.AWS_REGION
        withEnv(['PATH=/sbin:/usr/sbin:/bin:/usr/bin:/var/lib/jenkins/bin:/usr/local/bin']) {
          // Create Acceptance Environment
          sh 'rake acceptance:create_environment'

          // Infrastructure Tests
          sh 'rake acceptance:infrastructure_test'

          // Integration Tests
          sh 'rake acceptance:integration_test'

          // Security / Integration Tests
          sh 'rake acceptance:security_test'
        }
      }

      stage('Capacity') {
        withEnv(['PATH=/sbin:/usr/sbin:/bin:/usr/bin:/var/lib/jenkins/bin:/usr/local/bin']) {
          // Security / Penetration Tests
          sh 'rake capacity:security_test'

          // Capacity Test
          sh 'rake capacity:capacity_test'
        }
      }

      stage('Deployment') {
        withEnv(['PATH=/sbin:/usr/sbin:/bin:/usr/bin:/var/lib/jenkins/bin:/usr/local/bin']) {
          // Deployment
          sh 'rake deployment:production'

          // Deployment Verification
          sh 'rake deployment:smoke_test'
        }
      }

  }

  catch(err) {
    handleException(err)
  }
}


// Exception helper
def handleException(Exception err) {
  println(err.toString());
  println(err.getMessage());
  println(err.getStackTrace());

  throw err
}
