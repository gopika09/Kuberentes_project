# Production-Style Kubernetes Application on DigitalOcean

This project demonstrates the deployment and operation of a production-style cloud-native application on **DigitalOcean Kubernetes (DOKS)** using **Terraform** and Kubernetes-native capabilities.

The project focuses not only on deploying an application, but also on addressing important operational aspects of a cloud workload, including infrastructure provisioning, networking, persistent storage, security, monitoring, database backup, disaster recovery, and workload resilience.

## Overview

![Architecture Diagram](architecture.png)

The overall architecture follows:

**Infrastructure → Networking → Application → Database → Storage → Security → Monitoring → Backup/DR → Resilience**

## Tools and Technologies

- **Cloud Platform:** DigitalOcean
- **Infrastructure as Code:** Terraform
- **Container Orchestration:** Kubernetes / DOKS
- **Containerization:** Docker
- **Application:** Containerized API
- **Database:** PostgreSQL
- **Networking:** Kubernetes Services / Ingress
- **Network Security:** NetworkPolicy
- **Access Control:** Kubernetes RBAC
- **Storage:** Persistent Storage
- **Monitoring:** Kubernetes/Application Monitoring
- **Backup:** PostgreSQL `pg_dump`
- **Backup Storage:** S3-Compatible Object Storage

## Features

- **Infrastructure as Code**
  - Provisioned cloud infrastructure using Terraform.
  - Provides a repeatable and declarative approach to infrastructure management.

- **Kubernetes Application Deployment**
  - Deployed a containerized API using a Kubernetes Deployment.
  - Kubernetes manages the desired state and workload replicas.

- **Application Networking**
  - Used Kubernetes Services for internal application communication.
  - Configured Ingress for external HTTP/HTTPS traffic.
  - External traffic flows through the Load Balancer and Ingress to the API workload.

- **PostgreSQL Database**
  - Deployed PostgreSQL as the application's persistent data layer.
  - Database communication is handled through Kubernetes networking.

- **Persistent Storage**
  - Configured persistent storage for PostgreSQL.
  - Database data remains available across PostgreSQL pod replacement or restart.

- **Network Security**
  - Implemented Kubernetes NetworkPolicy to restrict communication between workloads.
  - Network access is limited to the communication required by the application.

- **RBAC**
  - Implemented Kubernetes Role-Based Access Control.
  - Permissions are assigned based on required operations and resources following the principle of least privilege.

- **Monitoring**
  - Configured monitoring to provide visibility into the Kubernetes workload and application environment.
  - Monitoring helps identify workload health, resource usage, and unexpected behavior.

- **Automated Database Backup**
  - Implemented a Kubernetes CronJob for PostgreSQL backups.
  - Used `pg_dump` to create database backups.
  - Backups are stored in S3-compatible object storage outside the running Kubernetes workload.
  - Timestamped backup files allow individual backup versions to be retained.

- **Disaster Recovery**
  - Maintained an independent copy of PostgreSQL data in object storage.
  - Backups can be retrieved as a source for database recovery if the running environment becomes unavailable.

- **Kubernetes Self-Healing**
  - Tested Kubernetes workload recovery by manually terminating an API pod.
  - Kubernetes automatically detected the replica mismatch and created a replacement pod.

## Infrastructure Provisioning

The underlying cloud infrastructure was provisioned using **Terraform**.

Infrastructure as Code provides a repeatable approach to creating and managing the environment instead of relying entirely on manual cloud configuration.

The infrastructure flow is:

**Terraform → DigitalOcean VPC → DOKS Cluster → Kubernetes Workloads**

## Application Networking

The application uses Kubernetes networking to handle both internal and external traffic.

External traffic follows the path:

**Client → Load Balancer → Ingress → API Service → API Pods**

Kubernetes Services provide stable networking between workloads, while Ingress provides an entry point for external HTTP/HTTPS traffic.

## Database and Persistent Storage

PostgreSQL provides the persistent data layer for the application.

The database uses persistent storage so that application data is not dependent on the lifecycle of an individual PostgreSQL pod.

The database architecture follows:

**API Pod → PostgreSQL → Persistent Volume → Durable Database Data**

This ensures that replacing a PostgreSQL pod does not result in the loss of the stored database data.

## Security

