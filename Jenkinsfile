pipeline {
    agent any

    environment {
        HARBOR_HOST = '8.221.96.197:80'
        HARBOR_PROJECT = 'library'
        IMAGE_NAME = "${HARBOR_HOST}/${HARBOR_PROJECT}/spring-petclinic"
        APP_NAME = 'spring-petclinic'
        NAMESPACE = 'petclinic'
        IMAGE_TAG = "build-${BUILD_NUMBER}"
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
                    withCredentials([usernamePassword(
                        credentialsId: 'harbor-creds',
                        usernameVariable: 'HARBOR_USER',
                        passwordVariable: 'HARBOR_PASS'
                    )]) {
                        sh """
                            docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                            echo "\$HARBOR_PASS" | docker login ${HARBOR_HOST} -u "\$HARBOR_USER" --password-stdin
                            docker push ${IMAGE_NAME}:${IMAGE_TAG}
                            docker logout ${HARBOR_HOST}
                            echo "镜像已推送到: ${IMAGE_NAME}:${IMAGE_TAG}"
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-prod', variable: 'KUBECONFIG')]) {
                    sh '''
                        # 使用 envsubst 注入环境变量并部署
                        envsubst < k8s/namespace.yaml | kubectl apply -f -
                        envsubst < k8s/deployment.yaml | kubectl apply -f -
                        envsubst < k8s/service.yaml | kubectl apply -f -

                        echo "应用已部署"
                        echo "Prometheus将通过ServiceMonitor自动发现指标。"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'CI/CD 流水线成功完成！'
        }
        failure {
            echo '构建失败，请检查日志。'
        }
    }
}
