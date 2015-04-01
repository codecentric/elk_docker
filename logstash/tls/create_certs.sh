#!/bin/sh

# create CA certificate and server TLS certificate (act as a CA authority)
# (cf. https://help.ubuntu.com/community/GnuTLS)

TLS_KEY_DIR=/etc/pki/tls/private
TLS_CRT_DIR=/etc/pki/tls/certs

# generate private CA key (DO NOT DISTRIBUTE THIS FILE)
certtool --generate-privkey --sec-param medium --outfile $TLS_KEY_DIR/logstash-ca.key
chmod 600 $TLS_KEY_DIR/logstash-ca.key

# generate self-signed CA certificate
certtool --generate-self-signed --sec-param medium --load-privkey $TLS_KEY_DIR/logstash-ca.key --template /ca_cert.template --outfile $TLS_CRT_DIR/logstash-ca.crt


# generate private key for logstash (DO NOT DISTRIBUTE THIS FILE)
certtool --generate-privkey --sec-param medium --outfile $TLS_KEY_DIR/logstash.example.com.key
chmod 600 $TLS_KEY_DIR/logstash.example.com.key

# generate certificate signing request
certtool --generate-request --sec-param medium --load-privkey $TLS_KEY_DIR/logstash.example.com.key --template /cert.template --outfile $TLS_KEY_DIR/logstash.example.com.csr

certtool --generate-certificate --sec-param medium --load-request $TLS_KEY_DIR/logstash.example.com.csr --load-ca-certificate $TLS_CRT_DIR/logstash-ca.crt --load-ca-privkey $TLS_KEY_DIR/logstash-ca.key --template /cert.template --outfile $TLS_CRT_DIR/logstash.example.com.crt

