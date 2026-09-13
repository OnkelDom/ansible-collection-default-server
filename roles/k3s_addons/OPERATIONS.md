# Ceph CSI credentials

The generated Secrets include both `userID`/`userKey` and `adminID`/`adminKey`.
Both pairs refer to the same configured Ceph identity and grant no additional
capabilities. Controller attach/detach operations for existing volumes can
require the admin field names while node staging uses the user fields.

Retain all four fields during key rotation. Read credentials from the cluster
and reject empty values before rendering. Do not pass the entire role-defaults
file as Ansible extra variables: extra variables override credentials supplied
by the playbook. Verify detach/reattach and dynamic volume deletion, as well as
initial provisioning and I/O on every worker.

This role targets an existing supported Linux K3s deployment with working
`kubectl` access. It does not install the operating system or Kubernetes. The
Ceph changes were exercised against Debian 13 guests, Linux 7.1.8, Ceph 20.2.4
and Ceph CSI 3.17.1; other target platforms were not runtime-tested here.
