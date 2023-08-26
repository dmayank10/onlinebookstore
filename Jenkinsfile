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
                withMaven(globalMavenSettingsConfig: '', jdk: '', maven: 'Maven', mavenSettingsConfig: '', traceability: true) {
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
                    def imageName = "my_proj:${env.BUILD_ID}"
                    docker.build(imageName, '.')

                    // Push Docker image to registry
                    docker.withRegistry(credentialsId: 'djkp', url: 'https://hub.docker.com/') {
                        docker.image(imageName).push()
                    }
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
