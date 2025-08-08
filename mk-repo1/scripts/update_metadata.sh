#!/bin/bash 
 
# IMDSv2 토큰 발급 
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" -s)
 
# 메타데이터 조회 with 토큰 
REGION_AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/placement/availability-zone) 
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/instance-id) 
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/local-ipv4)
 
# index.html 파일 생성 
cat <<EOF > /usr/share/nginx/html/index.html 
<!DOCTYPE html> 
<html> 
<head> 
    <title>Web Server2</title> 
    <style> 
        body { 
            font-family: Arial, sans-serif; 
            font-size: 50px; 
            margin: 0; 
            padding: 20px; 
        } 
        h1 { 
            font-weight: bold; 
            font-size: 50px; 
            margin: 0 0 20px 0; 
            color: blue; 
        } 
        .info { 
            font-weight: normal; 
            font-size: 40px; 
            line-height: 1.5; 
        } 
        .info br { 
            margin-bottom: 10px; 
        } 
    </style> 
</head> 
<body> 
    <h1>Web Server V2</h1> 
    <div class="info"> 
        Region/AZ: $REGION_AZ<br> 
        Instance ID: $INSTANCE_ID<br> 
        Private IP: $PRIVATE_IP<br> 
    </div> 
</body> 
</html> 
EOF