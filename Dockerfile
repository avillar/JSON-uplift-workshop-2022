FROM python:3.10-slim

WORKDIR /app

COPY scripts/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python"]