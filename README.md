![](https://img.shields.io/badge/license-MIT-green)

# sv-embed-json
Yet another lib for enbedding JSON in SystemVerilog. What's different is that this lib is extensible and the parser is generated from sv bnfc.

## Introduction

A string or a file with json formatted data can be read into a systemverilog class (Val_) representing the json value.

## Reference

1. [JSON Schema](https://www.json.org/json-en.html)

## Requirements
1. fusesoc
1. eda simulator -- only questa is tested right now.

## Development

1. Clone the repository: `git clone https://github.com/mpatil/sv-embed-json.git && cd sv-embed-json`
4. Setup simulator env. Only mentor questa supported right now.
5. Run the default generation: `make`
