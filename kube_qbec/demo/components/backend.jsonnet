local p = import '../params.libsonnet';
local params = p.components.backend;

{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "backend"
    },
    "name": "backend",
    "namespace": ""
  },
  "spec": {
    "replicas": params.replicas,
    "selector": {
      "matchLabels": {
        "app": "multitool"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "multitool"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "praqma/network-multitool:alpine-extra",
            "imagePullPolicy": "IfNotPresent",
            "name": "network-multitool",
            "resources": {
              "limits": {
                "cpu": "200m",
                "memory": "512Mi"
              },
              "requests": {
                "cpu": "100m",
                "memory": "256Mi"
              }
            }
          }
        ]
      }
    }
  }
}
