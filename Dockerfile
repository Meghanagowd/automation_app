# Use a colon instead of a space for the tag
FROM python:3.11-slim 

# Set the working directory
WORKDIR /app

# COPY requires two arguments: [source] [destination]
COPY requirements.txt .

# Fixed the pip install syntax
RUN pip install --no-cache-dir -r requirements.txt

# Copy your python script into the container
COPY app.py .

# Document the port
EXPOSE 5000

# Ensure the filename matches (app.py)
CMD ["python", "app.py"]
