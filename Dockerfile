# Tiny static file server
FROM pierrezemb/gostatic

# Copy everything in ./public into the container
COPY soal/ /srv/http/

# Run gostatic on port 8080 (required by Fly.io)
CMD ["-port", "8080", "-fallback", "index.html"]
