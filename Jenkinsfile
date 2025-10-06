pipeline {
    agent any

    environment {
        HARBOR_HOST = '8.221.96.197:80'
        HARBOR_PROJECT = 'library'
        IMAGE_NAME = "${HARBOR_HOST}/${HARBOR_PROJECT}/spring-petclinic"
        APP_NAME = 'spring-petclinic'
        NAMESPACE = 'petclinic'
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

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    def tag = "build-${BUILD_NUMBER}"
                    def FULL_IMAGE = "${IMAGE_NAME}:${tag}"
                    withCredentials([file(credentialsId: 'kubeconfig-prod', variable: 'KUBECONFIG')]) {
                        sh """
                            # 创建命名空间
                            kubectl --insecure-skip-tls-verify create namespace ${NAMESPACE} --dry-run=client -o yaml | \\
                            kubectl --insecure-skip-tls-verify apply --validate=false -f -

                            # 部署应用
                            kubectl --insecure-skip-tls-verify create deployment ${APP_NAME} \\
                                --image=${FULL_IMAGE} \\
                                --port=8080 \\
                                -n ${NAMESPACE} \\
                                --dry-run=client -o yaml | \\
                            kubectl --insecure-skip-tls-verify apply --validate=false -f -

                            # 创建 Service（LoadBalancer）
                            kubectl --insecure-skip-tls-verify create service loadbalancer ${APP_NAME} \\
                                --tcp=80:8080 \\
                                -n ${NAMESPACE} \\
                                --dry-run=client -o yaml | \\
                            sed 's/port: 80/port: 8080/; s/targetPort: 8080/targetPort: 8080/; s/name:.*/name: http/' | \\
                            kubectl --insecure-skip-tls-verify apply --validate=false -f -

                            # 打标签
                            kubectl --insecure-skip-tls-verify label service ${APP_NAME} app=${APP_NAME} -n ${NAMESPACE} --overwrite

                            echo "✅ 应用已部署，Prometheus 可自动发现监控指标"
                        """
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
