# 1) build the Angular app (the localhost API address is swapped for a relative one at build time)
FROM node:22 AS web
WORKDIR /web
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN sed -i "s#http://127.0.0.1:8000##g" src/app/services/waste.ts
RUN npx ng build

# 2) FastAPI serves the API + the built Angular files
FROM python:3.12-slim
RUN useradd -m -u 1000 user
WORKDIR /app
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY backend/ ./
COPY --from=web /web/dist/frontend/browser ./static
COPY server.py ./
RUN chown -R user:user /app
USER user
CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "7860"]
