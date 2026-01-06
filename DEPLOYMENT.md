# Deployment Guide

This guide covers various deployment options for the Notion-Style Todo List application.

## 🚀 Quick Deployments

### Option 1: Docker (Recommended)

#### Development with PostgreSQL

```bash
# Start PostgreSQL and application
docker-compose up -d

# Access at http://localhost:8000
```

#### Production with Docker

```bash
# Build and run
docker-compose up -d

# View logs
docker-compose logs -f web

# Stop
docker-compose down
```

### Option 2: Manual Deployment

#### Development (SQLite)

```bash
# Install dependencies
make install

# Run application
make dev
```

#### Production (PostgreSQL)

```bash
# Install dependencies
make install

# Set environment variables
export DATABASE_URL="postgresql://user:password@host:5432/dbname"

# Run with workers
make run
```

## ☁️ Cloud Deployment

### Railway

1. Connect your GitHub repository to Railway
2. Railway will detect it's a Python project
3. Set environment variables:
   - `DATABASE_URL` (Railway provides PostgreSQL)
4. Deploy!

### Render

1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Configure:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `uvicorn backend.main:app --host 0.0.0.0 --port $PORT`
   - Environment Variables: Add `DATABASE_URL`
4. Deploy!

### AWS Elastic Beanstalk

```bash
# Install EB CLI
pip install awsebcli

# Initialize
eb init

# Create environment
eb create todo-app-env

# Deploy
eb deploy
```

### Google Cloud Run

```bash
# Build image
docker build -t gcr.io/PROJECT_ID/todo-app .

# Push to registry
docker push gcr.io/PROJECT_ID/todo-app

# Deploy
gcloud run deploy todo-app --image gcr.io/PROJECT_ID/todo-app --platform managed
```

## 🔧 Environment Configuration

### Production Environment Variables

Create `.env` file for production:

```bash
# Database (PostgreSQL recommended for production)
DATABASE_URL=postgresql://user:password@host:5432/dbname

# Server
HOST=0.0.0.0
PORT=8000

# Optional: For PostgreSQL
POSTGRES_USER=todo_user
POSTGRES_PASSWORD=secure_password
POSTGRES_DB=todo_db
```

### Security Considerations

1. **Database Credentials**
   - Use strong passwords
   - Don't commit `.env` to version control
   - Use secrets management (AWS Secrets Manager, etc.)

2. **CORS**
   - Restrict origins in production
   - Update `backend/main.py`:
   ```python
   app.add_middleware(
       CORSMiddleware,
       allow_origins=["https://yourdomain.com"],
       allow_credentials=True,
       allow_methods=["*"],
       allow_headers=["*"],
   )
   ```

3. **HTTPS**
   - Always use HTTPS in production
   - Set up SSL certificates (Let's Encrypt, etc.)

## 📊 Database Setup

### PostgreSQL Production Setup

```bash
# Using Docker
docker run -d \
  --name todo-postgres \
  -e POSTGRES_USER=todo_user \
  -e POSTGRES_PASSWORD=secure_password \
  -e POSTGRES_DB=todo_db \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:16-alpine

# Connect string
DATABASE_URL=postgresql://todo_user:secure_password@localhost:5432/todo_db
```

### Managed PostgreSQL Services

- **AWS RDS**: Fully managed PostgreSQL
- **Google Cloud SQL**: Managed database service
- **Heroku Postgres**: Easy PostgreSQL hosting
- **Supabase**: Open source PostgreSQL alternative
- **Neon**: Serverless PostgreSQL

## 🔍 Monitoring

### Health Checks

The application includes a health check endpoint:

```bash
curl http://your-domain.com/health
```

Response: `{"status": "healthy"}`

### Logging

Enable logging in production:

```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
```

### Monitoring Tools

- **Sentry**: Error tracking
- **Datadog**: Full-stack monitoring
- **Prometheus + Grafana**: Metrics and visualization
- **Uptime Robot**: Uptime monitoring

## 🔄 CI/CD

### GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          
      - name: Run tests
        run: make test
        
      - name: Deploy to production
        run: |
          # Your deployment commands here
          # e.g., docker push, eb deploy, etc.
```

## 📈 Scaling

### Horizontal Scaling

```bash
# Run with multiple workers
uvicorn backend.main:app --workers 4 --host 0.0.0.0 --port 8000

# Or behind a load balancer
uvicorn backend.main:app --workers $(nproc)
```

### Vertical Scaling

- Increase instance size
- Add more CPU/RAM
- Use SSD storage for database

### Caching

Add Redis caching for frequently accessed data:

```python
import redis

r = redis.Redis(host='localhost', port=6379, db=0)

# Cache todos
def get_todos_cached():
    cached = r.get('todos')
    if cached:
        return json.loads(cached)
    todos = get_todos()
    r.setex('todos', 60, json.dumps(todos))
    return todos
```

## 🔒 Security Best Practices

1. **Environment Variables**
   - Never commit `.env` files
   - Use secrets management
   - Rotate credentials regularly

2. **Dependencies**
   - Keep dependencies updated
   - Run `pip audit` regularly
   - Use `safety` to check for vulnerabilities

3. **Authentication** (if adding later)
   - Use JWT tokens
   - Implement rate limiting
   - Add CSRF protection
   - Secure headers (Helmet.js)

4. **Database**
   - Use parameterized queries (SQLAlchemy handles this)
   - Regular backups
   - Encrypted connections (SSL)

## 📦 Backup Strategy

### Database Backups

```bash
# PostgreSQL
pg_dump -U todo_user todo_db > backup.sql

# SQLite (if using)
cp backend/todos.db backup/todos_$(date +%Y%m%d).db
```

### Automated Backups

Add to crontab:
```bash
# Daily backup at 2 AM
0 2 * * * /usr/local/bin/pg_dump -U todo_user todo_db > /backups/todo_$(date +\%Y\%m\%d).sql
```

## 🐛 Troubleshooting

### Common Issues

**Database Connection Error**
```bash
# Check PostgreSQL is running
docker ps | grep postgres

# Check logs
docker logs todo-postgres
```

**Port Already in Use**
```bash
# Find and kill process
lsof -ti:8000 | xargs kill -9
```

**Migration Issues**
```bash
# Reset database (dev only)
make db-reset
```

### Performance Issues

1. Check database indexes
2. Monitor query performance
3. Add caching
4. Scale workers
5. Optimize frontend assets

## 📞 Support

For deployment issues:
1. Check logs: `docker-compose logs -f`
2. Review this guide
3. Open a GitHub issue
4. Contact maintainers

---

Happy deploying! 🚀
