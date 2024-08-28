import ssl
from cryptography import x509
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import padding


def load_certificate(file_path):
    """Load a certificate from a file."""
    with open(file_path, "rb") as file:
        cert_data = file.read()
        return x509.load_pem_x509_certificate(cert_data, default_backend())


def verify_certificate(cert, root_cert):
    """Verify that a certificate was signed by the provided root certificate."""
    # Get the public key from the root certificate
    root_public_key = root_cert.public_key()
    try:
        # Verify the certificate signature
        root_public_key.verify(
            cert.signature,                       # The signature to verify
            cert.tbs_certificate_bytes,           # The data to verify against (tbs = "to be signed")
            padding.PKCS1v15(),                   # Padding method used in the signature
            cert.signature_hash_algorithm,        # The hash algorithm used in the signature
        )
        print("Certificate is valid and was signed by the provided root certificate.")
    except Exception as e:
        print(f"Certificate verification failed: {e}")


def main():
    # Paths to the certificate files
    cert_path = "./client.crt"  # Replace with the path to the certificate to verify
    root_cert_path = "./root.crt"  # Replace with the path to the root certificate
    # Load the certificates
    cert = load_certificate(cert_path)
    root_cert = load_certificate(root_cert_path)
    # Verify the certificate
    verify_certificate(cert, root_cert)


main()
