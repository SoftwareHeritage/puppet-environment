This directory is to store the self signed certificates used to simulate the let's encrypt certificates managed centrally by certbot on the real puppet environment.

# Create a new certificate

Get the certificate name as declared on the ``defaults.yaml`` file and run the script :

```bash
./generate_certificate <certificate name>
```
