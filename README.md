# Python AWS Lambda Layers

This repository contains Dockerfiles for creating AWS Lambda layers with Python dependencies.

## Available Layers

- **psycopg2-binary**: PostgreSQL adapter for Python
- **psycopg3-binary**: PostgreSQL adapter for Python (version 3)
- **pymysql**: MySQL client library for Python
- **pyjwt**: PyJWT - JSON Web Token implementation in Python
- **python-jose**: A JOSE (JavaScript Object Signing and Encryption) implementation in Python

## Usage

### Build all layers
```bash
./build.sh
```

### Build a specific layer
```bash
./build.sh psycopg2-binary
./build.sh psycopg3-binary
./build.sh pymysql
./build.sh pyjwt
./build.sh python-jose
```

## Structure

Each layer is contained in its own directory with:
- `Dockerfile`: Defines the layer build process

The main `build.sh` script in the root directory builds all layers or a specific one.

## Output

All layer builds create `.zip` files in the `dist/` directory:
- `dist/psycopg2-binary-layer.zip`
- `dist/psycopg3-binary-layer.zip`
- `dist/pymysql-layer.zip`
- `dist/pyjwt-layer.zip`
- `dist/python-jose-layer.zip`

These `.zip` files can be uploaded directly to AWS Lambda as layers.