### NetworkPolicy

Kubernetes **NetworkPolicy** was implemented to restrict network communication between workloads.

Instead of allowing unrestricted pod-to-pod communication, network access can be limited to the traffic required by the application.

### RBAC

Kubernetes **RBAC** was implemented to control access to Kubernetes resources.

RBAC allows permissions to be assigned based on the operations and resources required by a user or service account.

## Monitoring

Monitoring was configured to provide visibility into the Kubernetes workload and application environment.

Monitoring is important because a successful deployment does not necessarily mean that an application is healthy.

It provides visibility into:

- Workload health
- Resource usage
- Application behavior
- Potential resource pressure
- Unexpected workload behavior

## Automated PostgreSQL Backup

A Kubernetes **CronJob** was used to automate PostgreSQL database backups.

The backup workflow is:

**PostgreSQL → `pg_dump` → SQL Backup → S3-Compatible Object Storage**

The generated backup files use timestamped filenames, allowing multiple backup versions to be retained.

## Tests Performed

### Backup Validation

The backup workflow was manually executed to validate the implementation.

The backup Job completed successfully, and the resulting backup was verified in object storage.

This confirmed that the backup mechanism can successfully create and store PostgreSQL database backups.

### Disaster Recovery Design

The backup architecture provides an independent copy of PostgreSQL data outside the running database workload.

If the database or application environment becomes unavailable, the backup can be retrieved and used as the source for database recovery.

> **Note:** The backup workflow was successfully validated, but a complete database restore was not performed as part of this project.

### Self-Healing and Failure Testing

Kubernetes self-healing was explicitly tested by manually terminating an API pod.

Kubernetes detected that the actual state no longer matched the desired replica count and automatically created a replacement pod.

The desired replica count was restored without manually recreating the failed pod.

**Result:**

- API pod terminated: **Passed**
- Replacement pod automatically created: **Passed**
- Desired replica count restored: **Passed**
- Manual pod recreation required: **No**

## Resilience Model

The project combines multiple mechanisms to address different failure scenarios:

| Failure Scenario | Resilience Mechanism |
|---|---|
| API pod failure | Kubernetes self-healing |
| Pod replacement | Persistent storage |
| Database/data loss | PostgreSQL backup |
| Backup retention | S3-compatible object storage |
| Unauthorized workload access | NetworkPolicy / RBAC |

This demonstrates that **self-healing, persistence, and disaster recovery address different types of failures** and work together as complementary layers of resilience.

## End-to-End System Flow

The overall system follows:

**Terraform → DigitalOcean VPC → DOKS Cluster → Ingress / Load Balancer → API Service → API Pods → PostgreSQL → Persistent Storage**

Security is provided through:

**NetworkPolicy + RBAC**

Operational visibility is provided through:

**Monitoring**

Database recovery is supported through:

**PostgreSQL → `pg_dump` → S3-Compatible Object Storage**

Workload recovery is provided through:

**API Pod Failure → Kubernetes → Replacement Pod**

## Key Learning Outcomes

Through this project, I gained hands-on experience with:

### Infrastructure
- Infrastructure as Code using Terraform
- Cloud infrastructure provisioning
- Cloud networking
- Kubernetes cluster provisioning

### Kubernetes
- Deployments and Pods
- Services and Ingress
- Persistent storage
- NetworkPolicy
- RBAC
- Kubernetes self-healing

### Operations
- Monitoring
- Troubleshooting
- Failure testing
- Backup validation
- Disaster recovery design

### Reliability
- Workload recovery
- Persistent application data
- Automated database backups
- Independent backup storage
- Designing for different failure scenarios

## Conclusion

This project provided hands-on experience in designing and operating a cloud-native application beyond the initial deployment stage.

Rather than treating Kubernetes simply as a platform for running containers, I focused on how different cloud-native components work together to address real operational requirements such as **security, persistent data, observability, backup, recovery, and workload resilience**.

The validation exercises made the concepts practical: Kubernetes self-healing was tested through an intentional pod failure, PostgreSQL backups were successfully generated and verified in external object storage, and persistent storage was used to protect database data across pod replacement.

Overall, the project strengthened my understanding of how **infrastructure, networking, Kubernetes, storage, security, and reliability mechanisms interact to build a more resilient cloud environment**.
