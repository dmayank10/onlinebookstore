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

                script {
                    def moduleDirs = findFiles(glob: '**/pom.xml')
                    
                    // Create an array to hold the parallel build steps
                    def buildSteps = [:]
                    
                    // Loop through each module and add a build step for it
                    moduleDirs.each { moduleDir ->
                        def moduleName = moduleDir.path.substring(0, moduleDir.path.indexOf('/pom.xml'))
                        buildSteps[moduleName] = {
                            dir(moduleName) {
                                // Build the module using 'mvn clean install'
                                sh "mvn clean install"
                            }
                        }
                    }
                    
                    // Run the build steps in parallel
                    parallel buildSteps
                }
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
