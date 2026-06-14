# My own microservice project

This is a repository for a learning project within the "DevOps CI/CD" course.

## Project structure

```
my-microservice-project/
└── docker/
    ├── django/
    │   ├── Dockerfile          # Python 3.10 image for the Django app
    │   ├── requirements.txt    # Django==4.2, psycopg2-binary==2.9.7
    │   ├── manage.py
    │   └── my_project/         # Django project package
    ├── nginx/
    │   └── nginx.conf          # reverse proxy -> http://django:8000
    ├── docker-compose.yml      # services: django + db (postgres) + nginx
    └── .env                    # POSTGRES_* environment variables
```

## Services

- **django** — the Django web application, running `manage.py runserver` on port
  8000, built from `docker/django/Dockerfile`.
- **db** — PostgreSQL 14 for storing data (credentials come from `.env`).
- **nginx** — reverse proxy listening on port 80 and forwarding requests to the
  `django` container (`proxy_pass http://django:8000`).

## How to run

All compose commands are run from the `docker/` directory:

```bash
cd docker
docker-compose up -d --build
```

Then open **http://localhost** — you should see the Django welcome page served
through Nginx (the Django container is also reachable directly at
http://localhost:8000).

> **First run note:** on a fresh database, PostgreSQL needs a few seconds to
> initialize. If Django starts before the database is ready you may briefly get a
> **502** from Nginx. In that case just restart the Django container once:
>
> ```bash
> docker-compose restart django
> ```

Apply the database migrations (creates the Django tables in PostgreSQL):

```bash
docker-compose exec django python manage.py migrate
```

To stop the stack (add `-v` to also remove the database volume):

```bash
docker-compose down        # stop
docker-compose down -v     # stop + wipe the database volume
```

## Homework: "Docker" 🐳

Welcome to the homework for the "Docker" topic! 🎉

Now that you are familiar with the basics of containerization and have created a
multi-service project, it's time to reinforce your knowledge in practice. This
assignment will help you practice working with Docker and Docker Compose, as well
as structure your Django project with a PostgreSQL database and an Nginx web
server.

This assignment will help you not only consolidate your Docker knowledge but also
prepare for building complex infrastructures in future topics. Good luck! 🚀

### Task description

1. Create your own project that includes:
   - **Django** — for the web application.
   - **PostgreSQL** — for storing data.
   - **Nginx** — for handling requests.
2. Use **Docker** and **Docker Compose** to containerize all services.
3. Push the project to your GitHub repository for review.

### Steps to complete the task

#### 1. Create the Django project structure in Docker

- Initialize a new Django project (the project name is up to you).
- Configure PostgreSQL as the database.
- Add Nginx for proxying traffic.

#### 2. Create a Dockerfile for Django

Your Dockerfile must:

- Use a Python 3.9 image or newer.
- Install all required dependencies from `requirements.txt`.
- Run the Django server inside the container.

#### 3. Create docker-compose.yml

In `docker-compose.yml`, describe all three services:

- **web** — the Django application.
- **db** — PostgreSQL for storing data.
- **nginx** — the web server for handling requests.

Configure Nginx. Create an `nginx.conf` file in the `nginx` folder with the
following content:

```nginx
server {
    listen 80;

    location / {
        proxy_pass http://django:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

#### 4. Test the project locally

Start the project with the command:

```bash
docker-compose up -d
```

Make sure that:

- The web application is available at http://localhost.
- The connection to the PostgreSQL database works.

#### 5. Push the project to GitHub

- Create a new branch `lesson-4` in your repository.
- Upload all the files of your project to the repository.
- Use the following commands to push the changes:

```bash
git checkout -b lesson-4
git add .
git commit -m "Add Dockerized Django project with PostgreSQL and Nginx"
git push origin lesson-4
```

### Acceptance criteria

📌 The acceptance criteria are a mandatory condition for the mentor to review the
assignment. If any of the criteria are not met, the mentor will return the
homework for revision without grading.

1. A Django + PostgreSQL + Nginx project is created in Docker.
2. All services are described in `docker-compose.yml`.
3. The Dockerfile for Django is configured according to the requirements above.
4. Nginx works as a web server for proxying requests.
5. The project starts successfully locally with `docker-compose up`.
6. The project code is uploaded to the GitHub repository in the `lesson-4` branch.

### Submission and upload

1. Complete the task and push it to your previously created repository, into the
   `lesson-4` branch.
2. Download the working files to your computer and attach them in the LMS as a zip
   archive. The archive name must follow the format `ДЗ4_ПІБ`.
3. Attach a link to the `lesson-4` branch of your repository and submit it for
   review.

### Submission format

- A link to your GitHub repository with the `lesson-4` branch.
- The repository files attached as a zip archive named `ДЗ4_ПІБ`.

The project must include:

- `Dockerfile`
- `docker-compose.yml`
- The `nginx.conf` configuration file
- Django code with PostgreSQL database settings

### Grading format

Pass / Fail
