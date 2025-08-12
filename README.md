# EKS Demo Application

A complete demo application showcasing CI/CD pipeline deployment to Amazon EKS cluster using GitHub Actions, Docker, and Kubernetes.

## Architecture Overview

This project demonstrates a production-ready CI/CD pipeline that:

1. **Builds** a Python Flask application
2. **Tests** the application with pytest
3. **Containerizes** the app using Docker
4. **Pushes** the image to Amazon ECR
5. **Deploys** to Amazon EKS cluster
6. **Scales** automatically with HPA

## Technology Stack

- **Backend**: Python Flask 2.3.3
- **Container**: Docker with multi-stage builds
- **Registry**: Amazon ECR
- **Orchestration**: Kubernetes (EKS)
- **CI/CD**: GitHub Actions
- **Infrastructure**: AWS EKS
- **Load Balancer**: AWS ALB Ingress Controller (HTTP only)
- **Auto-scaling**: Kubernetes HPA

##  Project Structure

```
eks-application-poc/
├── .github/
│   └── workflows/
│       └── deploy-to-eks.yml    # Main CI/CD pipeline
├── k8s/                         # Kubernetes manifests
│   ├── deployment.yaml          # Application deployment
│   ├── service.yaml             # Load balancer service
│   ├── ingress.yaml             # ALB ingress
│   ├── hpa.yaml                 # Horizontal pod autoscaler
│   └── namespace.yaml           # Application namespace
├── templates/
│   └── index.html               # Web interface
├── app.py                       # Flask application
├── requirements.txt             # Python dependencies
├── Dockerfile                   # Multi-stage Docker build
├── test_app.py                  # Application tests
└── README.md                    # This file
```

##  Quick Start

### Prerequisites

- AWS CLI configured with appropriate permissions
- EKS cluster running
- ECR repository created
- GitHub repository with secrets configured

### Local Development

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd eks-application-poc
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the application locally**
   ```bash
   python app.py
   ```

4. **Run tests**
   ```bash
   pip install pytest
   pytest test_app.py
   ```

5. **Build Docker image locally**
   ```bash
   docker build -t eks-demo-app .
   docker run -p 5000:5000 eks-demo-app
   ```

##  Configuration

### GitHub Secrets Required

Configure these secrets in your GitHub repository:

- `AWS_ACCESS_KEY_ID`: AWS access key with ECR and EKS permissions
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key

### Environment Variables

The application uses these environment variables:

- `APP_VERSION`: Application version (default: 1.0.0)
- `ENVIRONMENT`: Environment name (default: development)
- `PORT`: Port to run on (default: 5000)

##  Deployment Pipeline

### Automatic Deployment

The application automatically deploys on:

- Push to `main` branch → Production deployment
- Push to `develop` branch → Staging deployment
- Pull requests → Test and build only

### Manual Deployment

You can manually trigger deployments from the GitHub Actions tab with environment selection.

### Pipeline Stages

1. **Test**: Run pytest with coverage
2. **Build**: Build and push Docker image to ECR
3. **Deploy**: Deploy to EKS cluster
4. **Verify**: Check deployment status
5. **Notify**: Report deployment results

##  Docker Configuration

The Dockerfile includes:

- Multi-stage build for optimization
- Security best practices (non-root user)
- Health checks
- Gunicorn for production serving
- Layer caching for faster builds

##  Kubernetes Configuration

### Resources

- **Deployment**: 3 replicas with rolling updates
- **Service**: LoadBalancer type for external access
- **Ingress**: ALB ingress controller with SSL
- **HPA**: Auto-scaling based on CPU and memory
- **Namespace**: Dedicated namespace for organization

### Health Checks

- **Liveness Probe**: `/health` endpoint
- **Readiness Probe**: `/health` endpoint
- **Resource Limits**: CPU and memory constraints

##  Monitoring and Scaling

### Auto-scaling

- **Min Replicas**: 2
- **Max Replicas**: 10
- **CPU Threshold**: 70%
- **Memory Threshold**: 80%

### Health Monitoring

- Application health endpoint: `/health`
- Kubernetes health checks
- ALB health checks

##  Troubleshooting

### Common Issues

1. **Image pull errors**: Check ECR permissions and image tags
2. **Pod startup failures**: Check resource limits and health checks
3. **Service not accessible**: Verify ingress and ALB configuration
4. **Scaling issues**: Check HPA configuration and metrics

### Debug Commands

```bash
# Check pod status
kubectl get pods -n default

# Check service status
kubectl get svc -n default

# Check ingress status
kubectl get ingress -n default

# View pod logs
kubectl logs -f deployment/eks-demo-app -n default

# Check events
kubectl get events -n default --sort-by='.lastTimestamp'
```

##  Security Features

- Non-root user in Docker container
- Resource limits and requests
- Health check endpoints
- Secure image pulling
- Namespace isolation

##  Performance Features

- Multi-replica deployment
- Load balancer distribution
- Auto-scaling capabilities
- Layer caching in Docker builds
- Gunicorn with multiple workers

##  Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

##  License

This project is licensed under the MIT License - see the LICENSE file for details.

##  Support

For issues and questions:

1. Check the troubleshooting section
2. Review GitHub Actions logs
3. Check Kubernetes events and logs
4. Open an issue in the repository
