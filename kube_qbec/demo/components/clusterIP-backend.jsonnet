{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "name": "backend",
    "namespace": ""
  },
  "spec": {
    "ports": [
      {
        "name": "web",
        "port": 80
      }
    ],
    "selector": {
      "app": "backend"
    },
    "type": "ClusterIP"
  }
}
