def call(String deploymentFile) {
    sh '''
    export KUBECONFIG=~/.kube/config
    # Check if the file exists
            ls -l ${DEPLOYMENT_FILE}
            
            # Apply the deployment file
            echo "Applying Kubernetes deployment file: ${DEPLOYMENT_FILE}"
    kubectl apply -f ${deploymentFile}
    '''
}

