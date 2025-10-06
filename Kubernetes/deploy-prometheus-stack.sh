#!/bin/bash

# Prometheus Stack 部署脚本

set -e  # 遇到错误立即退出

echo "开始部署 Prometheus Stack..."

# 添加 Prometheus 社区仓库
echo "添加 Prometheus Helm 仓库..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# 创建监控命名空间
echo "创建 monitoring 命名空间..."
kubectl create namespace monitoring || true

# 安装 kube-prometheus-stack
echo "安装 kube-prometheus-stack..."
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --set grafana.adminPassword='admin123' \
  --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
  --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false

echo "部署完成！"

# 显示部署状态
echo "检查部署状态..."
kubectl --namespace monitoring get pods -l "release=prometheus"

echo ""
echo "访问信息："
echo "Grafana 管理员密码: admin123"
echo "查看所有 Pod 状态: kubectl -n monitoring get pods"
echo "获取 Grafana 密码: kubectl -n monitoring get secrets prometheus-grafana -o jsonpath='{.data.admin-password}' | base64 -d ; echo"
