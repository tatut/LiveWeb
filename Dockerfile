# Build in 2 stages to minimize the size of the final docker image
# See https://docs.docker.com/develop/develop-images/multistage-build/

# Stage 1: Load project
FROM basmalltalk/pharo:9.0-image AS loader
COPY load-project.st ./
USER root
RUN pharo Pharo.image load-project.st --save --quit

# Stage 2: Copy the resulting Pharo.image with our project loaded
# into a new docker image with just the vm
FROM basmalltalk/pharo:9.0
WORKDIR /app
COPY --from=loader /opt/pharo/Pharo.image ./
COPY --from=loader /opt/pharo/Pharo.changes ./
COPY --from=loader /opt/pharo/Pharo*.sources ./
COPY start.st ./

USER root
RUN chown pharo:users /app -R

USER pharo
CMD [ "pharo", "Pharo.image", "start.st" ]
