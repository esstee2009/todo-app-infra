custom_data = base64encode(<<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl restart nginx
echo "<h1>Nginx Running on $(hostname)</h1>" > /var/www/html/index.html
EOF
)