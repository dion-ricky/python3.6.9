#! /bin/bash
cd "$(dirname "$0")"

docker build . -t python:3.6.9
