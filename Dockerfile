FROM python:3.10-slim

WORKDIR /app

COPY . .
RUN pip install --no-cache-dir -r scripts/requirements.txt

CMD ["python"]