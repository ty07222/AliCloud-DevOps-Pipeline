pipeline {
    agent any

    environment {
        HARBOR_HOST = '47.85.199.199:80'
        HARBOR_PROJECT = 'library'
        IMAGE_NAME = "${HARBOR_HOST}/${HARBOR_PROJECT}/spring-petclinic"
    }

    stages {
        stage('Build JAR') {
            steps {
                dir('spring-petclinic') {
                    sh './mvnw --version'
                    sh './mvnw clean package -DskipTests'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                dir('spring-petclinic') {
                    script {
                        def tag = "build-${BUILD_NUMBER}"
                        withCredentials([usernamePassword(
                            credentialsId: 'harbor-creds',  
                            usernameVariable: 'HARBOR_USER',
                            passwordVariable: 'HARBOR_PASS'
                        )]) {
                            sh """
                                docker build -t ${IMAGE_NAME}:${tag} .
                                echo "\$HARBOR_PASS" | docker login ${HARBOR_HOST} -u "\$HARBOR_USER" --password-stdin
                                docker push ${IMAGE_NAME}:${tag}
                                docker logout ${HARBOR_HOST}
                                echo "✅ 镜像已推送到: ${IMAGE_NAME}:${tag}"
                            """
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo '🎉 CI/CD 流水线成功完成！'
        }
        failure {
            echo '❌ 构建失败，请检查日志。'
        }
    }
}
