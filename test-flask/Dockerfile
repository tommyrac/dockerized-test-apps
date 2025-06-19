# Use the official Python image.
FROM python:3.10-slim

# Set the working directory.
WORKDIR /app

# Copy requirements.txt if it exists, otherwise just install Flask.
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt || pip install flask

# Copy your application code to the container.
COPY app.py .

# Expose port 5000 for Flask.
EXPOSE 5000

# Run the Flask app.
CMD ["opentelemetry-instrument", "python", "app.py"]
