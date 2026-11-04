# CI/CD

## Jenkins (`Jenkinsfile`)
Stages:
1. Clone Repository
2. Parallel Checks
   - Lint: flake8, hadolint, shellcheck
   - Security: bandit, trivy fs (dependencies, secrets, misconfig)
   - Unit tests (pytest + moto)
3. Build Docker Image (`shaharc20/flask-aws-monitor:<build>` + `latest`)
4. Scan Image (trivy)
5. Push to Docker Hub
6. Update GitOps (optional, `UPDATE_GITOPS=true`)

All tools run in containers, so the agent only needs the docker CLI.
`MOCK_CHECKS=true` replaces lint/security/test steps with mock `echo` steps.

Fixes to the provided Jenkinsfile: `#` comment -> invalid in Groovy, nested stages were missing the `parallel {}` block, placeholder repo/image names, Docker Hub credentials changed to a single username/password credential.

### Jenkins setup
- Jenkins on the builder: see `../jenkins`
- Credentials:
  - `dockerhub-creds` - Username with password (Docker Hub user + access token)
  - `github-creds` - Username with password (GitHub user + PAT), only for `UPDATE_GITOPS`
- New Item -> Pipeline -> Pipeline script from SCM -> Git `https://github.com/shaharc20-bit/oneapp.git`, branch `*/dev`, Script Path `aws/cicd/Jenkinsfile`
- Build with Parameters: `BRANCH` (default `dev`, `main` after the release PR)

`Jenkinsfile.shared-lib` is the same pipeline using the shared library in `../shared-library`.

## Azure DevOps (`azure-pipelines.yml`) - bonus
Same flow: Checks stage (Lint, SecurityScan, UnitTests jobs in parallel) -> BuildPush stage (build, trivy, push).
- Service connection `dockerhub-connection` (Docker Registry -> Docker Hub) - credentials stored in Azure DevOps
- Variable group `dockerhub` with `DOCKERHUB_USERNAME`
- New pipeline -> GitHub -> oneapp -> Existing YAML -> `/aws/cicd/azure-pipelines.yml`
- All steps run in containers, so it works on Microsoft-hosted agents and on a self-hosted agent (`selfHostedPool=true`, pool `Default`, e.g. on the builder)
