# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')

papermill /home/ubuntu/src/models/c10.0.cmaq-Deploy.ipynb /home/ubuntu/reports/output-deploy-$data.ipynb