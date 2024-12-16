def call(String deploymentFile) {
    sh '''
    export KUBECONFIG=~/.kube/config
    kubectl apply -f ${deploymentFile}
    '''
}

