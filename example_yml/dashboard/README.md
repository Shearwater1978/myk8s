1. Install dashboard:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
2. Create ClusterRoleBinding
kubectl apply -f dashboard-rb.yaml
3. Obtain token
 - kubectl -n kube-system get secret
 - search secret with similar name deployment-controller-token-4xf2k
 - get token kubectl -n kube-system describe secret deployment-controller-token-4xf2k
