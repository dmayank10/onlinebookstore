pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the Git repository
                git branch: 'master', credentialsId: 'djkp', url: 'https://github.com/dmayank10/onlinebookstore.git'
            }
        }
        
        stage('Build All Modules') {
             steps {
                withMaven(globalMavenSettingsConfig: '', jdk: '', maven: 'maven', mavenSettingsConfig: '', traceability: true) {
                    echo 'code build through maven'
                    sh 'mvn clean install'
                    sh 'mvn clean package'
        
                }
        }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    // Build and tag Docker image
                    sh 'docker build -t new_proj:${BUILD_NUMBER}'
                    sh 'docker run -itd --name my_proj_container -p 8083:8083 new_proj:${BUILD_NUMBER}'
                    // Push Docker image to registry
                    
                    }
                }
            }
        
        // stage('Kubernetes Deploy') {
        //     steps {
        //         // Deploy to Kubernetes
        //         kubeConfig(
        //             credentialsId: 'kubeconfig-credentials-id',
        //             disableAutoRefresh: false,
        //             kubeconfigId: 'kubeconfig-id'
        //         )
        //         kubernetesDeploy(
        //             configs: 'path/to/kubernetes/deployment.yaml',
        //             enableConfigSubstitution: true
        //         )
        //     }
        // }
    }
}
