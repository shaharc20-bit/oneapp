# Flask AWS Monitor

Flask app that lists EC2 instances, VPCs, Load Balancers and AMIs in `us-east-1`.

- `app.py` - application (as provided)
- `requirements.txt` - flask, boto3
- `Dockerfile` - multi-stage build, non-root user, port 5001

## Run on the builder
```bash
git clone https://github.com/shaharc20-bit/oneapp.git
cd oneapp/aws/app
docker build -t flask-aws-monitor .
docker run -d --name flask-aws-monitor -p 5001:5001 flask-aws-monitor
```
Open `http://<builder-public-ip>:5001/`

## Known issue
`/` returns `NameError: name 'vpcs' is not defined` - fixed in Section 4.
