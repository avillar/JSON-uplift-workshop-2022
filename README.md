# OGC tools to support using standardised data models with OGC-API Features

Developer Workshop at the 124th OGC Member Meeting

## Introduction

This repository contains an example to transform and add semantic
information to standard JSON files to convert them into
[JSON-LD](https://www.w3.org/TR/json-ld11/) and [Turtle](https://www.w3.org/TR/turtle/)
RDF documents.

### Scripts

### JSON-LD uplifting

The `scripts/ingest_json.py` script is responsible for transforming JSON
files into RDF (JSON-LD and Turtle) documents. It can be run in batch mode
(generating output files automatically) or in single-document mode (which 
writes output to specific files or the standard output).

`ingest_json.py` works with "context definition files", which are YAML documents
defining a set of transformations to be done on the input data and
JSON-LD context blocks to be inserted in the resulting transformed documents.

Please see [this presentation](https://avillar.github.io/presentations/20220913-json/)
for more information on creating context definitions.

Examples:

  - `ogcapi-ld/birds1.json` is a JSON file obtained from an OGC API-compatible service.
  - `ogcapi-ld/_json-context.yml` is the YAML context definition that will
    be used for that file.

### SHACL entailment and validation

`scripts/update_vocabs.py` uses a series of rules stored inside SHACL files
to perform entailment (i.e. generating new RDF from existing data) and
validation tasks. 

`update_vocabs.py` generates both an entailed version of the input documents
and a `.txt` validation report with the results of the validation process.

Examples:

  - `scripts/ogcapi-ld.entailment.shapes.ttl` contains some entailment rules
    for the aforementioned JSON file.
  - `scripts/ogcapi-ld.validation.shapes.ttl` defines validation rules for 
    the resulting RDF.

## How to run

The scripts in this repository can be run in two ways:

  - Using a Python (>= 3.7) virtual environment (Linux and Mac only).
  - Using Docker (Windows, Linux, Mac).

All examples are to be run from the root directory of the
repository (where this README.md file is located).

### Python virtual environment (Linux and Mac only)

```shell
# 1. Create virtual env inside venv directory and activate it
python -m venv venv
. ./venv/bin/activate
# 2. Install dependencies
pip install -r scripts/requirements.txt
# 3. Run the scripts
# 3.1 JSON-LD uplifting
python scripts/ingest_json.py --batch -t -j \
 ogcapi-ld/birds1.json,ogcapi-ld/birds2-invalid.json,ogcapi-ld/birds3-invalid.json
# 3.2 SHACL entailment and validation
python scripts/update_vocabs.py -a \
 ogcapi-ld/birds1.ttl,ogcapi-ld/birds2-invalid.ttl,ogcapi-ld/birds3-invalid.ttl
```

### Docker (Windows, Linux, Mac)

[Docker](https://docs.docker.com/get-started/overview/) provides the ability to package and run applications in loosely
isolated environments called containers. Docker needs to be [installed](https://docs.docker.com/engine/install/) before
proceeding with the following steps.

#### Optional: build the image

If an image cannot be found for your OS / architecture, you may need to build it first:

```shell
docker build -t avillarogc/jsonuplift:latest
```

#### Windows command line (cmd)

```cmd
# JSON-LD uplifting
docker run --rm -v "%cd%":/repo -w /repo avillarogc/jsonuplift python scripts/ingest_json.py --batch -t -j ^
 ogcapi-ld/birds1.json,ogcapi-ld/birds2-invalid.json,ogcapi-ld/birds3-invalid.json
# SHACL entailment and validation
docker run --rm -v "%cd%":/repo -w /repo avillarogc/jsonuplift python scripts/update_vocabs.py -a ^
 ogcapi-ld/birds1.ttl,ogcapi-ld/birds2-invalid.ttl,ogcapi-ld/birds3-invalid.ttl
```

#### Windows MINGW (e.g. Git Bash)

```shell
# JSON-LD uplifting
docker run --rm -v /"$(pwd)"://repo -w //repo avillarogc/jsonuplift python scripts/ingest_json.py --batch -t -j \
 ogcapi-ld/birds1.json,ogcapi-ld/birds2-invalid.json,ogcapi-ld/birds3-invalid.json
# SHACL entailment and validation
docker run --rm -v /"$(pwd)"://repo -w //repo avillarogc/jsonuplift python scripts/update_vocabs.py -a \
 ogcapi-ld/birds1.ttl,ogcapi-ld/birds2-invalid.ttl,ogcapi-ld/birds3-invalid.ttl
```

#### Linux and Mac

```shell
# JSON-LD uplifting
docker run --rm -u "$(id -u)" -it -v $(pwd):/repo -w /repo avillarogc/jsonuplift python scripts/ingest_json.py --batch -t -j \
 ogcapi-ld/birds1.json,ogcapi-ld/birds2-invalid.json,ogcapi-ld/birds3-invalid.json
# SHACL entailment and validation
docker run --rm -u "$(id -u)" -it -v $(pwd):/repo -w /repo avillarogc/jsonuplift python scripts/update_vocabs.py -a \
 ogcapi-ld/birds1.ttl,ogcapi-ld/birds2-invalid.ttl,ogcapi-ld/birds3-invalid.ttl
```

## More information

  - [JSON-LD official website](https://json-ld.org/)
    - [JSON-LD playground](https://json-ld.org/playground/)
    - [JSON-LD specification](https://www.w3.org/TR/json-ld11/)
  - [SHACL specification](https://www.w3.org/TR/shacl/)
    - [SHACL playground](https://shacl.org/playground/)