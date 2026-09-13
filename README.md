# Production-Style Kubernetes Application on DigitalOcean

This project demonstrates the deployment and operation of a production-style cloud-native application on **DigitalOcean Kubernetes (DOKS)** using **Terraform** and Kubernetes-native capabilities.

The project focuses not only on deploying an application, but also on addressing important operational aspects of a cloud workload, including infrastructure provisioning, networking, persistent storage, security, monitoring, database backup, disaster recovery, and workload resilience.

## Architecture
![diagram]kubernetes/project.png
## Tools and Technologies

- **Cloud Platform:** DigitalOcean
- **Infrastructure as Code:** Terraform
- **Container Orchestration:** Kubernetes / DOKS
- **Database:** PostgreSQL
- **Networking:** Kubernetes Services / Ingress
- **Network Security:** NetworkPolicy
- **Access Control:** Kubernetes RBAC
- **Storage:** Persistent Storage
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

## Conclusion

This project provided hands-on experience in designing and operating a cloud-native application beyond the initial deployment stage.

Rather than treating Kubernetes simply as a platform for running containers, I focused on how different cloud-native components work together to address real operational requirements such as **security, persistent data, observability, backup, recovery, and workload resilience**.

The validation exercises made the concepts practical: Kubernetes self-healing was tested through an intentional pod failure, PostgreSQL backups were successfully generated and verified in external object storage, and persistent storage was used to protect database data across pod replacement.

Overall, the project strengthened my understanding of how **infrastructure, networking, Kubernetes, storage, security, and reliability mechanisms interact to build a more resilient cloud environment**.
