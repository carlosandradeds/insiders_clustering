# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')

source insiders/bin/activate

papermill /home/ubuntu/insiders_clustering/src/models/c10.0.cmaq-Deploy.ipynb /home/ubuntu/insiders_clustering/reports/output-deploy-$data.ipynb