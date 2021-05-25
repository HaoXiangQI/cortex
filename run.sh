docker build . -f images/python-predictor-cpu/Dockerfile -t predictor-cpu --build-arg "HTTP_PROXY=http://192.168.4.99:7890" --build-arg "HTTPS_PROXY=http://192.168.4.99:7890"
