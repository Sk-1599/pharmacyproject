# Use an official Python runtime as the base image
FROM python:3.10.6

# Set environment variables (optional)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        python3-dev \
        default-libmysqlclient-dev \
        # Add any other system dependencies here
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the Django project code into the container
COPY . /app

# Set up any necessary configurations (e.g., database, static files, etc.)
# You can customize this part based on your project's requirements

# Collect static files (if applicable)
# RUN python manage.py collectstatic --noinput

# Run migrations (if applicable)
RUN python manage.py migrate

# Expose the port that the Django app will run on (default is 8000)
EXPOSE 8000

# Define the command to run the Django app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
