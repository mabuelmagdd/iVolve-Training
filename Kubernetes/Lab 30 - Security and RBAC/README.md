#   Security and RBAC

## **Objective**

### Create a Service Account. Define a Role named pod-reader allowing read-only access to pods in the namespace. Bind the pod-reader Role to the Service Account and get ServiceAccount token. Make a Comparison between service account - role & role binding - and cluster role & cluster role binding
### Comparison Between Concepts

| **Concept**           | **ServiceAccount**                       | **Role**                                    | **RoleBinding**                             | **ClusterRole**                             | **ClusterRoleBinding**                       |
|------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|---------------------------------------------|----------------------------------------------|
| **Scope**             | Associated with a namespace              | Restricted to a namespace                   | Restricted to a namespace                   | Cluster-wide                                | Cluster-wide                                 |
| **Purpose**           | Provides identity for Pods to access the API server | Defines permissions within a namespace      | Binds a Role to a user, group, or SA        | Defines cluster-wide permissions            | Binds a ClusterRole to a user, group, or SA  |
| **Namespace-Specific** | Yes                                      | Yes                                         | Yes                                         | No                                          | No                                           |
| **Typical Usage**     | For Pods to authenticate to the API server | Grant specific permissions to a namespace   | Assign Roles to identities                  | Grant broad permissions, e.g., managing nodes | Assign ClusterRoles to identities            |

---
## **Steps:**

#### 1. Create a Service Account
`sa.yaml` file 
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: pod-reader-sa
  namespace: default
```
**OR**
```
kubectl create serviceaccount sa
```
#### 2. Define a Role `pod-reader`
This role will allow read-only access to Pods in the default namespace.
```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
```
**OR**
skip this step
#### 3. Bind the `pod-reader` Role to the Service Account
Create a RoleBinding to bind the Role to the ServiceAccount.
```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: pod-reader-sa
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
**OR**
```
kubectl create clusterrolebinding sa-admin --clusterrole=admin --serviceaccount=default:sa
```

#### 4. Apply the YAML files
if the files were created 
```
kubectl create -f sa.yaml
kubectl create -f pod-reader.yaml
kubectl create -f role-binding.yaml
```
#### 5. Get the ServiceAccount Token
```
kubectl create secret generic sa-token --from-literal=token=$(kubectl create token sa) --namespace=default

kubectl get secret sa-token -o jsonpath='{.data.token}' | base64 --decode
```
