# Jenkins on the builder

Jenkins LTS in Docker with the docker CLI and the host docker socket, so pipelines can run `docker build/run/push`.
`/var/jenkins_home` is mounted on the same path on the host, so `docker run -v $WORKSPACE:/src` works from inside Jenkins.

```bash
cd ~/oneapp/aws/jenkins
./start-jenkins.sh
```
Open `http://<builder-public-ip>:8080`, paste the initial admin password, install suggested plugins, create the admin user.
