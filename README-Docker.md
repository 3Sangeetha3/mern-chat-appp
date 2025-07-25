# MERN Chat App - Docker Setup

A fully dockerized MERN (MongoDB, Express, React, Node.js) chat application using only **FREE** services.

## 🆓 Free Services Used

| Service | Purpose | Free Tier Limits |
|---------|---------|------------------|
| **MongoDB** | Database | Local/Atlas Free (512MB) |
| **Cloudinary** | File Storage | 25GB storage, 25GB bandwidth |
| **Google AI Studio** | AI Chat Bot | 15 requests/min, 1,500/day |
| **Redis** | Session/Caching | Local (unlimited) |
| **Docker** | Containerization | Free for personal use |

## 🚀 Quick Start

### Prerequisites

- Docker Desktop installed and running
- Git (to clone the repository)

### 1. Clone and Setup

```bash
git clone <your-repo-url>
cd mern-chat-app

# Copy environment template
cp .env.example .env
```

### 2. Configure Environment

Edit `.env` file with your free service credentials:

```bash
# Google AI Studio (Free) - https://aistudio.google.com/
GENERATIVE_API_KEY=your-google-ai-key

# Cloudinary (Free) - https://cloudinary.com/
CLOUDINARY_ClOUD_NAME=your-cloud-name
CLOUDINARY_API_KEY=your-api-key
CLOUDINARY_API_SECRET=your-api-secret

# Gmail SMTP (Free)
EMAIL=your-email@gmail.com
PASSWORD=your-app-password

# JWT Secret (Generate your own)
JWT_SECRET=your-super-secret-key
```

### 3. Run the Application

```bash
# Make script executable
chmod +x docker.sh

# Build and start all services
./docker.sh build
./docker.sh start
```

### 4. Access the Application

- **Frontend**: http://localhost
- **Backend API**: http://localhost:3001
- **MongoDB**: localhost:27017
- **Redis**: localhost:6379

## 📋 Available Commands

```bash
./docker.sh build    # Build Docker images
./docker.sh start    # Start all services
./docker.sh stop     # Stop all services
./docker.sh restart  # Restart all services
./docker.sh logs     # View service logs
./docker.sh status   # Show service status
./docker.sh cleanup  # Clean up everything
./docker.sh urls     # Show service URLs
```

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │    Backend      │    │    MongoDB      │
│   (React)       │◄──►│   (Node.js)     │◄──►│   (Database)    │
│   Port: 80      │    │   Port: 3001    │    │   Port: 27017   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │              ┌─────────────────┐              │
         └──────────────►│     Redis       │◄─────────────┘
                         │   (Caching)     │
                         │   Port: 6379    │
                         └─────────────────┘
```

## 🔧 Services Configuration

### Frontend (React + Nginx)
- **Base Image**: nginx:alpine
- **Port**: 80
- **Features**: 
  - Production optimized build
  - Gzip compression
  - Security headers
  - API proxy to backend
  - Static file caching

### Backend (Node.js)
- **Base Image**: node:18-alpine
- **Port**: 3001
- **Features**:
  - Production dependencies only
  - Non-root user for security
  - Health checks
  - Auto-restart on failure

### Database (MongoDB)
- **Base Image**: mongo:6.0
- **Port**: 27017
- **Features**:
  - Persistent data storage
  - Automatic initialization
  - Performance indexes

### Cache (Redis)
- **Base Image**: redis:7-alpine
- **Port**: 6379
- **Features**:
  - Session management
  - Data persistence
  - Memory optimization

## 🛠️ Development

### Local Development with Hot Reload

```bash
# Start only database services
docker-compose up -d mongodb redis

# Run backend in dev mode
cd backend && npm run dev

# Run frontend in dev mode
cd frontend && npm start
```

### Building for Production

```bash
# Build optimized images
./docker.sh build

# Deploy to production
./docker.sh start
```

## 📊 Monitoring & Health Checks

All services include health checks:

```bash
# Check service health
docker-compose ps

# View detailed logs
./docker.sh logs

# Monitor resource usage
docker stats
```

## 🔒 Security Features

- **Non-root containers**: All services run as non-root users
- **Security headers**: Added via Nginx configuration
- **Rate limiting**: API rate limiting implemented
- **Input validation**: Server-side validation for all inputs
- **CORS protection**: Configured for frontend domain only

## 🚀 Deployment Options

### Option 1: Free Hosting Services
- **Frontend**: Netlify, Vercel, GitHub Pages
- **Backend**: Railway, Render, Heroku (free tiers)
- **Database**: MongoDB Atlas Free Tier

### Option 2: VPS Deployment
- **DigitalOcean**: $5/month droplet
- **Linode**: $5/month nanode
- **AWS EC2**: t2.micro free tier

### Option 3: Local Network
- Perfect for home/office networks
- Access via local IP address
- No internet required

## 🐛 Troubleshooting

### Common Issues

**Docker not starting:**
```bash
# Check Docker status
docker info

# Restart Docker Desktop
```

**Services not connecting:**
```bash
# Check network connectivity
docker network ls
docker network inspect mern-chat-app_chat-app-network
```

**Database connection issues:**
```bash
# Check MongoDB logs
docker-compose logs mongodb

# Test MongoDB connection
docker exec -it mongodb mongosh
```

**Port conflicts:**
```bash
# Check port usage
lsof -i :80
lsof -i :3001

# Use different ports in docker-compose.yml
```

## 📈 Performance Optimization

### For Production:
1. Enable Redis caching
2. Use CDN for static assets
3. Implement database indexing
4. Enable gzip compression
5. Use production builds

### For Development:
1. Use volume mounts for hot reload
2. Enable debug logging
3. Use development builds

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Test with Docker
5. Submit pull request

## 📄 License

This project is licensed under the MIT License.

---

**Happy Coding! 🎉**

For support, create an issue or contact the development team.
