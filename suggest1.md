I got suggestion to create set simple static hosting, given the warning3.md

# Dockerfile
FROM pierrezemb/gostatic
COPY public/ /srv/http/
CMD ["-port", "8080", "-fallback", "index.html"]


# fly.toml adjust
[[services]]
  internal_port = 8080
  processes = ["app"]

  [[services.ports]]
    handlers = ["http"]
    port = 80

  [[services.ports]]
    handlers = ["tls", "http"]
    port = 443
