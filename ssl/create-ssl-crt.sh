#Generate a Certificate Authority Certificate
openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -sha512 -days 3650 \
-subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=kind-registry" \
-key ca.key \
-out ca.crt

#Generate a Server Certificate
openssl genrsa -out kind-registry.key 4096

openssl req -sha512 -new \
-subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=kind-registry" \
-key kind-registry.key \
-out kind-registry.csr
cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1=kind-registry
DNS.2=www.kind-registry
DNS.3=*.kind-registry
EOF

openssl x509 -req -sha512 -days 3650 \
-extfile v3.ext \
-CA ca.crt -CAkey ca.key -CAcreateserial \
-in kind-registry.csr \
-out kind-registry.crt

openssl x509 -inform PEM -in kind-registry.crt -out kind-registry.cert

# nginx配置（根据需要执行）
mkdir -p /etc/docker/certs.d/nginx/certs/kind-registry:5000/
cp kind-registry.cert /etc/docker/certs.d/kind-registry:5000/
cp kind-registry.key /etc/docker/certs.d/kind-registry:5000/
cp kind-registry.crt /etc/docker/certs.d/kind-registry:5000/